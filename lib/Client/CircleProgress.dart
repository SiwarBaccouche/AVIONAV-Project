//@dart=2.9

import 'dart:ffi' as ffi;
import 'dart:math';
import 'package:avionav/Models/Models.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import '../Constants.dart';

class CircleProgress extends CustomPainter {
  double value;
  bool isTemp;
  CircleProgress(this.value, this.isTemp);

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    int maximumValue =
        isTemp ? 50 : 100; // Temp's max is 50, Humidity's max is 100

    Paint outerCircle = Paint()
      ..strokeWidth = 14
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke;

    Paint tempArc = Paint()
      ..strokeWidth = 14
      ..color = kPrimaryColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Paint humidityArc = Paint()
      ..strokeWidth = 14
      ..shader = const RadialGradient(
        colors: [
          Color.fromARGB(223, 245, 114, 195),
          Color.fromARGB(201, 111, 34, 169),
        ],
      ).createShader(Rect.fromCircle(
        center: new Offset(165.0, 55.0),
        radius: 180.0,
      ))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2) - 14;
    canvas.drawCircle(center, radius, outerCircle);

    double angle = 2 * pi * (value / maximumValue);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        angle, false, isTemp ? tempArc : humidityArc);
  }
}

class Dashboard extends StatefulWidget {
  AvClient cu;

  Dashboard({Key key, this.cu}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  final CircleProgress te = CircleProgress(0, false);
  final CircleProgress hu = CircleProgress(0, false);
  final TextEditingController temCont = TextEditingController();
  final TextEditingController humCont = TextEditingController();
  final TextEditingController doorCont = TextEditingController();

  AnimationController progressController;
  Animation<double> tempAnimation;
  Animation<double> humidityAnimation;
  String l;
  double temp;
  var tem = '', humid = '', door = '';
  double t, h;
  String doorState;

  @override
  _DashboardInit(double temp, double humidity) {
    progressController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 5000)); //5s

    tempAnimation =
        Tween<double>(begin: 0, end: temp).animate(progressController)
          ..addListener(() {
            setState(() {});
          });

    humidityAnimation =
        Tween<double>(begin: 0, end: humidity).animate(progressController)
          ..addListener(() {
            setState(() {});
          });

    progressController.forward();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      DatabaseReference ref1 =
          FirebaseDatabase.instance.ref('/Airplane/DHT22/tem');
      DatabaseReference ref2 =
          FirebaseDatabase.instance.ref('/Airplane/DHT22/hum');
      DatabaseReference ref3 = FirebaseDatabase.instance
          .ref('/Airplane/-N3o-8kRpDHNZcpOfjjU/DoorState');

      ref1.onValue.listen((DatabaseEvent event) {
        var data = event.snapshot.value.toString();

        tem = data;
        temCont.text = tem.toString();

        t = double.parse(tem);
        te.value = t;
      });
      ref2.onValue.listen((DatabaseEvent event) {
        var data = event.snapshot.value.toString();

        humid = data;
        humCont.text = humid.toString();

        h = double.parse(humid);
        hu.value = h;
      });

      // doorCont.text = door.toString();
    });
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              title: const Text("Dashboard"),
              centerTitle: true,
            ),
            body: ListView(shrinkWrap: true, children: <Widget>[
              const Padding(padding: const EdgeInsets.only(top: 50)),
              Align(
                  alignment: Alignment.topCenter,
                  child: Column(children: [
                    Row(children: [
                      const SizedBox(width: 40),
                      const Text('Door State',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: kHintTextColor)),
                      const SizedBox(width: 40),
                      LiteRollingSwitch(
                        value: false,
                        textOn: 'Closed',
                        textOff: 'Open',
                        colorOn: Colors.greenAccent[700],
                        colorOff: Colors.redAccent[700],
                        iconOn: Icons.done,
                        iconOff: Icons.remove_circle_outline,
                        textSize: 16.0,
                        onChanged: (bool state) async {
                          DatabaseReference ref = FirebaseDatabase.instance
                              .ref("/Airplane/-N3o-8kRpDHNZcpOfjjU/DoorState");

                          await ref.update({
                            "/Airplane/-N3o-8kRpDHNZcpOfjjU/DoorState":
                                state ? 'ON' : 'OFF',
                          });
                          //Use it to manage the different states
                          print('Current State of SWITCH IS: $state');
                        },
                      ),
                    ]),

                    const Padding(padding: EdgeInsets.only(top: 30)),
                    //   getTemp(),
                    Align(
                        alignment: Alignment.center,
                        child: Container(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            /// temperature

                            Row(children: [
                              const SizedBox(width: 40),
                              const Text('Temperature',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: kHintTextColor)),
                              const SizedBox(width: 20),
                              CustomPaint(
                                foregroundPainter: te,
                                child: Container(
                                  width: 150,
                                  height: 150,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        TextField(
                                          decoration: new InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          textAlign: TextAlign.center,
                                          enabled: false,
                                          controller: temCont,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: kHintTextColor),
                                        ),
                                        Text(
                                          '°C',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: kHintTextColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ]),
                            const Padding(
                                padding: const EdgeInsets.only(top: 30)),

                            /// humidity
                            Row(children: [
                              const SizedBox(width: 40),
                              const Text('Humidity',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: kHintTextColor)),
                              const SizedBox(width: 50),
                              CustomPaint(
                                foregroundPainter: hu,
                                child: Container(
                                  width: 150,
                                  height: 150,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        TextField(
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          textAlign: TextAlign.center,
                                          enabled: false,
                                          controller: humCont,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: kHintTextColor),
                                        ),
                                        Text(
                                          '%',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: kHintTextColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ],
                        )))
                  ]))
            ])));
  }
}
