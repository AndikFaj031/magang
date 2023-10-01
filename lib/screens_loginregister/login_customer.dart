// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';

import 'package:eatngo_thesis/functions/connection.dart';
import 'package:eatngo_thesis/screens_customer/mainmenu_customer.dart';
import 'package:eatngo_thesis/screens_loginregister/register_main.dart';
import 'package:eatngo_thesis/screens_restaurant/mainmenu_restaurant.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginCustomerPage extends StatefulWidget {
  const LoginCustomerPage({Key? key}) : super(key: key);

  @override
  State<LoginCustomerPage> createState() => _LoginCustomerPageState();
}

class _LoginCustomerPageState extends State<LoginCustomerPage> {
  final _formKey = GlobalKey<FormState>();
  String? emailLogin, password, errormsg;
  bool? error, isLoading;
  List dataUser = [];

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  void autoLoginChecker() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('username'));
    if (prefs.getString('username') != null) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        emailLogin = prefs.getString('username')!;
        password = prefs.getString('password')!;
      });
      login();
    }
  }

  void login() async {
    http.Response response;
    try {
      var url = Uri.parse('$ip/API_EatNGo/login.php');
      print(url);
      response = await http.post(url, body: {
        "email": emailLogin,
        "password": password,
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data["error"]) {
          setState(() {
            isLoading = false;
            error = true;
            errormsg = data['message'];
            Fluttertoast.showToast(
              msg: errormsg!,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              toastLength: Toast.LENGTH_SHORT,
            );
          });
        } else {
          if (data["success"]) {
            setState(() {
              error = false;
              isLoading = false;
            });

            Fluttertoast.showToast(
              msg: 'Login Successful',
              backgroundColor: Colors.green,
              textColor: Colors.white,
              toastLength: Toast.LENGTH_SHORT,
            );
            if (data['role'] == 'customer') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MainMenuCustomer(
                    data: data,
                  ),
                ),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MainMenuRestaurant(
                    userData: data,
                  ),
                ),
              );
            }
          } else {
            isLoading = false;
            error = true;
            errormsg = "Something went wrong.";
            Fluttertoast.showToast(
              backgroundColor: Colors.red,
              textColor: Colors.white,
              msg: errormsg!,
              toastLength: Toast.LENGTH_SHORT,
            );
          }
        }
      } else {
        Fluttertoast.showToast(
          backgroundColor: Colors.red,
          textColor: Colors.white,
          msg: response.statusCode.toString(),
          toastLength: Toast.LENGTH_SHORT,
        );
      }

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('username', emailLogin!);
      prefs.setString('password', password!);
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  @override
  void initState() {
    autoLoginChecker();
    errormsg = "";
    error = false;
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Stack(
              children: [
                Column(children: [
                  Image.asset(
                    "assets/images/ten.png",
                    width: 420,
                    height: 322,
                    fit: BoxFit.cover,
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.all(50),
                  child: Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 270,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 6.0),
                            child: Material(
                              child: TextFormField(
                                controller: emailController,
                                onChanged: (value) {
                                  setState(() {
                                    emailLogin = value;
                                  });
                                },
                                autofocus: false,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(90.0),
                                  ),
                                  labelText: 'Email',
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 2.0),
                            child: Material(
                              shadowColor: Colors.black,
                              child: TextFormField(
                                controller: passController,
                                onChanged: (value) {
                                  setState(() {
                                    password = value;
                                  });
                                },
                                obscureText: true,
                                autofocus: false,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(90.0),
                                  ),
                                  labelText: 'Password',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: SizedBox(
                                width: 200,
                                height: 40,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ))),
                                  onPressed: () {
                                    if (emailController.text == '' ||
                                        passController.text == '') {
                                      Fluttertoast.showToast(
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        msg: 'Silahkan isi Email and Password',
                                        toastLength: Toast.LENGTH_SHORT,
                                      );
                                    } else {
                                      login();
                                    }
                                  },
                                  child: Text(
                                    'LOG IN',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.all(15.0),
                              child: RichText(
                                text: TextSpan(
                                  text: "Belum punya akun?",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                      style: TextStyle(color: Colors.indigo),
                                      text: ' Klik Disini',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap =
                                            () => Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        RegisterMainPage(),
                                                  ),
                                                ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            isLoading!
                ? Container(
                    color: Colors.grey.withOpacity(0.5),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
