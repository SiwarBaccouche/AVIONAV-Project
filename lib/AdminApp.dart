//@dart=2.9
import 'package:avionav/EmailVerification.dart';
import 'package:avionav/MapPage.dart';
import 'package:avionav/UserProfile.dart';

import 'Admin/ClientList.dart';
import 'Admin/AirplaneList.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Constants.dart';

String currentUser = '';

class adminapp extends StatefulWidget {
  adminapp(String s) {
    currentUser = s;
  }
  @override
  State<adminapp> createState() => _adminapp();
}

class _adminapp extends State<adminapp> {
  int currentIndex = 0;
  // List listOfColors = [
  //   MapPage(),
  //   Client(),
  //   Airplane(),
  //   UserProfile(currentUser),
  // ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: currentIndex,
            children: [
              MapPage(),
              Client(),
              Airplane(),
              UserProfile(currentUser),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          backgroundColor: kPrimaryColor,
          selectedIndex: currentIndex,
          animationDuration: const Duration(milliseconds: 650),
          onItemSelected: (index) {
            setState(
              () {
                currentIndex = index;
              },
            );
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: const Icon(Icons.map_outlined),
              title: const Text("Map"),
              activeColor: Colors.white,
              inactiveColor: Colors.white.withOpacity(0.5),
            ),
            BottomNavyBarItem(
              icon: const Icon(
                Icons.group_add_sharp,
              ),
              title: const Text("Clients"),
              activeColor: Colors.white,
              inactiveColor: Colors.white.withOpacity(0.5),
            ),
            BottomNavyBarItem(
              icon: const Icon(
                Icons.airplanemode_active_outlined,
              ),
              title: const Text("Aircrafts"),
              activeColor: Colors.white,
              inactiveColor: Colors.white.withOpacity(0.5),
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.house),
              title: const Text("Profile"),
              activeColor: Colors.white,
              inactiveColor: Colors.white.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    String urlImage,
    String name,
    String email,
    // voidCallback onClicked,
  }) =>
      InkWell(
        //onTap: onClicked,

        child: Row(
          children: [
            CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  urlImage,
                )),
            const SizedBox(
              width: 30,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: kTextColor),
              ),
              const SizedBox(height: 4),
              Text(
                email,
                style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: kTextColor),
              ),
            ])
          ],
        ),
      );
}
