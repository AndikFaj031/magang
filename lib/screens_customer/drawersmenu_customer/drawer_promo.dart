import 'dart:convert';

import 'package:eatngo_thesis/components/cards.dart';
import 'package:eatngo_thesis/functions/connection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class DrawerPromoPage extends StatefulWidget {
  const DrawerPromoPage({super.key});

  @override
  State<DrawerPromoPage> createState() => _DrawerPromoPageState();
}

class _DrawerPromoPageState extends State<DrawerPromoPage> {
  List promo = [];

  Future getPromo() async {
    http.Response response;
    var url = Uri.http(ip, '/API_EatNGo/view_promo.php', {'q': '{http}'});
    try {
      response = await http.post(url);
      if (response.statusCode == 200) {
        setState(() {
          promo = json.decode(response.body);
          print(promo);
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
      print(e);
    }
  }

  @override
  void initState() {
    getPromo();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Promo & Discount')),
      body: ListView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: promo.length,
        itemBuilder: (context, index) {
          return VoucherCard(
            restoName: promo[index]['name'],
            imgStr: promo[index]['photo_url'],
            menuDesc: promo[index]['promoDesc'],
            menuName: promo[index]['promoName'],
            dateEnd: promo[index]['promoDateEnd'],
            dateStart: promo[index]['promoDateStart'],
          );
        },
      ),
    );
  }
}
