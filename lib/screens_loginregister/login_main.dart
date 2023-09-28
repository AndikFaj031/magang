// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animations/animations.dart';
import 'package:eatngo_thesis/components/buttons.dart';
import 'package:eatngo_thesis/screens_loginregister/login_customer.dart';
import 'package:eatngo_thesis/screens_loginregister/register_main.dart';
import 'package:flutter/material.dart';

class LoginMainPage extends StatefulWidget {
  const LoginMainPage({super.key});

  @override
  State<LoginMainPage> createState() => _LoginMainPageState();
}

class _LoginMainPageState extends State<LoginMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Column(mainAxisSize: MainAxisSize.min, children: []),
      ),
      body: Stack(
        children: [
          /*
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/bg-alt.jpg'),
                      fit: BoxFit.fill))),*/
          Container(
            height: 400,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.indigo,
                Colors.grey[50]!,
              ],
            )),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(
                  height: 160,
                ),
                CircleAvatar(
                  radius: 75,
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(0, 50, 17, 17),
                    radius: 90,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60.0),
                      child: Image.asset("assets/images/cteen.png"),
                    ),
                  ),
                ),
                Text(
                  "Aplikasi CTeen Online",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 3.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 90.0, vertical: 10.0),
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
                                  ButtonText: 'Login',
                                ),
                            openBuilder: (context, _) => LoginCustomerPage()),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 90.0, vertical: 10.0),
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
                                  ButtonText: 'Daftar',
                                ),
                            openBuilder: (context, _) => RegisterMainPage()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
