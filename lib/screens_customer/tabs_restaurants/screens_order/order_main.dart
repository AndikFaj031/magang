// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:eatngo_thesis/components/texts.dart';
import 'package:eatngo_thesis/screens_customer/tabs_restaurants/screens_order/order_booktable.dart';
import 'package:eatngo_thesis/screens_customer/tabs_restaurants/screens_order/order_dinein.dart';
import 'package:eatngo_thesis/screens_customer/tabs_restaurants/screens_order/order_takeaway.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as map_tool;

class OrderMainPage extends StatefulWidget {
  final Map<String, dynamic> data;
  final Map<dynamic, dynamic> userData;
  const OrderMainPage({super.key, required this.data, required this.userData});

  @override
  State<OrderMainPage> createState() => _OrderMainPageState();
}

class _OrderMainPageState extends State<OrderMainPage>
    with TickerProviderStateMixin {
  late bool isInArea;
  bool isLoading = false;

  List<LatLng> polygonPoints = [
    LatLng(37.42196848343084, -122.08423649936343),
    LatLng(37.42213548845506, -122.08428196658853),
    LatLng(37.42211292023034, -122.08383013603876),
    LatLng(37.421921090045295, -122.08390686198118)
  ];

  @override
  void initState() {
    print(widget.data);
    print(widget.userData);
    // TODO: implement initState
    super.initState();
  }

  Position? position;
  LatLng? convertedPosition = LatLng(0, 0);

  void _getCurrentLocation() async {
    setState(() {
      convertedPosition = null;
    });
    Position position = await _determinePosition();
    setState(() {
      convertedPosition = LatLng(position.latitude, position.longitude);
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  void CheckUpdatedLocation(LatLng pointLatLng) {
    List<map_tool.LatLng> convatedPolygonPoints = polygonPoints
        .map((point) => map_tool.LatLng(point.latitude, point.longitude))
        .toList();

    setState(() {
      if (isInArea = map_tool.PolygonUtil.containsLocation(
          map_tool.LatLng(pointLatLng.latitude, pointLatLng.longitude),
          convatedPolygonPoints,
          false)) {
        print('in area');
        setState(() {
          isInArea = true;
          Fluttertoast.showToast(
            fontSize: 16,
            msg: 'Anda didalam area restoran',
            backgroundColor: Colors.green,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_SHORT,
          );
        });
      } else {
        isInArea = true;
        Fluttertoast.showToast(
          fontSize: 16,
          msg: 'Anda didalam area restoran',
          backgroundColor: Colors.green,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data['name']),
        actions: [
          IconButton(
              onPressed: () async {
                _getCurrentLocation();
                Future.delayed(const Duration(seconds: 5), () {
                  CheckUpdatedLocation(
                      convertedPosition!); // Prints after 1 second.
                });
                setState(() {
                  isLoading = false;
                });
              },
              icon: Icon(Icons.location_on))
        ],
      ),
     
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ContentSubtitle(title: 'Order Your Food'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ContentSubtitle(
                          title:
                              'Please choose Dine-In or Takeaway or Book a Table'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Material(
                          child: InkWell(
                            onTap: () async {
                              try {
                                if (isInArea) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OrderDineInPage(
                                              data: widget.data,
                                              userData: widget.userData)));
                                } else {
                                  Fluttertoast.showToast(
                                    fontSize: 16,
                                    msg: 'Anda diluar area restoran!!',
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    toastLength: Toast.LENGTH_SHORT,
                                  );
                                }
                              } catch (e) {
                                Fluttertoast.showToast(
                                  fontSize: 16,
                                  msg:
                                      'Tekan tombol lokasi dipojok kanan atas terlebih dahulu!!',
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  toastLength: Toast.LENGTH_SHORT,
                                );
                              }
                            },
                            child: Ink(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/btn-dine-in.jpg'))),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Material(
                          child: InkWell(
                            onTap: () async {
                              try {
                                if (isInArea) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              OrderTakeAwayPage(
                                                  data: widget.data,
                                                  userData: widget.userData)));
                                } else {
                                  Fluttertoast.showToast(
                                    fontSize: 16,
                                    msg: 'Anda diluar area restoran!!',
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    toastLength: Toast.LENGTH_SHORT,
                                  );
                                }
                              } catch (e) {
                                Fluttertoast.showToast(
                                  fontSize: 16,
                                  msg:
                                      'Tekan tombol lokasi dipojok kanan atas terlebih dahulu!!',
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  toastLength: Toast.LENGTH_SHORT,
                                );
                              }
                            },
                            child: Ink(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/btn-takeaway.jpg'))),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Material(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BookTablePage(
                                            data: widget.data,
                                            userData: widget.userData,
                                          )));
                            },
                            child: Ink(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/btn-book.jpg'))),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
          convertedPosition == null
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
      ),
    );
  }
}
