//@dart=2.9

import 'package:avionav/Models/Models.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' show cos, sqrt, asin;
import 'dart:async';
import '../Constants.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';

class MapPage extends StatefulWidget {
  static of(BuildContext context, {bool root = false}) => root
      ? context.findRootAncestorStateOfType<_MapPageState>()
      : context.findAncestorStateOfType<_MapPageState>();
  AvClient cu;
  MapPage({Key key, this.cu}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  showTos(txt) {
    Fluttertoast.showToast(
        msg: txt,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.black38,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  final MapController _mapController = MapController();

  bool trackUser = false;
  Timer _timerUser = Timer.periodic(Duration(seconds: 1), (_) {});
  Timer _timer = Timer.periodic(Duration(seconds: 1), (_) {});
  int gpsIsActive = 0;
  int secToSaveGps = 0;
  double distanceTraveled = 0;
  int TimeToUpdateGps = 1;
  int TimeToUpdateUser = 1;
  int TimeToSaveGpsPoint = 3;
  Position _currentPosition;
  String speed = '';
  String alt = '';

  /// gps marker decla
  Marker gpsMarker = Marker(
    width: 140.0,
    height: 140.0,
    point: LatLng(38.312824, -4.755971),
    builder: (ctx) => Container(),
  );

  /// user marker decla
  Marker userMarker = Marker(
    width: 140.0,
    height: 140.0,
    point: LatLng(38.312824, -4.755971),
    builder: (ctx) => Container(),
  );

  final List<LatLng> traveledRoutePolys = [];
  var gpsLat;
  var gpsLng;
  var userLat;
  var userLng;

  Future<void> requestPermissionLoc() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
  }

  listenPlane() {
    DatabaseReference starCountRef = FirebaseDatabase.instance
        .ref('/Airplane/${widget.cu.planes.toString()}');
    starCountRef.onValue.listen((DatabaseEvent event) {
      Map data = event.snapshot.value;

      print('#### getting plane props');
      speed = data['vitesse'];
      alt = data['alt'];

      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    requestPermissionLoc();
    _timerUser = Timer.periodic(Duration(seconds: TimeToUpdateGps), (t) {
      checkGpsUser();
    });
  }

  checkGpsUser() async {
    var isGpsEnabled = await Geolocator.isLocationServiceEnabled();
    if (trackUser && isGpsEnabled) {
      locateUser(true);
    }
  }

  ///Timer
  void startTimer() {
    // if gps stopped
    if (gpsIsActive == 0) {
      Fluttertoast.showToast(
          msg: "Tracking started",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);

      /// each X(1) sec update_gps >> TimeToUpdateGps
      _timer = Timer.periodic(Duration(seconds: TimeToUpdateGps), (t) {
        /// get Plane Props
        listenPlane();

        distanceTraveled = calculDist(traveledRoutePolys);

        //print(('/// dis  walked = $distanceWalked'));
        /// each X(3) sec save_gps_location >> TimeToSaveGpsPoint
        if (secToSaveGps >= TimeToSaveGpsPoint) {
          saveCurrLoc();
          secToSaveGps = 0;
          //print('#### Route Reloaded ${DateTime.now()}');
        } else {
          secToSaveGps++;
        }

        /// get the current gps loaction from fire base each 1 sec
        gpsLcation();

        print('### Timer Running ....');
      });
    } else {
      // if gps activated
      showTos('Tracking already activated');
    }
  }

  void endTimer() {
    if (gpsIsActive == 1) {
      Fluttertoast.showToast(
          msg: "Tracking stopped",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16.0);
      print('### End Timer');
      _timer.cancel();
    } else {
      showTos('Tracking stopped');
    }
  }

  @override
  void dispose() {
    print('### End Timer');

    _timer.cancel();
    _timerUser.cancel();

    super.dispose();
  }

  double calculDist(List<LatLng> polyline) {
    double totalDistance = 0;

    if (polyline.isNotEmpty) {
      print('##########" routePolys passing');
      print('poly= $polyline');

      double calculateDistance(lat1, lon1, lat2, lon2) {
        var p = 0.017453292519943295;
        var c = cos;
        var a = 0.5 -
            c((lat2 - lat1) * p) / 2 +
            c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
        return 12742 * asin(sqrt(a));
      }

      for (var i = 0; i < polyline.length - 1; i++) {
        totalDistance += calculateDistance(
            polyline[i].latitude,
            polyline[i].longitude,
            polyline[i + 1].latitude,
            polyline[i + 1].longitude);
      }

      print('#### distance= $totalDistance');
    }

    return totalDistance;
  }

  void saveCurrLoc() {
    LatLng newCurrLoc = LatLng(gpsLat, gpsLng);

    if (traveledRoutePolys.isNotEmpty) {
      if (traveledRoutePolys.last != newCurrLoc) {
        traveledRoutePolys.add(newCurrLoc);

        print('######## added new curr $newCurrLoc');
      }
    } else {
      traveledRoutePolys.add(newCurrLoc);
      print('######## added new curr Loc at first');
    }
    print('########traveledRoutePolys Length=> ${traveledRoutePolys.length}');
  } // update traveledPolyline(green) each 3 sec ,if gps is moving it doesn't

  /// Plane GPS Position
  void gpsLcation() async {
    // DatabaseReference gpsRef = FirebaseDatabase.instance.ref().child('/Airplane/${widget.cu.planes}/pos');
    DatabaseReference gpsRef = FirebaseDatabase.instance
        .ref()
        .child('/Airplane/${widget.cu.planes.toString()}/pos');
    final snapshot = await gpsRef.get();
    var data = Map<String, dynamic>.from(snapshot.value as Map);
    var _lat = data["lat"];
    var _lng = data["lng"];

    if (this.mounted) {
      setState(() {
        gpsLat = double.parse(_lat);
        gpsLng = double.parse(_lng);

        ///gps marker
        gpsMarker = Marker(
          rotate: true,
          width: 140.0,
          height: 140.0,
          point: LatLng(gpsLat, gpsLng),
          builder: (ctx) =>
              Icon(Icons.airplanemode_active, color: kPrimaryColor, size: 30),
          // ),
        );
        print('########### Gps Position from DB => $gpsLat _ $gpsLng');
      });
    }
  }

  Future<void> locateUser(bool auto) async {
    Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      //forceAndroidLocationManager: true,
    ).then((Position position) {
      setState(() {
        userLat = position.latitude;
        userLng = position.longitude;
        print('### user pos ==> $userLat - $userLng');
        userMarker = Marker(
          rotate: true,
          width: 140.0,
          height: 140.0,
          point: LatLng(userLat, userLng),
          builder: (ctx) => Container(
            child: Icon(
              Icons.place,
              color: Colors.red,
              size: 25,
            ),
          ),
        );
        if (!auto) {
          _mapController.move(LatLng(userLat, userLng), 16.0);
          trackUser = true;
        }
      });
    }).catchError((e) {
      print('## EXP = $e');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Text("Map"),
        centerTitle: true,
      ),
      body: Container(
        child: Stack(
          children: [
            /// display map
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                interactiveFlags: InteractiveFlag.pinchZoom |
                    InteractiveFlag.drag |
                    InteractiveFlag.pinchMove |
                    InteractiveFlag.flingAnimation,

                center: LatLng(35.65426782, 10.582448656),
                zoom: 10.0,

                maxZoom: 17, //close
                minZoom: 1, //far
              ),

              /// children
              children: <Widget>[
                /// map_display
                TileLayerWidget(
                  options: TileLayerOptions(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                    tileProvider: NonCachingNetworkTileProvider(),
                  ),
                ),

                /// traveled_Lines purple
                PolylineLayerWidget(
                  options: PolylineLayerOptions(
                    polylines: [
                      Polyline(
                          points: traveledRoutePolys,
                          strokeWidth: 4.0,
                          color: Colors.red),
                    ],
                  ),
                ),

                ///markers /// gps position red
                MarkerLayerWidget(
                    options: MarkerLayerOptions(
                  markers: <Marker>[
                    gpsMarker,
                  ],
                )),

                ///markers /// user position red
                MarkerLayerWidget(
                    options: MarkerLayerOptions(
                  markers: <Marker>[
                    userMarker,
                  ],
                )),
              ],
            ),

            ///test
            Positioned(
              bottom: 200,
              left: 10,
              child: FloatingActionButton.extended(
                heroTag: "g",
                label: Text('S'),
                backgroundColor: Colors.grey,
                onPressed: () {
                  // print('### ${widget.cu.email}');
                  // print('### plqnes. ${widget.cu.planes}');
                  // print('### ${widget.cu.phone}');
                  // print('### ${widget.cu.pwd}');
                  // print('### ${widget.cu.role}');
                  // print('### ${widget.cu.id}');

                  listenPlane();
                  setState(() {});
                },
              ),
            ),

            ///start timer
            Positioned(
              bottom: 10,
              left: 10,
              child: FloatingActionButton.extended(
                heroTag: "Start",
                label: Text('Start tracking'),
                backgroundColor: gpsIsActive == 0 ? kPrimaryColor : Colors.grey,
                icon: Icon(
                  Icons.circle,
                  size: 24.0,
                  color:
                      gpsIsActive == 0 ? Colors.green[900] : Colors.grey[600],
                ),
                onPressed: () {
                  startTimer();

                  if (this.mounted) {
                    setState(() {
                      gpsIsActive = 1;
                    });
                  }
                },
              ),
            ),

            ///end timer
            Positioned(
              bottom: 70,
              left: 10,
              child: FloatingActionButton.extended(
                heroTag: "Stop tracking",
                label: Text('Stop tracking'),
                backgroundColor: gpsIsActive == 1 ? Colors.red : Colors.grey,
                icon: Icon(
                  Icons.circle,
                  size: 24.0,
                  color: gpsIsActive == 1 ? Colors.red[900] : Colors.grey[600],
                ),
                onPressed: () {
                  endTimer();

                  if (this.mounted) {
                    setState(() {
                      gpsIsActive = 0;
                    });
                  }
                },
              ),
            ),

            ///current location
            Positioned(
              bottom: 15,
              right: 15,
              height: 60,
              width: 60,
              child: FloatingActionButton.extended(
                //foregroundColor: Colors.blue,
                heroTag: "loc",
                label: Icon(
                  Icons.gps_fixed,
                  size: 24.0,
                  color: Colors.white,
                ),
                backgroundColor: Colors.grey.withOpacity(0.7),

                onPressed: () async {
                  var isGpsEnabled =
                      await Geolocator.isLocationServiceEnabled();
                  if (trackUser && isGpsEnabled) {
                    locateUser(false);
                  }
                },
              ),
            ),

            ///Distace traveled
            Positioned(
                top: 0,
                left: 0,
                height: 40,
                width: 150,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.5),
                      border: Border.all(
                        width: 1,
                        color: Colors.purple.withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(0))),
                  child: Center(
                    child: Text(
                      'Distance: ${distanceTraveled.ceil()} km',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )),

            /// Altitude
            Positioned(
                top: 40,
                left: 0,
                height: 40,
                width: 150,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.5),
                      border: Border.all(
                        width: 1,
                        color: Colors.purple.withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(0))),
                  child: Center(
                    child: Text('Altitude: 500 m',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  ),
                )),

            /// Speed
            Positioned(
                top: 80,
                left: 0,
                height: 40,
                width: 150,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.5),
                      border: Border.all(
                        width: 1,
                        color: Colors.purple.withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(0))),
                  child: Center(
                    child: Text('Speed: 400 k/m',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
