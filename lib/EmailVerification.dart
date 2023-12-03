//@dart=2.9

import 'dart:async';

import 'package:avionav/AdminApp.dart';
import 'package:avionav/ClientApp.dart';
import 'package:avionav/auth/LoginScreen.dart';
import 'package:avionav/auth/WelcomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Constants.dart';

String currentUser = '';

class EmailVerification extends StatefulWidget {
  EmailVerification() {}

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  // bool isEmailVerified;
  bool canResendEmail = false;
  Timer timer;
  bool isEmailVerified = FirebaseAuth.instance.currentUser.emailVerified;
  @override
  void initState() {
    super.initState();
    isEmailVerified;
    if (isEmailVerified == false) {
      sendVerificationEmail();
      timer = Timer.periodic(
          const Duration(seconds: 3), (_) => checkEmailVerified());
    }

    @override
    void dispose() {
      timer?.cancel();
      super.dispose();
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser.reload();
    setState(() {
      isEmailVerified;
    });
    if (isEmailVerified) timer.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 30));
      setState(() => canResendEmail = true);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (isEmailVerified == true) {
      return LoginScreen();
    } else {
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
                              builder: (context) => const LoginScreen()));
                    }),
                title: const Text("Back"),
                centerTitle: false,
              ),
              body: SingleChildScrollView(
                  padding: const EdgeInsets.all(15),
                  child: Column(children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(padding: EdgeInsets.only(bottom: 15)),
                          RichText(
                              text: const TextSpan(
                            text: "Email Verification",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: kHintTextColor,
                                letterSpacing: 2),
                          )),
                          const Padding(padding: EdgeInsets.only(bottom: 15)),
                          Image(
                            image: const AssetImage(
                                'assets/email_verification.png'),
                            height: size.height * 0.4,
                            width: size.width * 0.7,
                          ),
                          const Text(
                            " A verification link has been sent to your email address.",
                            style: TextStyle(
                              fontSize: 14,
                              color: kHintTextColor,
                            ),
                          ),
                          const Padding(
                              padding: const EdgeInsets.only(bottom: 10)),
                          const Text(
                            " Please click resend if you did not receive the email.",
                            style: TextStyle(
                              fontSize: 14,
                              color: kHintTextColor,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 20)),
                        ]),
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
                          onPressed: () {
                            canResendEmail ? sendVerificationEmail : null;
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text(
                                "Press resend in 30 seconds if you did not recieve an email.",
                                style: TextStyle(fontSize: 16),
                              ),
                            ));
                          },
                          child: const Text('Resend link'),
                        ),
                      ),
                    )
                  ]))));
    }
  }
}
