//@dart=2.9
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'Constants.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'utils.dart';

class Remote extends StatefulWidget {
  @override
  State<Remote> createState() => _RemoteState();
}

class _RemoteState extends State<Remote> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              title: Text('Lighting Remote'),
              centerTitle: true,
            ),
            body: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(top: 15, left: 20.0, right: 20.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 35, bottom: 20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              RemoteButton("remoteOne", 3),
                              RemoteButton("remoteOne", 2),
                              RemoteButton("remoteOne", 0),
                              RemoteButton("remoteOne", 1),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              RemoteButton("remoteOne", 4),
                              RemoteButton("remoteOne", 5),
                              RemoteButton("remoteOne", 6),
                              RemoteButton("remoteOne", 7),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              RemoteButton("remoteOne", 12),
                              RemoteButton("remoteOne", 16),
                              RemoteButton("remoteOne", 20),
                              RemoteButton("remoteOne", 8),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              RemoteButton("remoteOne", 13),
                              RemoteButton("remoteOne", 17),
                              RemoteButton("remoteOne", 21),
                              RemoteButton("remoteOne", 9),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              RemoteButton("remoteOne", 14),
                              RemoteButton("remoteOne", 18),
                              RemoteButton("remoteOne", 22),
                              RemoteButton("remoteOne", 10),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              RemoteButton("remoteOne", 15),
                              RemoteButton("remoteOne", 19),
                              RemoteButton("remoteOne", 23),
                              RemoteButton("remoteOne", 11),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ))));
  }
}

class RemoteButton extends StatelessWidget {
  final getRemote;
  final getIndex;
  RemoteButton(this.getRemote, this.getIndex);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0),
            child: Container(
              width: 50,
              child: RawMaterialButton(
                onPressed: () async {
                  var color =
                      (remoteData[getRemote][getIndex]["color"]).toString();
                  DatabaseReference ref =
                      FirebaseDatabase.instance.ref("Client/Lighting/");
                  await ref.update({
                    "Lighting": color,
                  });
                  //Use it to manage the different states
                  print('Current Lighting Color IS: $color');

                  //      await IrSensorPlugin.transmitString(
                  //         pattern: remoteData[getRemote][getIndex]["pattern"]);
                },
                elevation: 2.0,
                fillColor: HexColor(remoteData[getRemote][getIndex]["color"]),
                child: Icon(remoteData[getRemote][getIndex]["icon"],
                    size: 30.0, color: Colors.white),
                padding: EdgeInsets.all(10.0),
                shape: CircleBorder(),
              ),
            )));
  }
}
