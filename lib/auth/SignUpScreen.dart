//@dart=2.9
import 'package:avionav/EmailVerification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/src/provider.dart';
import 'package:avionav/auth/LoginScreen.dart';
import 'package:avionav/auth/WelcomePage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:firebase_database/firebase_database.dart';

import '../Constants.dart';
import 'authentication_service.dart';

class SignUpScreen extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  DatabaseReference _ref;
  bool _isObscure = true;

  final _formKey = GlobalKey<FormState>();

  String _userEmail;
  String _userName;
  String _password;
  String _confirmPassword;
  String _phone;
  @override
  Widget build(BuildContext context) {
    void _trySubmitForm() {
      final bool isValid = _formKey.currentState?.validate();

      if (isValid == true) {
        debugPrint('Everything looks good!');
        debugPrint(_userEmail);
        debugPrint(_userName);
        debugPrint(_password);
        debugPrint(_confirmPassword);

        context.read<AuthenticationHelper>().signUp(
              email: _userEmail.trim(),
              password: _password.trim(),
            );
        Map<String, String> client = {
          'Full Name': _userName.toString(),
          'Email': _userEmail.toString(),
          'Phone': _phone.toString(),
          'Password': _password.toString(),
        };
        _ref.push().set(client).then((value) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Signed in sucessfully",
            style: const TextStyle(fontSize: 16),
          ),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "A problem has occured. Please try again.",
            style: const TextStyle(fontSize: 16),
          ),
        ));
      }
    }

    _ref = FirebaseDatabase.instance.ref().child('Client');
    CollectionReference client =
        FirebaseFirestore.instance.collection('Client');

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
              title: const Text("Sign up"),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RichText(
                        text: const TextSpan(
                      text: "Create an account",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: kHintTextColor,
                          letterSpacing: 2),
                    )),
                    const Padding(padding: EdgeInsets.only(bottom: 15)),
                    SizedBox(height: size.height * 0.03),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Full Name",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: kHintTextColor),
                      ),
                    ),
                    SizedBox(height: size.height * 0.0015),
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'This field is required';
                        }
                        if (value.trim().length < 4) {
                          return 'Username must be at least 4 characters in length';
                        }

                        return null;
                      },
                      onChanged: (value) => _userName = value,
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person_outlined,
                              color: kPrimaryColor),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: kPrimaryColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: kPrimaryColor)),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          hintText: "Enter your Full Name ",
                          hintStyle: TextStyle(
                              color: kHintTextColor.withOpacity(0.5),
                              fontSize: 15)),
                    ),
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
                    SizedBox(height: size.height * 0.0015),
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      controller: _emailController,
                      cursorColor: kPrimaryColor,
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
                      onChanged: (value) => _userEmail = value,
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
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 5, 20, 5),
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
                        )),
                    SizedBox(height: size.height * 0.0015),
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      cursorColor: kPrimaryColor,
                      obscureText: _isObscure,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'This field is required';
                        }
                        if (value.trim().length < 8) {
                          return 'Password must be at least 8 characters in length';
                        }

                        return null;
                      },
                      onChanged: (value) => _password = value,
                      decoration: InputDecoration(
                          prefixIcon:
                              const Icon(Icons.lock_open, color: kPrimaryColor),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: kPrimaryColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: kPrimaryColor)),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          hintText: "Enter your password ",
                          hintStyle: TextStyle(
                              color: kHintTextColor.withOpacity(0.5),
                              fontSize: 15)),
                    ),
                    SizedBox(height: size.height * 0.03),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Confirm password",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: kHintTextColor),
                      ),
                    ),
                    SizedBox(height: size.height * 0.0015),
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      cursorColor: kPrimaryColor,
                      obscureText: _isObscure,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }

                        if (value != _password) {
                          return 'Confimation password does not match the entered password';
                        }

                        return null;
                      },
                      onChanged: (value) => _confirmPassword = value,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outline,
                              color: kPrimaryColor),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: kPrimaryColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: kPrimaryColor)),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          hintText: "Reenter your password ",
                          hintStyle: TextStyle(
                              color: kHintTextColor.withOpacity(0.5),
                              fontSize: 15)),
                    ),
                    SizedBox(height: size.height * 0.03),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Phone number",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: kHintTextColor),
                      ),
                    ),
                    SizedBox(height: size.height * 0.0015),
                    IntlPhoneField(
                      style: TextStyle(color: Colors.black),
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.phone_outlined,
                              color: kPrimaryColor),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: kPrimaryColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: kPrimaryColor)),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          hintText: "Enter your phone number ",
                          hintStyle: TextStyle(
                              color: kHintTextColor.withOpacity(0.5),
                              fontSize: 15)),
                      onChanged: (value) {
                        debugPrint(value.completeNumber);
                        _phone = value.completeNumber;
                      },
                      onCountryChanged: (country) {
                        debugPrint('Country changed to: ' + country.name);
                      },
                    ),
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
                          onPressed: () {
                            _trySubmitForm();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EmailVerification()));
                          },
                          child: const Text('Register'),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: Text(
                          'Already have an account?',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kHintTextColor.withOpacity(0.5),
                              decoration: TextDecoration.underline),
                        )),
                  ],
                ),
              ),
            )));
  }
}
