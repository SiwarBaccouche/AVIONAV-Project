//@dart=2.9

import '../Constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import '../EditAirplane.dart';
import '../AddAirplane.dart';

class Airplane extends StatefulWidget {
  @override
  _AirplaneState createState() => _AirplaneState();
}

class _AirplaneState extends State<Airplane> {
  Query _ref =FirebaseDatabase.instance.ref().child('Airplane');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Airplane');

  @override
  void initState() {
    super.initState();
  }

  Widget _buildAirplaneItem({Map airplane}) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(10),
        height: 150,
        color: Colors.purple.shade50,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.airplanemode_active,
                    color: Theme.of(context).primaryColor,
                    size: 20,
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    /// type
                    airplane['Type'].toString(),
                    style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Theme.of(context).primaryColor,
                    size: 20,
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    /// owner
                    airplane['Owner'].toString(),
                    style: TextStyle(
                        fontSize: 14,
                        color: kHintTextColor,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(children: [
                Icon(
                  Icons.group_work,
                  color: Theme.of(context).primaryColor,
                  size: 20,
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  /// sensors
                  airplane['Sensors'].toString(),
                  style: TextStyle(
                      fontSize: 16,
                      color: kHintTextColor,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 15),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                GestureDetector(
                  onTap: () {
                    /// edit plane
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => EditAirplane(
                                  airplaneKey: airplane['key'],
                                )));
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text('Edit',
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    _showDeleteDialog(airplane: airplane);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.red[700],
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text('Delete',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.red[700],
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                )
              ])
            ]));
  }

  _showDeleteDialog({Map airplane}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
                'Delete ${airplane['Type']} owned by ${airplane['Owner']}'),
            content: Text('Are you sure you want to delete?'),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              FlatButton(
                  onPressed: () {
                    reference
                        .child(airplane['key'])
                        .remove()
                        .whenComplete(() => Navigator.pop(context));
                  },
                  child: Text('Delete'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Airplane list'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: _ref,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map airplane = snapshot.value;
            airplane['key'] = snapshot.key;
            return _buildAirplaneItem(airplane: airplane);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) {
              return AddAirplane();
            }),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
