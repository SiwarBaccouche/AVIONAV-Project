//@dart=2.9

import 'package:avionav/Constants.dart';
import 'package:avionav/MapPage.dart';
import 'package:flutter/material.dart';
import '../Constants.dart';
import 'package:avionav/auth/LoginScreen.dart';

import '../Constants.dart';
import 'SignUpScreen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: const AssetImage('assets/logoavionav.png'),
              height: size.height * 0.4,
              width: size.width * 0.7,
            ),
            Row(children: [
              SizedBox(width: size.width * 0.15),
              const Text(
                "The sky is yours! ",
                style: TextStyle(
                    color: kHintTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ]),
            SizedBox(height: size.height * 0.1),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: size.width * 0.7,
              height: size.height * 0.08,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(kPrimaryColor),
                  ),
                  child: const Text("Sign in to continue!"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const LoginScreen();
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: size.width * 0.7,
              height: size.height * 0.08,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        kPrimaryColor.withOpacity(0.7)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignUpScreen();
                        },
                      ),
                    );
                  },
                  child: const Text("Sign up"),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
