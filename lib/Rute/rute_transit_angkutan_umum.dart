import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sislart/Function/function.dart';
import 'package:sislart/GoogleMaps/function_maps.dart';
import 'package:sislart/Home/home.dart';
import 'package:sislart/LocalData/transitmaps_data.dart';
import 'package:sislart/Widget/appbarview.dart';
import 'package:sislart/Widget/multiplefloatingview.dart';


class TransitAngkutanUmum extends StatefulWidget {
  const TransitAngkutanUmum({Key? key}) : super(key: key);

  @override
  State<TransitAngkutanUmum> createState() => _TransitAngkutanUmumState();
}

class _TransitAngkutanUmumState extends State<TransitAngkutanUmum> {
  final Completer<GoogleMapController> mapsController =
      Completer<GoogleMapController>();
  List<String> koridorList = [
    'Koridor 1',
    'Koridor 2',
    'Koridor 3',
    'Koridor 4',
    'Koridor 5',
    'Koridor 6',
    'Koridor 7',
    'Koridor 8',
    'Koridor 9',
    'Koridor 10',
  ];

  Map<String, Set<Marker>> koridorMarkers = {
    'Koridor 1': {},
    'Koridor 2': {},
    'Koridor 3': {},
    'Koridor 4': {},
    'Koridor 5': {},
    'Koridor 6': {},
    'Koridor 7': {},
    'Koridor 8': {},
    'Koridor 9': {},
    'Koridor 10': {},
  };

  String koridorText = 'Koridor 1';

  Map<String, String> koridorDescriptions = {
    'Koridor 1': 'Rute Talang Kelapa - Punti Kayu',
    'Koridor 2': 'Rute Asrama Haji - Semantang Borang',
    'Koridor 3': 'Rute Asrama Haji - Talang Betutu',
    'Koridor 4': 'Rute Polresta - Komp.Perumahan OPI',
    'Koridor 5': 'Rute DJKA - Pasar Plaju',
    'Koridor 6': 'Rute RSUD - Sukawinatan',
    'Koridor 7': 'Rute Stadion Kamboja - Bukit Siguntang',
    'Koridor 8': 'Rute Terminal Alang - Alang Lebar ',
    'Koridor 9': 'Rute Terminal Sako',
    'Koridor 10': 'Rute Bumi Sriwijaya (Palembang Icon)',
  };

  @override
  void initState() {
    setMarkersAndPolyline();
    setThemeMaps(mapsController, 'assets/json/nightMaps.json');
    super.initState();
  }

  void setMarkersAndPolyline() {
    koridorMarkers['Koridor 1']?.add(Marker(
      markerId: const MarkerId('lokasi_koridor1'),
      position: const LatLng(-2.945701343679613, 104.6861390556281),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: const InfoWindow(title: 'Masjid Al-Hijrah PPI Talang Kelapa'),
    ));

    koridorMarkers['Koridor 1']?.add(Marker(
      markerId: const MarkerId('tujuan_koridor1'),
      position: const LatLng(-2.942484045339299, 104.7279116207683),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(title: 'Halte Sumeks A Punti Kayu'),
    ));
    ///////////
    koridorMarkers['Koridor 2']?.add(Marker(
      markerId: const MarkerId('lokasi_koridor2'),
      position: const LatLng(-2.9166227430209166, 104.7120791283177),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: const InfoWindow(title: 'Stasiun Asrama Haji'),
    ));

    koridorMarkers['Koridor 2']?.add(Marker(
      markerId: const MarkerId('tujuan_koridor2'),
      position: const LatLng(-2.9453386217604223, 104.80073968429603),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(title: 'Kampung Iklim Sematang Borang'),
    ));
    ///////////
    koridorMarkers['Koridor 3']?.add(Marker(
      markerId: const MarkerId('lokasi_koridor3'),
      position: const LatLng(-2.919534986739379,
          104.7119142974792), // Ganti dengan koordinat untuk Koridor 3
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: const InfoWindow(title: 'Stasiun Asrama Haji'),
    ));

    koridorMarkers['Koridor 3']?.add(Marker(
      markerId: const MarkerId('tujuan_koridor3'),
      position: const LatLng(-2.893810356749957, 104.68037635190979),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(title: 'Simpang Talang Betutu'),
    ));
    ///////////
    koridorMarkers['Koridor 4']?.add(Marker(
      markerId: const MarkerId('lokasi_koridor4'),
      position: const LatLng(
          -3.025932, 104.775325), // Ganti dengan koordinat untuk Koridor 3
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: const InfoWindow(title: 'Stasiun Polresta'),
    ));

    koridorMarkers['Koridor 4']?.add(Marker(
      markerId: const MarkerId('tujuan_koridor4'),
      position: const LatLng(-3.034133, 104.779244),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(title: 'Komp. Perumahan Opi'),
    ));
    //////////
    koridorMarkers['Koridor 5']?.add(Marker(
      markerId: const MarkerId('lokasi_koridor5'),
      position: const LatLng(
          -3.023080, 104.775057), // Ganti dengan koordinat untuk Koridor 3
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: const InfoWindow(title: 'Stasiun DJKA'),
    ));

    koridorMarkers['Koridor 5']?.add(Marker(
      markerId: const MarkerId('tujuan_koridor5'),
      position: const LatLng(-3.010222, 104.774806),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(title: 'Pasar Plaju'),
    ));
    /////////
    koridorMarkers['Koridor 6']?.add(Marker(
      markerId: const MarkerId('lokasi_koridor6'),
      position: const LatLng(
          -2.948107, 104.732473), // Ganti dengan koordinat untuk Koridor 3
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: const InfoWindow(title: 'Stasiun RSUD'),
    ));

    koridorMarkers['Koridor 6']?.add(Marker(
      markerId: const MarkerId('tujuan_koridor6'),
      position: const LatLng(-2.930359, 104.745366),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(title: 'Simpang Soak'),
    ));

    /////////
    koridorMarkers['Koridor 7']?.add(Marker(
      markerId: const MarkerId('lokasi_koridor7'),
      position: const LatLng(
          -2.970273, 104.746102), // Ganti dengan koordinat untuk Koridor 3
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: const InfoWindow(title: 'Stadion Kamboja'),
    ));

    koridorMarkers['Koridor 7']?.add(Marker(
      markerId: const MarkerId('tujuan_koridor7'),
      position: const LatLng(-2.993973, 104.726394),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(title: 'Kemang Manis'),
    ));

    /////////
    koridorMarkers['Koridor 8']?.add(Marker(
      markerId: const MarkerId('lokasi_koridor8'),
      position: const LatLng(
          -2.916040, 104.681500), // Ganti dengan koordinat untuk Koridor 3
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: const InfoWindow(title: 'Terminal Alang - Alang Lebar'),
    ));

    koridorMarkers['Koridor 8']?.add(Marker(
      markerId: const MarkerId('tujuan_koridor8'),
      position: const LatLng(-2.923676, 104.681926),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(title: 'Citra Grand City'),
    ));

    ////////

    koridorMarkers['Koridor 9']?.add(Marker(
      markerId: const MarkerId('lokasi_koridor9'),
      position: const LatLng(
          -2.931364, 104.790480), // Ganti dengan koordinat untuk Koridor 3
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: const InfoWindow(title: 'Terminal Sako'),
    ));

    koridorMarkers['Koridor 9']?.add(Marker(
      markerId: const MarkerId('tujuan_koridor9'),
      position: const LatLng(-2.937093, 104.782975),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(title: 'Lorong Pancasila'),
    ));

    /////////
    koridorMarkers['Koridor 10']?.add(Marker(
      markerId: const MarkerId('lokasi_koridor10'),
      position: const LatLng(
          -2.977341, 104.744542), // Ganti dengan koordinat untuk Koridor 3
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow:
          const InfoWindow(title: 'Stasiun Bumi Sriwijaya (Palembang Icon)'),
    ));

    koridorMarkers['Koridor 10']?.add(Marker(
      markerId: const MarkerId('tujuan_koridor10'),
      position: const LatLng(-2.981637, 104.745234),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(title: 'Bank Mandiri'),
    ));
  }

  void onKoridorTap(String koridor) {
    // Tampilkan marker dan polyline untuk koridor yang dipilih
    setState(() {
      koridorText = koridor;
    });
  }

  Set<Polyline> getPolylinesForKoridor(String koridor) {
    Set<Polyline> koridorPolylines = {};
    if (koridor == 'Koridor 1') {
      koridorPolylines.add(Polyline(
        polylineId: const PolylineId('Koridor 1 Feeder'),
        points: DataTransit.koridor1,
        color: Colors.red,
        width: 5,
      ));
    } else if (koridor == 'Koridor 2') {
      koridorPolylines.add(Polyline(
        polylineId: const PolylineId('Koridor 2 Feeder'),
        points: DataTransit.koridor2,
        color: Colors.red,
        width: 5,
      ));
    } else if (koridor == 'Koridor 3') {
      koridorPolylines.add(Polyline(
        polylineId: const PolylineId('Koridor 3 Feeder'),
        points: DataTransit.koridor3,
        color: Colors.red,
        width: 5,
      ));
    } else if (koridor == 'Koridor 4') {
      koridorPolylines.add(Polyline(
        polylineId: const PolylineId('Koridor 4 Feeder'),
        points: DataTransit.koridor4,
        color: Colors.red,
        width: 5,
      ));
    } else if (koridor == 'Koridor 5') {
      koridorPolylines.add(Polyline(
        polylineId: const PolylineId('Koridor 5 Feeder'),
        points: DataTransit.koridor5,
        color: Colors.red,
        width: 5,
      ));
    } else if (koridor == 'Koridor 6') {
      koridorPolylines.add(Polyline(
        polylineId: const PolylineId('Koridor 6 Feeder'),
        points: DataTransit.koridor6,
        color: Colors.red,
        width: 5,
      ));
    } else if (koridor == 'Koridor 7') {
      koridorPolylines.add(Polyline(
        polylineId: const PolylineId('Koridor 7 Feeder'),
        points: DataTransit.koridor7,
        color: Colors.red,
        width: 5,
      ));
    } /////////
    else if (koridor == 'Koridor 8') {
      koridorPolylines.add(Polyline(
        polylineId: const PolylineId('Koridor 8 Bus Transmusi'),
        points: DataTransit.koridor8,
        color: const Color.fromARGB(255, 111, 54, 244),
        width: 5,
      ));
    } else if (koridor == 'Koridor 9') {
      koridorPolylines.add(Polyline(
        polylineId: const PolylineId('Koridor 9 Bus Transmusi'),
        points: DataTransit.koridor9,
        color: const Color.fromARGB(255, 111, 54, 244),
        width: 5,
      ));
    } else if (koridor == 'Koridor 10') {
      koridorPolylines.add(Polyline(
        polylineId: const PolylineId('Koridor 10 Feeder'),
        points: DataTransit.koridor10,
        color: const Color.fromARGB(255, 111, 54, 244),
        width: 5,
      ));
    }
    return koridorPolylines;
  }

  @override
  Widget build(BuildContext context) {
    Set<Polyline> polylines = getPolylinesForKoridor(koridorText);

    return Scaffold(
        appBar: appBarCustom(
          "Rute Transit",
          () => navigationReplace(context, const HomeApp()),
          "",
          false,
          () {},
        ),
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        floatingActionButton: floating(((s) => setState(() {}))),
        body: SafeArea(
          child: Stack(
            children: [
              GoogleMap(
                myLocationButtonEnabled: true,
                markers: koridorMarkers[koridorText]!,
                polylines: polylines,
                mapType: MapType.hybrid,
                onMapCreated: (GoogleMapController controller) =>
                    mapsController.complete(controller),
                initialCameraPosition: camMaps(
                  "Bundaran Air Mancur",
                  const LatLng(-2.945701343679613, 104.6861390556281),
                  15.6,
                  130,
                  50,
                ),
                onTap: (LatLng latLng) {
                  setState(() {
                    polylines.clear();
                  });
                },
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: Colors.white,
                  child: DropdownButton<String>(
                    value: koridorText,
                    items: koridorList.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        koridorText = newValue!;
                        polylines = getPolylinesForKoridor(koridorText);
                      });
                    },
                  ),
                ),
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        koridorText,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        koridorDescriptions[koridorText] ?? '',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              color: Color.fromARGB(255, 63, 84, 98),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
