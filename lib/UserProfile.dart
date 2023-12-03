//@dart=2.9

import 'package:avionav/EmailVerification.dart';
import 'package:avionav/auth/WelcomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth/authentication_service.dart';
import 'Constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Admin {
  String fullname;
  String phone;
  String email;
  String role;
  Admin(String a, String b, String c, String d) {
    fullname = a;
    phone = b;
    email = c;
    role = d;
  }
}

String currentUser = '';

DataSnapshot d;

List<Admin> l_profile = [];
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
          element.child("Role").value));
    });
  });
}

class UserProfile extends StatefulWidget {
  UserProfile(String a) {
    currentUser = a;
    result(l_profile);
  }

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  /*adminApp(String s) {
    currentUser = s;
  }*/

  @override
  String _name = currentUser;
  String _email = "";
  String _phone = "";
  String _role = "Client";

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future logout() async {
    await _firebaseAuth.signOut().then((value) => Navigator.of(context)
        .pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => WelcomeScreen()),
            (route) => false));
  }

  Widget build(BuildContext context) {
    setState(() {
      print("current user profile" + currentUser);

      l_profile.forEach((element) {
        if (element.fullname == currentUser) {
          _name = element.fullname;
          _email = element.email;
          _phone = element.phone;

          if (element.role == "Admin") {
            _role = element.role;
          } else {
            _role = "User";
          }
        }
      });
      print("name: " + _name + " email: " + _email);
    });
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColor,
          title: const Text("Profile"),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 38, 10, 10),
            child: ListView(children: [
              buildHeader(
                  name: _name, email: _email, phone: _phone, role: _role),
              const SizedBox(height: 30),
              ButtonTheme(
                minWidth: 200.0,
                height: 45.0,
                child: RaisedButton(
                  color: kPrimaryColor.withOpacity(0.8),
                  onPressed: () {
                    // signOut();
                    // context.read<AuthenticationHelper>().signOut();

                    logout();
                  },
                  child: Text(
                    "Sign out",
                    style: TextStyle(
                      color: kTextColor,
                    ),
                  ),
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: kPrimaryColor.withOpacity(0.5))),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
            ]),
          ),
        ));
  }

  Widget buildHeader(
          {String urlImage, String name, String email, String phone, String role
          // voidCallback onClicked,
          }) =>
      InkWell(
        //onTap: onClicked,
        child: Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              const SizedBox(height: 30),
              Text(
                name.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: kHintTextColor),
              ),
              const SizedBox(height: 30),
              Row(children: [
                SizedBox(width: 20),
                Text(
                  "Email: ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: kHintTextColor),
                ),
                Text(
                  email.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: kHintTextColor),
                ),
              ]),
              const SizedBox(height: 20),
              Row(children: [
                SizedBox(width: 20),
                Text(
                  "Phone: ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: kHintTextColor),
                ),
                Text(
                  phone.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: kHintTextColor),
                ),
              ]),
              const SizedBox(height: 20),
              Row(children: [
                SizedBox(width: 20),
                Text(
                  "Privilege:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: kHintTextColor),
                ),
                Text(
                  role.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: kHintTextColor),
                ),
              ]),
            ])),
      );
}
