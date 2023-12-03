//@dart=2.9

import 'dart:async';

import 'package:avionav/Admin/AdminApp.dart';
import 'package:avionav/Client/ClientApp.dart';
import 'package:avionav/auth/LoginScreen.dart';
import 'package:avionav/auth/WelcomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Constants.dart';

class EmailVerification extends StatefulWidget {
  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  bool canResendEmail = false;
  Timer timer;

  @override
  void initState() {
    super.initState();
    if (!FirebaseAuth.instance.currentUser.emailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
          const Duration(seconds: 3), (_) => checkEmailVerified());
    }

    @override
    void dispose() {
      super.dispose();
      print('### timer end');
      timer?.cancel();
    }
  }

  Future checkEmailVerified() async {
    print('## checking...');
    // await FirebaseAuth.instance.currentUser.reload();

    if (FirebaseAuth.instance.currentUser.emailVerified) {
      timer.cancel();
      print('## verified ');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user.sendEmailVerification();

      canResendEmail = false;
      await Future.delayed(Duration(seconds: 30));
      canResendEmail = true;
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    timer?.cancel();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
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
                          image:
                              const AssetImage('assets/email_verification.png'),
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
