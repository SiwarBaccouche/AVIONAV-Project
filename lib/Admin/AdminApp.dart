//@dart=2.9
import 'package:avionav/Admin/planesList.dart';
import 'package:avionav/Client/MapPage.dart';
import 'package:avionav/Models/Models.dart';
import 'package:avionav/UserProfile.dart';

import 'MapPageAdmin.dart';
import 'clientsList.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Constants.dart';

String currentUser = '';

class adminapp extends StatefulWidget {
  AvClient currentUser;
  adminapp({Key key, this.currentUser}) : super(key: key);

  @override
  State<adminapp> createState() => _adminapp();
}

class _adminapp extends State<adminapp> {
  //AvClient currentUser;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    //currentUser =widget.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: currentIndex,
            children: [
              MapPageAdmin(cu: widget.currentUser),
              Client(cu: widget.currentUser),
              AirPlaneList(cu: widget.currentUser),
              UserProfile(cu: widget.currentUser),
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
