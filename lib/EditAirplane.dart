//@dart=2.9

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'Constants.dart';

class EditAirplane extends StatefulWidget {
  String airplaneKey;
  String owner;
  String type;
  String mode;

  EditAirplane({this.airplaneKey,this.owner,this.type,this.mode,});

  @override
  _EditAirplaneState createState() => _EditAirplaneState();
}

class _EditAirplaneState extends State<EditAirplane> {
  final TextEditingController _OwnerController = new TextEditingController();
  final TextEditingController _SensorController = new TextEditingController();
  String _typeSelected = '';

  DatabaseReference _ref = FirebaseDatabase.instance.ref().child('Airplane');

  @override
  void initState() {
    super.initState();

    _OwnerController.text = widget.owner;
    _SensorController.text = widget.type;
    _typeSelected = widget.mode;
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
          title: Text('Update airplane'),
          backgroundColor: kPrimaryColor,
        ),
        body: Container(
          color: Colors.white,
          margin: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25),
              /// owner
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
              /// sensor
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
                        onPressed: saveAirplane,
                        child: Text(
                          "Update Airplane",
                          style: TextStyle(
                            color: kTextColor,
                          ),
                        ),
                      )))
            ],
          ),
        ));
  }

  getAirplaneDetail() async {
    DatabaseEvent snapshot = await _ref.child(widget.airplaneKey).once();

    Map airplane = snapshot.snapshot.value;

    _OwnerController.text = airplane['Owner'];

    _SensorController.text = airplane['Sensors'];

    setState(() {
      _typeSelected = airplane['Type'];
    });
  }

  void saveAirplane() {
    String owner = _OwnerController.text;
    String sensor = _SensorController.text;

    Map<String, String> airplane = {
      'Owner': owner,
      'Sensors': sensor,
      'Type': _typeSelected,
    };

    _ref.child(widget.airplaneKey).update(airplane).then((value) {
      Navigator.pop(context);
    });
  }
}
