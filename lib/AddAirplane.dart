//@dart=2.9

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'Constants.dart';

class AddAirplane extends StatefulWidget {
  String airplaneKey;

  AddAirplane({this.airplaneKey});

  @override
  _AddAirplaneState createState() => _AddAirplaneState();
}

class _AddAirplaneState extends State<AddAirplane> {
  TextEditingController _OwnerController = TextEditingController();
  TextEditingController _SensorController = TextEditingController();
  String _typeSelected = '';
  DatabaseReference _ref = FirebaseDatabase.instance.ref().child('Airplane');


  void _SaveAirplane() {
    Map<String, String> airplane = {
      'Owner': _OwnerController.text,
      'Sensors': _SensorController.text,
      'Type': _typeSelected.toString(),
    };
    _ref.push().set(airplane).then((value) {
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
    super.initState();

    //getContactDetail();
  }

  Widget _buildAirplaneType(String title) {
    return InkWell(
      child: Container(
        height: 40,
        width: 90,
        decoration: BoxDecoration(
          color: _typeSelected == title ? Colors.green : kPrimaryColor,
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
        title: Text('Add airplane'),
        backgroundColor: kPrimaryColor,
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25),
            TextFormField(
              controller: _OwnerController,
              decoration: InputDecoration(
                hintText: 'Enter Owner Full Name',
                prefixIcon: Icon(
                  Icons.person,
                  color: kPrimaryColor,
                  size: 30,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(15),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: kPrimaryColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: kPrimaryColor)),
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: _SensorController,
              decoration: InputDecoration(
                hintText: 'Enter Sensors equiped',
                prefixIcon: Icon(
                  Icons.group_work,
                  color: kPrimaryColor,
                  size: 30,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(15),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: kPrimaryColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: kPrimaryColor)),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildAirplaneType('Rally'),
                  SizedBox(width: 10),
                  _buildAirplaneType('Storm'),
                  SizedBox(width: 10),
                  _buildAirplaneType('Storm Century'),
                  SizedBox(width: 10),
                  _buildAirplaneType('Storm RG'),
                  SizedBox(width: 10),
                  _buildAirplaneType('Storm Fury'),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(padding: EdgeInsets.only(bottom: 10)),
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
                      onPressed: _SaveAirplane,
                      child: Text(
                        "Add Airplane",
                        style: TextStyle(
                          color: kTextColor,
                        ),
                      ),
                    )))
          ],
        ),
      ),
    );
  }


}
