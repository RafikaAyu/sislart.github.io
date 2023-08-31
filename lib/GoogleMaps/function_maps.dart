import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sislart/Function/function.dart';
import 'package:sislart/LocalData/mapsdata.dart';

titik(double latitude, double longitud) {
  return LatLng(latitude, longitud);
}

marker(BitmapDescriptor iconBitmap, titik, String namaMarker,
    Completer<GoogleMapController> mapsController) {
  return Marker(
      markerId: MarkerId(namaMarker),
      position: titik,
      icon: iconBitmap,
      infoWindow: InfoWindow(title: namaMarker),
      onTap: () => updateCamMaps(mapsController, titik, 16.5, 50));
}

markerCustom(BitmapDescriptor iconBitmap, titik, String namaMarker,
    Completer<GoogleMapController> mapsController, bool dimensi) {
  return Marker(
      markerId: MarkerId(namaMarker),
      position: titik,
      icon: iconBitmap,
      flat: dimensi,
      alpha: 0.9,
      infoWindow: InfoWindow(title: namaMarker),
      onTap: () => updateCamMaps(mapsController, titik, 16.5, 0));
}

markerLRT(BitmapDescriptor iconBitmap, titik, int peron, String title,
    void Function(int) tap) {
  return Marker(
    markerId: MarkerId("$peron"),
    position: titik,
    icon: iconBitmap,
    infoWindow: InfoWindow(title: title),
    onTap: () => tap(peron),
  );
}

camMaps(
    String namaPosisi, titik, double zoom, double kompas, double kemiringan) {
  return CameraPosition(
      target: titik, zoom: zoom, bearing: kompas, tilt: kemiringan);
}

updateCamMaps(Completer<GoogleMapController> mapsController, titik, double zoom,
    double arah) async {
  final controller = await mapsController.future;
  await controller.animateCamera(
      CameraUpdate.newCameraPosition(camMaps("Update", titik, zoom, arah, 30)));
}

durasiDetik<Duration>(DateTime awal, DateTime akhir) {
  return akhir.difference(awal).inSeconds;
}

setThemeMaps(Completer<GoogleMapController> mapsController,
    String assetsThemeJson) async {
  String mapStyle = await rootBundle.loadString(assetsThemeJson);
  final mapsTheme = await mapsController.future;
  mapsTheme.setMapStyle(mapStyle);
}

setIconMarker(String iconAsset, void Function(BitmapDescriptor) onTap) async {
  BitmapDescriptor.fromAssetImage(const ImageConfiguration(), iconAsset)
      .then((value) => onTap(value));
}

setPolylineRute(Set<Polyline> poly, List<LatLng> dataLine) {
  poly.addAll({
    Polyline(
      polylineId: const PolylineId("Rute LRT Palembang"),
      points: dataLine,
      color: Colors.lightBlue,
      width: 14,
      patterns: [PatternItem.gap(1), PatternItem.dot],
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    ),
  });
  return poly;
}

setMarkerStasiun(
    Set<Marker> markers, Completer<GoogleMapController> mapsController) {
  markers.addAll({
    marker(FungsiMaps.iconStasiun, titik(-2.893991, 104.705572),
        "Stasiun LRT Bandara", mapsController),
    marker(FungsiMaps.iconStasiun, titik(-2.919734, 104.711778),
        "Stasiun LRT Asrama Haji", mapsController),
    marker(FungsiMaps.iconStasiun, titik(-2.940454, 104.723810),
        "Stasiun LRT Punti Kayu", mapsController),
    marker(FungsiMaps.iconStasiun, titik(-2.948149, 104.732610),
        "Stasiun LRT RSUD", mapsController),
    marker(FungsiMaps.iconStasiun, titik(-2.955983, 104.735729),
        "Stasiun LRT Garuda Dempo", mapsController),
    marker(FungsiMaps.iconStasiun, titik(-2.964223, 104.735938),
        "Stasiun LRT Demang", mapsController),
    marker(FungsiMaps.iconStasiun, titik(-2.977099, 104.744977),
        "Stasiun LRT Bumi Sriwijaya", mapsController),
    marker(FungsiMaps.iconStasiun, titik(-2.978489, 104.749157),
        "Stasiun LRT Dishub", mapsController),
    marker(FungsiMaps.iconStasiun, titik(-2.980773, 104.756133),
        "Stasiun LRT Cinde", mapsController),
    marker(FungsiMaps.iconStasiun, titik(-2.988695, 104.761894),
        "Stasiun LRT Ampera", mapsController),
    marker(FungsiMaps.iconStasiun, titik(-3.005120, 104.772700),
        "Stasiun LRT Polresta", mapsController),
    marker(FungsiMaps.iconStasiun, titik(-3.023174, 104.784641),
        "Stasiun LRT Jakabaring", mapsController),
    marker(FungsiMaps.iconStasiun, titik(-3.031262, 104.789876),
        "Stasiun LRT DJKA", mapsController),
  });

  return markers;
}

setMarkerPlaces(
    Set<Marker> markers, Completer<GoogleMapController> mapsController) {
  markers.addAll({
    markerCustom(FungsiMaps.iconPolsri, titik(-2.982966, 104.733234),
        "Politeknik Negeri Sriwijaya", mapsController, true),
    markerCustom(
        FungsiMaps.iconMi,
        titik(-2.9795941022139214, 104.73122970507127),
        "Jurusan Manajemen Informatika Politeknik Negeri Sriwijaya",
        mapsController,
        true)
  });

  return markers;
}

Map<String, List<dynamic>> statusLRT(
    List<List<dynamic>> data, List<dynamic> namaStasiun) {
  Map<String, List<dynamic>> stationStatus = {};

  if (data.length == namaStasiun.length) {
    for (int stasiun = 0; stasiun < namaStasiun.length; stasiun++) {
      bool isOperating = false;
      int peronCount = 0;

      for (int peron = 0; peron < data[stasiun].length; peron++) {
        int idSampai = stasiun + 1 < namaStasiun.length - 1
            ? stasiun + 1
            : data.length - 1;
        DateTime jadwalPeronBerangkat =
            DateFormat('HH:mm:ss').parse(data[stasiun][peron]);
        DateTime jadwalPeronSampai =
            DateFormat('HH:mm:ss').parse(data[idSampai][peron]);

        if (realTime().isAfter(jadwalPeronBerangkat) &&
            realTime().isBefore(jadwalPeronSampai)) {
          isOperating = true;
          peronCount++;
        }
      }

      if (isOperating) {
        stationStatus[namaStasiun[stasiun]] = [true, peronCount];
      } else {
        stationStatus[namaStasiun[stasiun]] = [false, peronCount];
      }
    }
  }

  if (data.length == namaStasiun.length) {
    for (int stasiun = 0; stasiun < namaStasiun.length; stasiun++) {
      if (!stationStatus.containsKey(namaStasiun[stasiun])) {
        stationStatus[namaStasiun[stasiun]] = [false, 0];
      }
    }
  }

  return stationStatus;
}

getLRTOperasi(List<List<dynamic>> data, List<dynamic> namaStasiun) {
  return statusLRT(data, namaStasiun)
      .values
      .where((value) => value[0] == true)
      .length;
}
