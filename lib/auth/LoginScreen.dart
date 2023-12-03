//@dart=2.9

//import 'dart:js';

import 'dart:io';

import 'package:avionav/AdminApp.dart';
import 'package:avionav/ClientApp.dart';
//import 'package:avionavpfe/EmailVerification.dart';
//import 'package:avionavpfe/MapPage.dart';
import 'package:avionav/auth/ResetPassword.dart';
import 'package:avionav/auth/WelcomePage.dart';
import 'package:avionav/auth/authentication_service.dart';
//import 'package:avionavpfe/authentication_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SignUpScreen.dart';
//import 'authentication_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class Admin {
  String fullname;
  String phone;
  String email;
  String role;
  String pwd;

  Admin(
    String a,
    String b,
    String c,
    String d,
    String e,
  ) {
    fullname = a;
    phone = b;
    email = c;
    role = d;
    pwd = e;
  }
}

String currentUser = '';

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _login = new TextEditingController();
  final TextEditingController _pswd = new TextEditingController();
  //AuthenticationHelper ah = new AuthenticationHelper(_auth);
  List<Admin> l_admin = [];
  result(List<Admin> l) {
    DatabaseReference db = FirebaseDatabase.instance.ref('Client');
    l.clear();
    db.onValue.listen((e) {
      d = e.snapshot;
      d.children.forEach((element) {
        l.add(new Admin(
          element.child("Full Name").value,
          element.child("Phone").value,
          element.child("Email").value,
          element.child("Role").value,
          element.child("Password").value,
        ));
      });
    });
  }

  //handle remember me function
  void _handleRemeberme(bool value) {
    _isChecked = value;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('email', _login.text);
        prefs.setString('password', _pswd.text);
      },
    );
    setState(() {
      _isChecked = value;
    });
  }

  DataSnapshot d;
  String email, password;
  bool _isObscure = true;
  bool admin = false;

  void signin(String l, String p, List<Admin> m) {
    bool admin = false;
    m.forEach((element) {
      if (element.email == l && element.pwd == p) {
        if (element.role == "Admin") {
          admin = true;
        }

        currentUser = element.fullname;
      }
    });

    if (admin == true) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => adminapp(currentUser)));
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return clientapp(currentUser);
          },
        ),
      );
    }
  }

  @override
  bool _isChecked = false;
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    setState(() {
      result(l_admin);
    });
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WelcomeScreen()));
                }),
            title: const Text("Login"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Padding(padding: EdgeInsets.only(bottom: 15)),
                  SizedBox(height: size.height * 0.03),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Email",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: kHintTextColor),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  TextFormField(
                    controller: _login,
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email address';
                      }

                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }

                      return null;
                    },
                    onSaved: (val) {
                      email = val;
                    },
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email_outlined,
                            color: kPrimaryColor),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: kPrimaryColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: kPrimaryColor)),
                        contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        hintText: "Enter your Email ",
                        hintStyle: TextStyle(
                            color: kHintTextColor.withOpacity(0.5),
                            fontSize: 15)),
                  ),
                  SizedBox(height: size.height * 0.03),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Password",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: kHintTextColor),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  TextFormField(
                    controller: _pswd,
                    style: const TextStyle(color: Colors.black),
                    onSaved: (val) {
                      password = val;
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a valid password';
                      }
                      return null;
                    },
                    cursorColor: kPrimaryColor,
                    obscureText: _isObscure,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: Icon(
                                _isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: _isObscure
                                    ? kHintTextColor.withOpacity(0.3)
                                    : kPrimaryColor.withOpacity(0.7)),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            }),
                        prefixIcon: const Icon(Icons.lock_outline,
                            color: kPrimaryColor),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: kPrimaryColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: kPrimaryColor)),
                        contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        hintText: "Enter your password ",
                        hintStyle: TextStyle(
                            color: kHintTextColor.withOpacity(0.5),
                            fontSize: 15)),
                  ),
                  SizedBox(height: size.height * 0.03),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResetPassword()));
                      },
                      child: Row(children: const [
                        //   SizedBox(width: size.width * 0.4),
                        Text(
                          "Forgot pasword?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                              decoration: TextDecoration.underline),
                        )
                      ])),
                  Padding(padding: EdgeInsets.only(bottom: 10)),
                  Row(children: [
                    Checkbox(
                        side: BorderSide(
                          color: kPrimaryColor,
                          width: 2,
                        ),
                        activeColor: kPrimaryColor.withOpacity(0.7),
                        value: _isChecked,
                        onChanged: _handleRemeberme),
                    SizedBox(width: 10),
                    Text("Remember Me",
                        style: TextStyle(
                            color: kHintTextColor,
                            fontSize: 12,
                            fontFamily: 'Rubic')),
                  ]),
                  SizedBox(height: size.height * 0.03),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: size.width * 0.9,
                    height: size.height * 0.08,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(kPrimaryColor),
                        ),
                        onPressed: () async {
                          /*   context.read<AuthenticationHelper>().signIn(
                                email: _login.text.trim(),
                                password: _pswd.text.trim(),
                              );
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                          */
                          /* context.read<AuthenticationHelper>().signIn(
                                email: _login.text.trim(),
                                password: _pswd.text.trim(),
                              );*/
                          print("adm1" + admin.toString());
                          signin(_login.text, _pswd.text, l_admin);
                          //    print("adm2" + currentUser);
                          /* if (admin == true) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return adminapp(currentUser);
                                },
                              ),
                            );
                          } else if (admin == false) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return EmailVerification(currentUser);
                                },
                              ),
                            );
                          }*/
                        },
                        child: const Text('Log in'),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Text(
                    "You don't have an account?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kHintTextColor.withOpacity(0.7),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()));
                      },
                      child: const Text(
                        "Create one",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kHintTextColor,
                            decoration: TextDecoration.underline),
                      )),
                ],
              ),
            ),
          )),
    );
  }
}
