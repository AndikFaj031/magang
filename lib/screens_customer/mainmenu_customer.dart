// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:eatngo_thesis/components/cards.dart';
import 'package:eatngo_thesis/components/texts.dart';
import 'package:eatngo_thesis/drawers/maindrawer.dart';
import 'package:eatngo_thesis/functions/connection.dart';
import 'package:eatngo_thesis/screens_customer/tabs_restaurants/screens_order/order_dinein.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class MainMenuCustomer extends StatefulWidget {
  final Map data;
  const MainMenuCustomer({super.key, required this.data});

  @override
  State<MainMenuCustomer> createState() => _MainMenuCustomerState();
}

class _MainMenuCustomerState extends State<MainMenuCustomer> {
  List dataRestoran = [];
  List dataRestoranSearch = [];
  bool isLoading = false;

  Future getRestaurantSearch() async {
    http.Response response;
    var url = Uri.parse('$ip/API_EatNGo/view_restaurant.php');
    setState(() {
      isLoading = true;
    });
    try {
      response = await http.post(url, body: {
        "search": searchText,
      });
      if (response.statusCode == 200) {
        setState(() {
          dataRestoranSearch = json.decode(response.body);
        });
      } else {
        return Fluttertoast.showToast(
          backgroundColor: Colors.red,
          textColor: Colors.white,
          msg: 'Something went wrong',
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    } catch (e) {
      setState(() {
        //isLoading = false;
      });
      Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'Error!! Check your connection',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  Future getRestaurant() async {
    http.Response response;
    var uri = Uri.parse('$ip/API_EatNGo/view_restaurant.php');
    setState(() {
      isLoading = true;
    });
    try {
      response = await http.post(uri, body: {
        "search": '',
      });
      if (response.statusCode == 200) {
        setState(() {
          dataRestoran = json.decode(response.body);
        });
      } else {
        return Fluttertoast.showToast(
          backgroundColor: Colors.red,
          textColor: Colors.white,
          msg: 'Something went wrong',
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    } catch (e) {
      setState(() {
        //isLoading = false;
      });
      Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'Error!! Check your connection',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  String searchText = "";

  @override
  void initState() {
    print(widget.data);
    getRestaurant();
    getRestaurantSearch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: AnimatedSearchBar(
            searchDecoration: InputDecoration(
              hintText: "Search",
              alignLabelWithHint: true,
              fillColor: Colors.white,
              focusColor: Colors.white,
              hintStyle: TextStyle(color: Colors.white70),
              border: InputBorder.none,
            ),
            searchStyle: TextStyle(color: Colors.white),
            label: "cari nama kantin",
            labelStyle: TextStyle(fontSize: 17),
            onChanged: (value) {
              setState(() {
                searchText = value;
                getRestaurantSearch();
              });
            },
          ),
        ),
        drawer: MainDrawer(data: widget.data),
        body: Stack(
          children: [
            ListView(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: ContentTitle(
                      title: 'Browse Restaurant',
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: dataRestoranSearch.length,
                  itemBuilder: (context, index) {
                    return RestaurantMainCard(
                      imgStr: dataRestoranSearch[index]['photo_url'],
                      restaurantName: dataRestoranSearch[index]['name'],
                      restaurantAddress: dataRestoranSearch[index]['address'],
                      restaurantRating: double.parse(
                        dataRestoranSearch[index]['rating'],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderDineInPage(
                              userData: widget.data,
                              data: dataRestoranSearch[index],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            isLoading
                ? Container(
                    color: Colors.grey.withOpacity(0.5),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.indigo.shade400,
                        strokeWidth: 5,
                      ),
                    ),
                  )
                : Container()
          ],
        ));
  }
}

/*
ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderStatusPage(
                            isFromOrder: false,
                          ),
                        ),
                      );
                    },
                    child: Text('My Order')),
                    */