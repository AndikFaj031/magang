// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animations/animations.dart';
import 'package:eatngo_thesis/components/buttons.dart';
import 'package:eatngo_thesis/screens_loginregister/login_customer.dart';
import 'package:eatngo_thesis/screens_loginregister/register_customer.dart';
import 'package:eatngo_thesis/screens_loginregister/register_restaurant.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterMainPage extends StatefulWidget {
  const RegisterMainPage({super.key});

  @override
  State<RegisterMainPage> createState() => _RegisterMainPageState();
}

class _RegisterMainPageState extends State<RegisterMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[50]!,
        elevation: 0,
        //
      ),
      body: Stack(
        children: [
          Container(
            child: Column(children: [
              Image.asset(
                "assets/images/ten.png",
                width: 420,
                height: 322,
                fit: BoxFit.cover,
              ),
            ]),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(
                  height: 260,
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 30.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 40.0, vertical: 5.0),
                        child: OpenContainer(
                            transitionType: ContainerTransitionType.fadeThrough,
                            closedShape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            transitionDuration: Duration(seconds: 1),
                            closedBuilder: (context, _) =>
                                AnimatedPrimaryButton(
                                  ButtonText: 'Pelanggan',
                                ),
                            openBuilder: (context, _) =>
                                RegisterCustomerpage()),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.0),
                        child: OpenContainer(
                            transitionType: ContainerTransitionType.fadeThrough,
                            closedShape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            transitionDuration: Duration(seconds: 1),
                            closedBuilder: (context, _) =>
                                AnimatedSecondaryButton(
                                  ButtonText: 'Kantin',
                                ),
                            openBuilder: (context, _) =>
                                RegisterRestaurantPage()),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(15.0),
                    child: RichText(
                      text: TextSpan(
                        text: "Sudah punya akun?",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            style: TextStyle(color: Colors.indigo),
                            text: ' Klik disini',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginCustomerPage(),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
