import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sislart/LocalData/mapsdata.dart';

Widget floating(void Function(bool) setState) {
  return SpeedDial(
    buttonSize: const Size(50, 50),
    curve: Curves.bounceIn,
    direction: SpeedDialDirection.up,
    animatedIcon: AnimatedIcons.menu_arrow,
    backgroundColor: Colors.black45,
    overlayOpacity: 0.1,
    onClose: () => setState,
    children: [
      speedChild("Geser Maps", Icons.gesture, FungsiMaps.scroll, () => setState(FungsiMaps.scroll = !FungsiMaps.scroll)),
      speedChild("Zoom Maps", Icons.center_focus_weak_sharp, FungsiMaps.zoom, () => setState(FungsiMaps.zoom = !FungsiMaps.zoom)),
      speedChild("Lalu Lintas", Icons.traffic, FungsiMaps.lalulintas, () => setState(FungsiMaps.lalulintas = !FungsiMaps.lalulintas)),
      speedChild("Mode Tampilan ${FungsiMaps.tipemap}", Icons.map, false, () {
        if (FungsiMaps.tipemap >= 1 && FungsiMaps.tipemap < 4) {
          FungsiMaps.tipemap++;
        } else {
          FungsiMaps.tipemap = 1;
        }
        setState(true);
      }),
    ],
  );
}

speedChild(String nameLabel, IconData icon, bool changeColor, void Function() onTap) {
  return SpeedDialChild(
    label: nameLabel,
    child: Icon(icon),
    labelBackgroundColor: Colors.black45,
    labelStyle: GoogleFonts.quicksand(color: Colors.white, fontWeight: FontWeight.w700),
    backgroundColor: changeColor == true ? const Color.fromARGB(200, 27, 222, 47) : const Color.fromARGB(200, 255, 255, 255),
    onTap: onTap,
  );
}
