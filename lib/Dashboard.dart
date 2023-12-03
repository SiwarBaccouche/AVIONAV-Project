//@dart=2.9
/*
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

import 'Constants.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  String _temp;
  String _hum;

//  final _database = FirebaseDatabase.instance.ref().child('DHT22/Temperature');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: ListView(children: <Widget>[
      Padding(padding: EdgeInsets.only(top: 30)),
      Column(
        children: [
          Align(
              alignment: Alignment.topCenter,
              child: Row(children: [
                SizedBox(width: 40),
                Text('Door State',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kHintTextColor)),
                SizedBox(width: 40),
                LiteRollingSwitch(
                  //initial value
                  value: true,
                  textOn: 'Closed',
                  textOff: 'Open',
                  colorOn: Colors.greenAccent[700],
                  colorOff: Colors.redAccent[700],
                  iconOn: Icons.done,
                  iconOff: Icons.remove_circle_outline,
                  textSize: 16.0,
                  onChanged: (bool state) {
                    //Use it to manage the different states
                    print('Current State of SWITCH IS: $state');
                  },
                ),
              ])),
          Padding(padding: EdgeInsets.only(top: 30)),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.8,
              child: 
              
              
              
              
              
              
              
              
              
              SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(pointers: <GaugePointer>[
                    RangePointer(
                      value: 18,
                      //DatabaseEvent value = await ref.once(),
                      cornerStyle: CornerStyle.bothCurve,
                      gradient: const SweepGradient(
                          colors: <Color>[Color(0xFFCC2B5E), Color(0xFF753A88)],
                          stops: <double>[0.25, 0.75]),
                      enableAnimation: true,
                    ),
                  ], annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                        widget: Container(
                            child: Text('30',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: kHintTextColor))),
                        angle: 90,
                        positionFactor: 0.5)
                  ]),
                ],
              ),
            ),
          ),
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(pointers: <GaugePointer>[
                        RangePointer(
                          value: 50,
                          //DatabaseEvent value = await ref.once(),
                          cornerStyle: CornerStyle.bothCurve,
                          gradient: const SweepGradient(colors: <Color>[
                            Color(0xFFCC2B5E),
                            Color(0xFF753A88)
                          ], stops: <double>[
                            0.25,
                            0.75
                          ]),
                          enableAnimation: true,
                        ),
                      ], annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                            widget: Container(
                                child: Text('20',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: kHintTextColor))),
                            angle: 90,
                            positionFactor: 0.5)
                      ]),
                    ],
                  )
                  )
                  ),
        ],
      )
    ])));
  }
}
*/