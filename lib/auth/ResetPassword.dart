//@dart=2.9

import 'package:avionav/auth/WelcomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Constants.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final emailController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    void PasswordReset() async {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Password reset email sent.',
              style: TextStyle(fontSize: 16),
            ),
          ),
        );

        Navigator.of(context).popUntil((route) => route.isActive);
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            e.message,
            style: const TextStyle(fontSize: 16),
          ),
        ));
      }
    }

    Size size = MediaQuery.of(context).size;
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
                          text: "Reset your password",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: kHintTextColor,
                              letterSpacing: 2),
                        )),
                        const Padding(padding: EdgeInsets.only(bottom: 15)),
                        Image(
                          image: const AssetImage('assets/key.png'),
                          height: size.height * 0.4,
                          width: size.width * 0.7,
                        ),
                        const Text(
                          "Enter the email associated with your account and we'll send you an email with instructions to reset your password.",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: kHintTextColor),
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 20)),
                        TextFormField(
                            style: TextStyle(color: Colors.black),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            controller: emailController,
                            cursorColor: kPrimaryColor,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.email_outlined,
                                    color: kPrimaryColor),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: kPrimaryColor)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: kPrimaryColor)),
                                contentPadding: const EdgeInsets.all(20),
                                hintText: ('enter your email'),
                                hintStyle: TextStyle(
                                    color: kHintTextColor.withOpacity(0.5),
                                    fontSize: 15))),
                        const Padding(
                            padding: const EdgeInsets.only(bottom: 10)),
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
                          PasswordReset();
                        },
                        child: const Text('Send instructions'),
                      ),
                    ),
                  )
                ]))));
  }
}
