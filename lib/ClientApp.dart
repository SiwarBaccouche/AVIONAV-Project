//@dart=2.9

import 'package:avionav/CircleProgress.dart';
import 'package:avionav/MapPage.dart';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'Constants.dart';
import 'UserProfile.dart';
import 'LightingRemote.dart';

String currentUser = '';

class clientapp extends StatefulWidget {
  clientapp(String s) {
    currentUser = s;
  }
  @override
  State<clientapp> createState() => _clientapp();
}

class _clientapp extends State<clientapp> {
  // int currentIndex = 0;
  // List listOfColors = [
  //   MapPage(),
  //   Dashboard(),
  //   Remote(),
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
              Dashboard(),
              Remote(),
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
                Icons.sensors_sharp,
              ),
              title: const Text("Sensors"),
              activeColor: Colors.white,
              inactiveColor: Colors.white.withOpacity(0.5),
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.light_mode_outlined),
              title: const Text("Lighting"),
              activeColor: Colors.white,
              inactiveColor: Colors.white.withOpacity(0.5),
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.person),
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
  }) =>
      InkWell(
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
