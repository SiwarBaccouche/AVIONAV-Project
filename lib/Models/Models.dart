import 'package:flutter/material.dart';



class AvClient {

  String? id;
  String? name;
  String? phone;
  String? email;
  String? role ;
  String? pwd;
  String? planes;

  AvClient({
    this.id = 'no-id',
    this.name = 'no-name',
    this.email = 'no-email',
    this.phone = 'no-phone',
    this.role = 'no-role',
    this.pwd  = 'no-pwd',
    this.planes ='no_planes',
  });
}



class AvPlane {

  String? id;
  String? owner;
  String? sensors;
  String? type ;
  String? alt;
  String? color;
  String? hum;
  String? tem;
  String? vitesse;
  String? lat;
  String? lng;
  String? doorState;

  AvPlane({
    this.id,
    this.owner,
    this.sensors ,
    this.type ,
    this.alt ,
    this.color ,
    this.hum ,
    this.tem ,
    this.vitesse ,
    this.lat ,
    this.lng ,
    this.doorState ,


  });
}