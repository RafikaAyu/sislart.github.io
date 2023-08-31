import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sislart/Function/function.dart';
import 'package:sislart/LocalData/mapsdata.dart';

Widget maps(Set<Marker> markers, Set<Polyline> polylines, Completer<GoogleMapController> mapsController, CameraPosition cam, void Function(int) callback) {
  return GoogleMap(
    markers: markers,
    polylines: polylines,
    compassEnabled: false,
    indoorViewEnabled: true,
    myLocationEnabled: true,
    mapToolbarEnabled: false,
    zoomControlsEnabled: false,
    rotateGesturesEnabled: true,
    myLocationButtonEnabled: true,
    onTap: (onTap) => callback(0),
    zoomGesturesEnabled: FungsiMaps.zoom,
    trafficEnabled: FungsiMaps.lalulintas,
    scrollGesturesEnabled: FungsiMaps.scroll,
    mapType: MapType.values[FungsiMaps.tipemap],
    onMapCreated: (GoogleMapController controller) => mapsController.complete(controller),
    initialCameraPosition: cam,
  );
}

Widget buildLegendItem(Color color, String text) {
  return Row(
    children: [
      Container(width: 20, height: 20, color: color),
      const SizedBox(width: 8), // Jarak antara ikon dan teks
      Container(
        padding: const EdgeInsets.only(top: 1, bottom: 1, left: 5, right: 5),
        decoration: BoxDecoration(color: Colors.white30, borderRadius: BorderRadius.circular(2)),
        child: Text(
          text,
          style: GoogleFonts.quicksand(
            decoration: TextDecoration.none,
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 12,
          ),
        ),
      ),
    ],
  );
}

Widget legenda(bool status) {
  if (status == true) {
    return Positioned(
      top: AppBar().preferredSize.height + 100,
      left: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildLegendItem(rgba(92, 200, 97, 1), 'Ramai Lancar'),
          buildLegendItem(rgba(246, 147, 76, 1), 'Agak Padat'),
          buildLegendItem(rgba(255, 57, 47, 1), 'Padat'),
          buildLegendItem(rgba(180, 57, 47, 1), 'Macet'),
        ],
      ),
    );
  } else {
    return Container();
  }
}

Widget widgetStatus(bool status, bool akanHabis, String statusTersedia, String statusAkanHabis, String statusTidakTersedia) {
  return Positioned(
    top: AppBar().preferredSize.height + 60,
    left: 20,
    child: Container(
      decoration: BoxDecoration(
          color: status == true
              ? akanHabis != true
                  ? const Color.fromARGB(198, 76, 175, 79)
                  : const Color.fromARGB(204, 255, 199, 79)
              : const Color.fromARGB(180, 68, 137, 255),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 10, height: 20),
              Container(
                alignment: Alignment.center,
                height: 9,
                width: 9,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 5, height: 20),
              Text(
                status == true
                    ? akanHabis != true
                        ? statusTersedia
                        : statusAkanHabis
                    : statusTidakTersedia,
                textAlign: TextAlign.center,
                overflow: TextOverflow.fade,
                style: GoogleFonts.quicksand(
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 12.5,
                ),
              ),
              const SizedBox(width: 10, height: 20),
            ],
          ),
        ],
      ),
    ),
  );
}
