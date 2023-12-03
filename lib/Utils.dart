//@dart=2.9

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

Map<String, dynamic> remoteData = {
  "remoteOne": [
    {
      "name": "Power On",
      "pattern":
          "0000 006d 0022 0002 0155 00ab 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0015 0015 0040 0015 0040 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 0040 0015 05f1 0155 0056 0015 0e48",
      "color": "000000",
      "icon": MdiIcons.lightbulbOnOutline,
    },
    {
      "name": "Power Off",
      "pattern":
          "0000 006d 0022 0002 0155 00ab 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 05f1 0155 0056 0015 0e48",
      "color": "ca2927",
      "icon": MdiIcons.lightbulbOutline,
    },
    {
      "name": "Brightness up",
      "pattern":
          "0000 006d 0022 0002 0155 00ab 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0015 0015 0015 0015 0040 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0015 0015 0040 0015 0040 0015 0040 0015 0040 0015 05f1 0155 0056 0015 0e49",
      "color": "b7b7b7",
      "icon": MdiIcons.brightness7,
    },
    {
      "name": "Brightnedd down",
      "pattern":
          "0000 006d 0022 0002 0155 00ab 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0015 0015 0040 0015 0040 0015 0040 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 05f1 0155 0056 0015 0e48",
      "color": "b7b7b7",
      "icon": MdiIcons.brightness4,
    },
    {
      "name": "R",
      "pattern":
          "0000 006d 0022 0002 0155 00ac 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0015 0015 0015 0015 0040 0015 0040 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 05f2 0155 0056 0015 0e48",
      "color": "ee4e4d",
      "icon": null,
    },
    {
      "name": "G",
      "pattern":
          "0000 006d 0022 0002 0155 00ab 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0015 0015 0040 0015 0040 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 05f1 0155 0056 0015 0e48",
      "color": "47875c",
      "icon": null,
    },
    {
      "name": "B",
      "pattern":
          "0000 006d 0022 0002 0155 00ab 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0015 0015 0015 0015 0015 0015 0040 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 0015 0015 0040 0015 0040 0015 0040 0015 05f2 0155 0056 0015 0e48",
      "color": "3d468b",
      "icon": null,
    },
    {
      "name": "W",
      "pattern":
          "0000 006d 0022 0002 0155 00ac 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0015 0015 0040 0015 0015 0015 0040 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0015 0015 0040 0015 0015 0015 0040 0015 0040 0015 0040 0015 05f2 0155 0056 0015 0e48",
      "color": "ffffff",
      "icon": null,
    },
    {
      "name": "Flash",
      "pattern":
          "0000 006d 0022 0002 0155 00ab 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0015 0015 0040 0015 0040 0015 0015 0015 0015 0015 0040 0015 0015 0015 0015 0015 0040 0015 0015 0015 0015 0015 0040 0015 0040 0015 0015 0015 0040 0015 05f1 0155 0056 0015 0e48",
      "color": "908c9a",
      "icon": MdiIcons.flash,
    },
    {
      "name": "Strobe",
      "pattern":
          "0000 006d 0022 0002 0155 00ab 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 05f2 0155 0056 0015 0e48",
      "color": "908c9a",
      "icon": MdiIcons.weatherSunny,
    },
    {
      "name": "Fade",
      "pattern":
          "0000 006d 0022 0002 0155 00ab 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0015 0015 0040 0015 0015 0015 0040 0015 0040 0015 0015 0015 0015 0015 0015 0015 0040 0015 0015 0015 0040 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 05f2 0155 0056 0015 0e48",
      "color": "908c9a",
      "icon": MdiIcons.boxShadow,
    },
    {
      "name": "Smooth",
      "pattern":
          "0000 006d 0022 0002 0155 00ac 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0015 0015 0015 0015 0040 0015 0040 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 0040 0015 05f1 0155 0056 0015 0e48",
      "color": "908c9a",
      "icon": MdiIcons.waves,
    },
    {
      "name": "R1",
      "pattern":
          "0000 006d 0022 0002 0156 00ab 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0015 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0015 0015 0040 0015 05f5 0156 0056 0015 0e51",
      "color": "e76a4f",
      "icon": null,
    },
    {
      "name": "R2",
      "pattern":
          "0000 006D 0022 0002 0156 00AB 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0015 0015 0040 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0015 0015 0040 0015 0040 0015 0040 0015 05E9 0156 0056 0015 0E3B",
      "color": "e4794d",
      "icon": null,
    },
    {
      "name": "R3",
      "pattern":
          "0000 006d 0022 0002 0155 00ab 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0015 0015 0040 0015 0015 0015 0040 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0015 0015 0040 0015 0015 0015 0040 0015 0040 0015 0040 0015 0040 0015 05f1 0155 0056 0015 0e47",
      "color": "dfa04b",
      "icon": null,
    },
    {
      "name": "R4",
      "pattern":
          "0000 006d 0022 0002 0155 00ab 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 05f2 0155 0056 0015 0e48",
      "color": "dcdb34",
      "icon": null,
    },
    {
      "name": "G1",
      "pattern":
          "0000 006d 0022 0002 0155 00ab 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0015 0015 0040 0015 0015 0015 0015 0015 0040 0015 0015 0015 0015 0015 0015 0015 0040 0015 0015 0015 0040 0015 0040 0015 0015 0015 0040 0015 0040 0015 0040 0015 05f1 0155 0056 0015 0e48",
      "color": "4fa75b",
      "icon": null,
    },
    {
      "name": "G2",
      "pattern":
          "0000 006d 0022 0002 0155 00ac 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0015 0015 0015 0015 0040 0015 0040 0015 0015 0015 0015 0015 0040 0015 0015 0015 0040 0015 0040 0015 0015 0015 0015 0015 0040 0015 0040 0015 0015 0015 0040 0015 05f1 0155 0056 0015 0e48",
      "color": "5586c5",
      "icon": null,
    },
    {
      "name": "G3",
      "pattern":
          "0000 006d 0022 0002 0155 00ab 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0015 0015 0040 0015 0040 0015 0040 0015 0040 0015 0015 0015 0015 0015 0015 0015 0040 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 05f2 0155 0056 0015 0e48",
      "color": "44759a",
      "icon": null,
    },
    {
      "name": "G4",
      "pattern":
          "0000 006d 0022 0002 0155 00ab 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0015 0015 0015 0015 0040 0015 0015 0015 0040 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0015 0015 0040 0015 0015 0015 0040 0015 0040 0015 0040 0015 05f1 0155 0056 0015 0e48",
      "color": "3c529c",
      "icon": null,
    },
    {
      "name": "B1",
      "pattern":
          "0000 006d 0022 0002 0155 00ac 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0015 0015 0040 0015 0040 0015 0015 0015 0040 0015 0015 0015 0015 0015 0015 0015 0040 0015 0015 0015 0015 0015 0040 0015 0015 0015 0040 0015 0040 0015 0040 0015 05f2 0155 0056 0015 0e48",
      "color": "3b389f",
      "icon": null,
    },
    {
      "name": "B2",
      "pattern":
          "0000 006d 0022 0002 0155 00ac 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0015 0015 0015 0015 0040 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0015 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 05f2 0155 0056 0015 0e49",
      "color": "744398",
      "icon": null,
    },
    {
      "name": "B3",
      "pattern":
          "0000 006d 0022 0002 0155 00ab 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0015 0015 0040 0015 0040 0015 0040 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 0040 0015 05f1 0155 0056 0015 0e48",
      "color": "9d52a9",
      "icon": null,
    },
    {
      "name": "B4",
      "pattern":
          "0000 006d 0022 0002 0155 00ab 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0040 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0015 0040 0015 0040 0015 0040 0015 0040 0015 05f2 0155 0056 0015 0e48",
      "color": "ec54b9",
      "icon": null,
    },
  ],
  "remoteTwo": [
    {
      "name": "Power On",
      "pattern":
          "0000 006d 0000 0022 015a 00ad 0013 0017 0014 0017 0015 0016 0014 0017 0015 0016 0014 0017 0014 0017 0015 0016 0014 0041 0015 0041 0015 0041 0015 0041 0014 0017 0014 0041 0015 0041 0015 0041 0015 0041 0015 0040 0014 0017 0014 0017 0015 0016 0015 0016 0015 0016 0015 0016 0014 0017 0014 0017 0014 0041 0014 0042 0015 0041 0015 0041 0014 0041 0015 0041 0015 39ea",
      "color": "000000",
      "icon": MdiIcons.lightbulbOnOutline,
    },
    {
      "name": "Power Off",
      "pattern":
          "0000 006d 0000 0022 015a 00ad 0014 0016 0015 0016 0015 0016 0015 0016 0015 0016 0015 0016 0015 0016 0015 0016 0015 0040 0015 0041 0015 0041 0015 0041 0015 0016 0015 0040 0015 0041 0015 0041 0015 0016 0015 0041 0014 0016 0015 0016 0015 0016 0015 0016 0015 0016 0015 0016 0015 0041 0015 0016 0014 0041 0015 0041 0016 0040 0015 0041 0015 0040 0015 0041 0016 3943",
      "color": "ca2927",
      "icon": MdiIcons.lightbulbOutline,
    },
    {
      "name": "Brightness up",
      "pattern":
          "0000 006d 0000 0022 015a 00ad 0014 0016 0015 0016 0015 0016 0015 0016 0015 0016 0015 0016 0015 0016 0015 0016 0015 0040 0015 0041 0015 0041 0015 0041 0015 0016 0015 0040 0015 0041 0015 0041 0015 0016 0015 0016 0015 0016 0014 0017 0014 0016 0015 0016 0015 0016 0015 0016 0015 0041 0015 0041 0014 0041 0015 0041 0015 0041 0015 0041 0015 0041 0014 0041 0015 3d93",
      "color": "b7b7b7",
      "icon": MdiIcons.brightness7,
    },
    {
      "name": "Brightnedd down",
      "pattern":
          "0000 006d 0000 0022 015a 00ad 0015 0016 0015 0016 0014 0016 0015 0016 0016 0015 0015 0016 0015 0016 0015 0016 0015 0041 0015 0040 0015 0041 0015 0041 0015 0016 0015 0041 0014 0041 0015 0041 0015 0041 0015 0016 0015 0016 0015 0016 0015 0016 0014 0016 0015 0016 0015 0016 0015 0016 0015 0041 0015 0041 0014 0041 0015 0041 0015 0041 0015 0041 0015 0040 0015 28e5",
      "color": "b7b7b7",
      "icon": MdiIcons.brightness4,
    },
    {
      "name": "R",
      "pattern":
          "0000 006d 0000 0022 0159 00ad 0014 0016 0015 0016 0014 0017 0015 0016 0015 0016 0015 0016 0015 0016 0015 0016 0014 0041 0015 0041 0015 0041 0015 0041 0014 0017 0014 0041 0015 0041 0014 0042 0015 0016 0015 0016 0015 0040 0015 0016 0015 0016 0015 0016 0015 0016 0014 0017 0015 0041 0015 0040 0015 0016 0015 0041 0015 0041 0015 0041 0014 0041 0014 0042 0015 3f31",
      "color": "ee4e4d",
      "icon": null,
    },
    {
      "name": "G",
      "pattern":
          "0000 006d 0000 0022 015a 00ad 0015 0016 0015 0016 0015 0016 0014 0016 0015 0016 0014 0017 0015 0016 0015 0016 0014 0042 0014 0042 0014 0041 0015 0041 0015 0016 0015 0041 0015 0041 0013 0042 0015 0041 0015 0016 0015 0041 0015 0016 0014 0016 0015 0016 0015 0016 0015 0016 0015 0016 0015 0041 0015 0016 0015 0041 0014 0041 0015 0041 0016 0040 0015 0041 0014 355e",
      "color": "47875c",
      "icon": null,
    },
    {
      "name": "B",
      "pattern":
          "0000 006d 0000 0022 0159 00ad 0015 0016 0015 0016 0014 0017 0014 0016 0015 0016 0015 0016 0015 0016 0015 0016 0015 0041 0015 0040 0015 0041 0015 0041 0015 0016 0015 0041 0015 0041 0014 0041 0015 0016 0015 0041 0015 0041 0014 0017 0014 0016 0015 0016 0015 0016 0015 0016 0015 0041 0015 0016 0015 0016 0015 0040 0015 0041 0015 0041 0015 0041 0015 0041 0014 2189",
      "color": "3d468b",
      "icon": null,
    },
    {
      "name": "W",
      "pattern":
          "0000 006d 0000 0022 0158 00ae 0015 0017 0013 0017 0014 0017 0014 0016 0015 0016 0015 0016 0014 0017 0015 0017 0013 0042 0015 0041 0013 0042 0015 0041 0015 0016 0014 0042 0014 0041 0015 0041 0014 0042 0015 0041 0015 0041 0013 0017 0015 0016 0015 0016 0015 0016 0015 0016 0015 0016 0014 0017 0015 0016 0015 0040 0014 0042 0014 0042 0014 0042 0014 0042 0013 3152",
      "color": "ffffff",
      "icon": null,
    },
    {
      "name": "Flash",
      "pattern":
          "0000 006d 0000 0022 0157 00b0 0014 0018 0013 0018 0013 0017 0013 0018 0013 0018 0013 0018 0013 0018 0013 0018 0014 0041 0014 0042 0013 0043 0013 0043 0013 0018 0013 0042 0014 0042 0013 0043 0013 0043 0012 0044 0013 0017 0014 0042 0013 0017 0014 0018 0013 0017 0014 0018 0013 0018 0015 0015 0013 0043 0013 0018 0014 0042 0014 0041 0015 0041 0014 0042 0013 391f",
      "color": "908c9a",
      "icon": MdiIcons.flash,
    },
    {
      "name": "Strobe",
      "pattern":
          "0000 006d 0000 0022 0159 00ae 0013 0018 0013 0017 0015 0016 0014 0017 0014 0017 0013 0017 0014 0017 0014 0017 0014 0042 0014 0042 0014 0042 0014 0041 0014 0017 0014 0042 0015 0041 0015 0041 0014 0041 0014 0042 0015 0041 0015 0041 0014 0016 0014 0017 0015 0016 0015 0016 0015 0016 0014 0017 0014 0017 0014 0017 0014 0041 0015 0041 0015 0041 0015 0041 0014 2fba",
      "color": "908c9a",
      "icon": MdiIcons.weatherSunny,
    },
    {
      "name": "Fade",
      "pattern":
          "0000 006d 0000 0022 0158 00ad 0014 0018 0013 0017 0014 0017 0014 0017 0014 0017 0014 0018 0013 0017 0014 0017 0013 0042 0014 0043 0013 0042 0014 0041 0014 0017 0015 0041 0015 0041 0015 0041 0014 0042 0014 0041 0015 0016 0015 0016 0014 0042 0015 0016 0014 0017 0014 0016 0014 0017 0015 0016 0015 0041 0015 0041 0015 0016 0014 0041 0015 0041 0015 0041 0015 280b",
      "color": "908c9a",
      "icon": MdiIcons.boxShadow,
    },
    {
      "name": "Smooth",
      "pattern":
          "0000 006d 0000 0022 015a 00ac 0015 0016 0014 0017 0015 0016 0015 0016 0015 0016 0015 0016 0013 0017 0015 0016 0015 0041 0015 0041 0015 0041 0014 0041 0015 0016 0015 0041 0015 0041 0015 0041 0014 0041 0015 0041 0015 0041 0015 0016 0015 0041 0014 0016 0015 0016 0015 0016 0015 0016 0015 0016 0015 0016 0015 0041 0014 0017 0014 0041 0015 0041 0015 0041 0015 2971",
      "color": "908c9a",
      "icon": MdiIcons.waves,
    },
    {
      "name": "R1",
      "pattern":
          "0000 006d 0000 0022 015a 00ad 0015 0016 0014 0017 0014 0016 0016 0015 0015 0016 0015 0016 0015 0016 0015 0016 0015 0040 0015 0041 0015 0041 0015 0041 0015 0016 0015 0041 0013 0042 0015 0041 0015 0016 0015 0016 0015 0016 0015 0040 0016 0015 0015 0016 0015 0016 0015 0016 0015 0041 0015 0041 0014 0041 0015 0016 0015 0041 0015 0041 0015 0041 0014 0041 0015 219a",
      "color": "e76a4f",
      "icon": null,
    },
    {
      "name": "R2",
      "pattern":
          "0000 006d 0000 0022 0159 00ad 0015 0016 0015 0016 0014 0016 0015 0016 0015 0016 0015 0016 0015 0016 0015 0016 0015 0041 0014 0041 0015 0041 0015 0041 0015 0016 0014 0042 0014 0041 0015 0041 0015 0016 0015 0016 0015 0041 0014 0041 0015 0016 0014 0017 0015 0016 0015 0016 0015 0041 0015 0041 0014 0017 0014 0016 0015 0041 0015 0041 0015 0041 0014 0041 0015 35b3",
      "color": "e4794d",
      "icon": null,
    },
    {
      "name": "R3",
      "pattern":
          "0000 006d 0000 0022 015a 00ac 0015 0016 0015 0016 0015 0016 0015 0016 0015 0016 0015 0016 0015 0016 0014 0017 0014 0041 0015 0041 0015 0041 0015 0041 0014 0016 0015 0041 0015 0041 0015 0041 0015 0016 0015 0016 0014 0016 0015 0016 0015 0041 0015 0016 0015 0016 0015 0016 0015 0040 0015 0041 0016 0040 0015 0041 0016 0015 0015 0040 0015 0041 0015 0041 0015 33a9",
      "color": "dfa04b",
      "icon": null,
    },
    {
      "name": "R4",
      "pattern":
          "0000 006d 0000 0022 015a 00ac 0015 0016 0015 0016 0015 0016 0015 0016 0015 0016 0015 0016 0014 0016 0015 0016 0015 0041 0015 0041 0015 0041 0015 0040 0015 0016 0015 0041 0015 0041 0015 0041 0014 0016 0015 0016 0015 0016 0015 0016 0015 0041 0015 0016 0015 0016 0015 0016 0015 0040 0015 0041 0015 0041 0015 0041 0014 0016 0015 0041 0015 0041 0015 0041 0015 29a4",
      "color": "dcdb34",
      "icon": null,
    },
    {
      "name": "G1",
      "pattern":
          "0000 006d 0000 0022 015a 00ac 0015 0016 0015 0016 0015 0016 0015 0016 0015 0016 0014 0016 0015 0016 0015 0016 0015 0041 0014 0042 0015 0041 0014 0041 0015 0016 0015 0041 0015 0041 0015 0040 0015 0041 0016 0015 0015 0016 0015 0041 0015 0016 0015 0016 0014 0017 0015 0015 0015 0016 0016 0040 0015 0041 0015 0016 0015 0040 0015 0041 0015 0041 0015 0041 0015 2bad",
      "color": "4fa75b",
      "icon": null,
    },
    {
      "name": "G2",
      "pattern":
          "0000 006d 0000 0022 015a 00ac 0015 0016 0015 0016 0015 0016 0015 0016 0015 0016 0015 0016 0015 0016 0014 0016 0015 0041 0015 0041 0015 0041 0015 0041 0014 0016 0015 0041 0015 0041 0015 0041 0015 0040 0015 0016 0015 0041 0015 0041 0015 0016 0015 0016 0015 0016 0015 0016 0014 0016 0015 0041 0015 0016 0015 0016 0015 0041 0015 0040 0015 0041 0015 0041 0015 3cf3",
      "color": "5586c5",
      "icon": null,
    },
    {
      "name": "G3",
      "pattern":
          "0000 006d 0000 0022 015a 00ac 0015 0016 0015 0016 0015 0016 0015 0016 0015 0016 0015 0016 0015 0016 0014 0016 0015 0041 0015 0041 0015 0041 0016 003f 0015 0016 0015 0041 0015 0041 0015 0041 0015 0041 0014 0016 0015 0016 0015 0016 0015 0041 0015 0016 0015 0016 0014 0017 0014 0016 0015 0041 0016 0040 0016 0040 0015 0016 0015 0040 0015 0041 0015 0041 0015 32a8",
      "color": "44759a",
      "icon": null,
    },
    {
      "name": "G4",
      "pattern":
          "0000 006d 0000 0022 0159 00ae 0014 0017 0013 0017 0015 0016 0014 0017 0014 0017 0014 0017 0014 0017 0014 0017 0014 0042 0014 0041 0014 0042 0014 0042 0014 0017 0015 0040 0014 0042 0014 0042 0014 0042 0014 0017 0015 0040 0014 0017 0014 0042 0014 0017 0014 0017 0014 0017 0014 0017 0014 0042 0014 0016 0014 0043 0013 0017 0015 0041 0014 0042 0014 0041 0014 3c13",
      "color": "3c529c",
      "icon": null,
    },
    {
      "name": "B1",
      "pattern":
          "0000 006d 0000 0022 0158 00af 0013 0018 0012 0018 0013 0018 0013 0018 0013 0018 0013 0017 0014 0018 0013 0018 0013 0042 0013 0043 0013 0043 0013 0042 0014 0018 0013 0042 0013 0042 0014 0042 0014 0017 0014 0042 0014 0017 0013 0042 0014 0017 0014 0017 0014 0017 0014 0017 0014 0042 0014 0017 0014 0041 0015 0017 0014 0041 0014 0043 0013 0042 0013 0042 0015 3942",
      "color": "3b389f",
      "icon": null,
    },
    {
      "name": "B2",
      "pattern":
          "0000 006d 0000 0022 0158 00ae 0014 0017 0014 0017 0014 0017 0013 0017 0015 0016 0014 0017 0015 0016 0014 0017 0014 0042 0014 0042 0014 0041 0015 0041 0014 0017 0015 0041 0015 0041 0013 0042 0014 0017 0015 0041 0015 0041 0015 0040 0014 0017 0015 0016 0014 0017 0015 0016 0014 0042 0015 0016 0015 0016 0014 0016 0015 0041 0014 0042 0015 0041 0015 0041 0014 2ce4",
      "color": "744398",
      "icon": null,
    },
    {
      "name": "B3",
      "pattern":
          "0000 006d 0000 0022 015a 00ac 0015 0016 0015 0016 0015 0016 0015 0016 0014 0016 0015 0016 0015 0016 0015 0016 0015 0041 0015 0041 0015 0040 0015 0041 0015 0016 0015 0041 0015 0041 0015 0040 0015 0016 0015 0041 0015 0016 0015 0016 0015 0041 0015 0015 0015 0016 0015 0016 0015 0041 0015 0016 0015 0041 0015 0040 0015 0016 0015 0041 0015 0041 0015 0041 0015 2d9f",
      "color": "9d52a9",
      "icon": null,
    },
    {
      "name": "B4",
      "pattern":
          "0000 006d 0000 0022 0159 00ad 0015 0016 0015 0016 0015 0016 0014 0017 0014 0016 0015 0016 0015 0016 0015 0016 0015 0041 0014 0042 0014 0041 0015 0041 0014 0017 0015 0041 0015 0041 0014 0041 0015 0016 0015 0041 0015 0041 0015 0016 0014 0041 0015 0016 0016 0015 0015 0016 0015 0041 0015 0016 0015 0016 0014 0041 0015 0016 0015 0041 0015 0041 0015 0041 0014 3ada",
      "color": "ec54b9",
      "icon": null,
    },
  ]
};
