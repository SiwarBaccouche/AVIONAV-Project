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

class MapPageAdmin extends StatefulWidget {
  AvClient cu;
  MapPageAdmin({Key key, this.cu}) : super(key: key);

  @override
  State<MapPageAdmin> createState() => _MapPageAdminState();
}

class _MapPageAdminState extends State<MapPageAdmin> {
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
  Timer _timer = Timer.periodic(Duration(seconds: 1), (_) {});
  Timer _timerUser = Timer.periodic(Duration(seconds: 1), (_) {});
  int gpsIsActive = 0;
  int secToSaveGps = 0;
  double distanceTraveled = 0;
  int TimeToUpdateGps = 1;
  int TimeToUpdateUser = 1;
  int TimeToSaveGpsPoint = 3;
  Position _currentPosition;
  String speed = '';
  String alt = '';

  List<LatLng> planePositions = [];
  List<Marker> planeMarkers = [];
  List<Marker> planeMarkersTest = [
    Marker(
      rotate: true,
      width: 140.0,
      height: 140.0,
      point: LatLng(35.65645, 10.6455465),
      builder: (ctx) =>
          Icon(Icons.airplanemode_active, color: kPrimaryColor, size: 30),
    ),
    Marker(
      rotate: true,
      width: 140.0,
      height: 140.0,
      point: LatLng(34.65645, 5.6455465),
      builder: (ctx) =>
          Icon(Icons.airplanemode_active, color: kPrimaryColor, size: 30),
    ),
    Marker(
      rotate: true,
      width: 140.0,
      height: 140.0,
      point: LatLng(40.65645, 15.6455465),
      builder: (ctx) =>
          Icon(Icons.airplanemode_active, color: kPrimaryColor, size: 30),
    ),
  ];

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

  @override
  void initState() {
    super.initState();
    requestPermissionLoc();
    _timerUser = Timer.periodic(Duration(seconds: TimeToUpdateGps), (t) {
      checkGpsUser();
    });
    _timer = Timer.periodic(Duration(seconds: 1), (t) {
      //getPlaneMarkers();
    });
  }

  checkGpsUser() async {
    var isGpsEnabled = await Geolocator.isLocationServiceEnabled();
    if (trackUser) {
      locateUser(true);
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

    _timerUser.cancel();

    super.dispose();
  }

  getPlaneMarkers() async {
    planeMarkers.clear();

    DatabaseReference gpsRef = FirebaseDatabase.instance.ref('/Airplane');
    final snapshot = await gpsRef.get();
    var data = Map<String, dynamic>.from(snapshot.value as Map);

    data.forEach((key, value) {
      if (this.mounted) {
        setState(() {
          Marker pl = Marker(
            rotate: true,
            width: 140.0,
            height: 140.0,
            point: LatLng(
              data['pos']['lat'],
              data['pos']['lng'],
            ),
            builder: (ctx) =>
                Icon(Icons.airplanemode_active, color: kPrimaryColor, size: 30),
          );
          planeMarkers.add(pl);
        });
      }
    });
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

                ///markers /// user position red
                MarkerLayerWidget(
                    options: MarkerLayerOptions(
                  markers: planeMarkersTest,
                  //markers: planeMarkers,
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
                  getPlaneMarkers();
                  setState(() {});
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
                  if (trackUser) {
                    locateUser(false);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
