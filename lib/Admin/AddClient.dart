//@dart=2.9

import 'package:avionav/Models/Models.dart';

import '../Client/ClientApp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../Constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

/// add without verif
class AddClient extends StatefulWidget {
  AvClient cu;
  AddClient({Key key, this.cu}) : super(key: key);
  @override
  _AddClientState createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  FirebaseAuth auth = FirebaseAuth.instance;

  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();
  DatabaseReference _ref = FirebaseDatabase.instance.ref().child('Client');
  String _userEmail;
  String _userName;
  String _password;
  String _confirmPassword;
  String _phone;
  String _typeSelected = 'Client';

  void _trySubmitForm() async {
    final bool isValid = _formKey.currentState?.validate();

    if (isValid) {
      String adminEmail = widget.cu.email;
      String adminPwd = widget.cu.pwd;

      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _userEmail.trim(),
        password: _password.trim(),
      )
          .then((value) {
        /// add client to rt
        Map<String, String> client = {
          'Full Name': _userName.toString(),
          'Email': _userEmail.toString(),
          'Phone': _phone.toString(),
          'Role': _typeSelected,
          'Password': _password.toString(),
          'Planes': '',
        };
        _ref.push().set(client).then((value) async {
          print(
              '### befRef currEmail:${auth.currentUser.email}//currPass:${auth.currentUser}//');
          await auth.signOut();
          await auth.signInWithEmailAndPassword(
            email: adminEmail,
            password: adminPwd,
          );
          print(
              '### AftRef currEmail:${auth.currentUser.email}//currPass:${auth.currentUser}//');

          Navigator.pop(context);
        });
      });
    }
  }

  Future<void> refreshAdmin(admEmail, admPass) async {}

  Widget _buildClientType(String title) {
    return InkWell(
      child: Container(
        height: 40,
        width: 90,
        decoration: BoxDecoration(
          color: _typeSelected == title
              ? Colors.green
              : Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
      onTap: () {
        setState(() {
          _typeSelected = title;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Client'),
          backgroundColor: kPrimaryColor,
        ),
        body: ListView(children: <Widget>[
          Padding(padding: EdgeInsets.all(15)),
          Container(
              padding: EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Full Name",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: kHintTextColor),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 10)),

                      /// name
                      TextFormField(
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
                            prefixIcon: Icon(Icons.person_outlined,
                                color: kPrimaryColor),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: kPrimaryColor)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: kPrimaryColor)),
                            contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                            hintText: "Enter your Full Name ",
                            hintStyle: TextStyle(
                                color: kHintTextColor.withOpacity(0.5),
                                fontSize: 15)),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Email",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: kHintTextColor),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 10)),

                      /// email
                      TextFormField(
                        //controller: _emailController,
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
                            prefixIcon: Icon(Icons.email_outlined,
                                color: kPrimaryColor),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: kPrimaryColor)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: kPrimaryColor)),
                            contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                            hintText: "Enter your Email ",
                            hintStyle: TextStyle(
                                color: kHintTextColor.withOpacity(0.5),
                                fontSize: 15)),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Password",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: kHintTextColor),
                          )),
                      Padding(padding: EdgeInsets.only(bottom: 10)),

                      /// password
                      TextFormField(
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
                                Icon(Icons.lock_open, color: kPrimaryColor),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: kPrimaryColor)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: kPrimaryColor)),
                            contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                            hintText: "Enter your password ",
                            hintStyle: TextStyle(
                                color: kHintTextColor.withOpacity(0.5),
                                fontSize: 15)),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 10)),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Confirm password",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: kHintTextColor),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 10)),

                      /// pass again
                      TextFormField(
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
                            prefixIcon:
                                Icon(Icons.lock_outline, color: kPrimaryColor),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: kPrimaryColor)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: kPrimaryColor)),
                            contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                            hintText: "Reenter your password ",
                            hintStyle: TextStyle(
                                color: kHintTextColor.withOpacity(0.5),
                                fontSize: 15)),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 10)),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Phone number",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: kHintTextColor),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 10)),

                      /// phone
                      IntlPhoneField(
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone_outlined,
                                color: kPrimaryColor),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: kPrimaryColor)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: kPrimaryColor)),
                            contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),
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

                      /// admin or client
                      Container(
                        height: 40,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _buildClientType('Client'),
                            SizedBox(width: 10),
                            _buildClientType('Admin'),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 10)),

                      /// button add client
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          width: size.width * 0.9,
                          height: size.height * 0.08,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          kPrimaryColor),
                                ),
                                onPressed: _trySubmitForm,
                                child: Text(
                                  "Add Client",
                                  style: TextStyle(
                                    color: kTextColor,
                                  ),
                                ),
                              )))
                    ]),
              ))
        ]));
  }
}
