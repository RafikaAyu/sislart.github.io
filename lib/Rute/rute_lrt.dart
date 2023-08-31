import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sislart/Function/function.dart';
import 'package:sislart/GoogleMaps/function_maps.dart';
import 'package:sislart/GoogleMaps/mapsview.dart';
import 'package:sislart/Home/home.dart';
import 'package:sislart/LocalData/mapsdata.dart';
import 'package:sislart/SplashScreen/initialisasi.dart';
import 'package:sislart/Widget/appbarview.dart';
import 'package:sislart/Widget/multiplefloatingview.dart';

class PetaGoogle extends StatefulWidget {
  const PetaGoogle({super.key});

  @override
  State<PetaGoogle> createState() => _PetaGoogleState();
}

class _PetaGoogleState extends State<PetaGoogle> with TickerProviderStateMixin {
  final Completer<GoogleMapController> mapsController =
      Completer<GoogleMapController>();
  Timer? timerMarkerLRT, timerAddData;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  int tapUpdateCamLRT = 0;
  bool statusLRT = false;
  bool statusLRTAkanHabis = false;
  bool statusCam = false;

  @override
  void dispose() {
    timerMarkerLRT?.cancel();
    timerAddData?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    setMarkerPlaces(markers, mapsController);
    setMarkerStasiun(markers, mapsController);
    setPolylineRute(polylines, DataMaps.totalRuteLRT);
    setThemeMaps(mapsController, 'assets/json/nightMaps.json');
    timerAddData = Timer.periodic(
        const Duration(milliseconds: 200),
        (timers) => getJadwalGanjil() && getJadwalGenap() == false
            ? timerAddData?.cancel()
            : null);

    timerMarkerLRT =
        Timer.periodic(const Duration(milliseconds: 700), (timers) {
      setState(() {
        FungsiMaps.jumlahLRTOperasiBandaraKeDJKA = getLRTOperasi(
            DataMaps.jadwalBandaraKeDJKA, DataMaps.namaStasiunGenap);
        FungsiMaps.jumlahLRTOperasiDJKAkeBandara = getLRTOperasi(
            DataMaps.jadwalDJKAkeBandara, DataMaps.namaStasiunGanjil);
        if (FungsiMaps.jumlahLRTOperasiBandaraKeDJKA < 1 &&
            FungsiMaps.jumlahLRTOperasiDJKAkeBandara < 1) {
          statusLRT = false;
        } else {
          statusLRT = true;
        }
        cekJadwalAkanHabis();
        generateMarkers();
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom("Rute LRT",
          () => navigationReplace(context, const HomeApp()), "", false, () {}),
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      floatingActionButton: floating(((s) => setState(() {}))),
      body: Stack(
        children: [
          maps(
              markers,
              polylines,
              mapsController,
              camMaps("Bundaran Air Mancur", titik(-2.988178, 104.759616), 15.6,
                  130, 50),
              (v) => tapUpdateCamLRT = v),
          legenda(FungsiMaps.lalulintas),
          widgetStatus(statusLRT, statusLRTAkanHabis, "JADWAL LRT TERSEDIA",
              "JADWAL LRT AKAN HABIS", "JADWAL LRT TIDAK TERSEDIA"),
          
        ],
      ),
    );
  }

  cekJadwalAkanHabis() {
    if (DataMaps.jadwalDJKAkeBandara.length ==
        DataMaps.namaStasiunGanjil.length) {
      if (DataMaps.jadwalDJKAkeBandara[0].length > 1) {
        // print("Jadwal Ganjil : ${DataMaps.jadwalDJKAkeBandara[0][DataMaps.jadwalDJKAkeBandara[0].length - 4]}");
        DateTime jadwalAkanHabis = DateFormat('HH:mm:ss').parse(
            DataMaps.jadwalDJKAkeBandara[0]
                [DataMaps.jadwalDJKAkeBandara[0].length - 4]);
        if (realTime().isAfter(jadwalAkanHabis)) {
          statusLRTAkanHabis = true;
        } else {
          statusLRTAkanHabis = false;
        }
      }
    }
  }

  Set<Marker> generateMarkers() {
    // print("Jadwal Ganjil : ${FungsiMaps.jumlahLRTOperasiDJKAkeBandara} | Genap : ${FungsiMaps.jumlahLRTOperasiBandaraKeDJKA}");
    // isAfter apakah waktu sekarang TELAH melewati data waktu || isBefore apakah waktu sekarang BELUM melewati data waktu

    // DJKA KE BANDARA (GANJIL)
    if (DataMaps.jadwalDJKAkeBandara.length ==
        DataMaps.namaStasiunGanjil.length) {
      // print("Jadwal Ganjil : ${DataMaps.jadwalDJKAkeBandara[0][0]}");
      for (int stasiun = 0;
          stasiun < DataMaps.namaStasiunGanjil.length;
          stasiun++) {
        for (int peron = 0;
            peron < DataMaps.jadwalDJKAkeBandara[stasiun].length;
            peron++) {
          int idSampai = stasiun + 1 < DataMaps.namaStasiunGanjil.length - 1
              ? stasiun + 1
              : DataMaps.jadwalDJKAkeBandara.length - 1;
          DateTime jadwalPeronBerangkat = DateFormat('HH:mm:ss')
              .parse(DataMaps.jadwalDJKAkeBandara[stasiun][peron]);
          DateTime jadwalPeronSampai = DateFormat('HH:mm:ss')
              .parse(DataMaps.jadwalDJKAkeBandara[idSampai][peron]);

          if (realTime().isAfter(jadwalPeronBerangkat) &&
              realTime().isBefore(jadwalPeronSampai)) {
            int tipePeron = (peron * 2) + 1; // Menjadi Ganjil
            int jarak = durasiDetik(jadwalPeronBerangkat, jadwalPeronSampai);
            int posisiSekarang = durasiDetik(realTime(), jadwalPeronSampai);
            // print("Jadwal Ganjil : ${DataMaps.namaStasiunGanjil[stasiun]}(Peron $tipePeron) | Berangkat : $jadwalPeronBerangkat | Sampai : $jadwalPeronSampai");

            // ========================================== Tambah Marker LRT =========================================== //
            setLRT(
                'DJKA ke Jakabaring',
                DataMaps.namaStasiunGanjil,
                'djka',
                stasiun,
                tipePeron,
                DataMaps.jakabaringkedjka,
                posisiSekarang,
                jarak,
                false,
                FungsiMaps.iconLRTGanjil);
            setLRT(
                'Jakabaring ke Polresta',
                DataMaps.namaStasiunGanjil,
                'jakabaring',
                stasiun,
                tipePeron,
                DataMaps.polrestakejakabaring,
                posisiSekarang,
                jarak,
                false,
                FungsiMaps.iconLRTGanjil);
            setLRT(
                'Polresta ke Ampera',
                DataMaps.namaStasiunGanjil,
                'polresta',
                stasiun,
                tipePeron,
                DataMaps.amperakepolresta,
                posisiSekarang,
                jarak,
                false,
                FungsiMaps.iconLRTGanjil);
            setLRT(
                'Ampera ke Cinde',
                DataMaps.namaStasiunGanjil,
                'ampera',
                stasiun,
                tipePeron,
                DataMaps.cindekeampera,
                posisiSekarang,
                jarak,
                false,
                FungsiMaps.iconLRTGanjil);
            setLRT(
                'Cinde ke DISHUB',
                DataMaps.namaStasiunGanjil,
                'cinde',
                stasiun,
                tipePeron,
                DataMaps.dishubkecinde,
                posisiSekarang,
                jarak,
                false,
                FungsiMaps.iconLRTGanjil);
            setLRT(
                'DISHUB ke Bumi Sriwijaya',
                DataMaps.namaStasiunGanjil,
                'dishub',
                stasiun,
                tipePeron,
                DataMaps.bumisriwijayakedishub,
                posisiSekarang,
                jarak,
                false,
                FungsiMaps.iconLRTGanjil);
            setLRT(
                'Bumi Sriwijaya ke Demang Lebar D',
                DataMaps.namaStasiunGanjil,
                'bumisriwijaya',
                stasiun,
                tipePeron,
                DataMaps.demangkebumisriwijaya,
                posisiSekarang,
                jarak,
                false,
                FungsiMaps.iconLRTGanjil);
            setLRT(
                'Demang Lebar Daun ke Garuda Dempo',
                DataMaps.namaStasiunGanjil,
                'demang',
                stasiun,
                tipePeron,
                DataMaps.garudadempokedemang,
                posisiSekarang,
                jarak,
                false,
                FungsiMaps.iconLRTGanjil);
            setLRT(
                'Garuda Dempo ke RSUD',
                DataMaps.namaStasiunGanjil,
                'garudadempo',
                stasiun,
                tipePeron,
                DataMaps.rsudkegarudadempo,
                posisiSekarang,
                jarak,
                false,
                FungsiMaps.iconLRTGanjil);
            setLRT(
                'RSUD ke Punti Kayu',
                DataMaps.namaStasiunGanjil,
                'rsud',
                stasiun,
                tipePeron,
                DataMaps.puntikayukersud,
                posisiSekarang,
                jarak,
                false,
                FungsiMaps.iconLRTGanjil);
            setLRT(
                'Punti Kayu ke Asrama',
                DataMaps.namaStasiunGanjil,
                'puntikayu',
                stasiun,
                tipePeron,
                DataMaps.asramakepuntikayu,
                posisiSekarang,
                jarak,
                false,
                FungsiMaps.iconLRTGanjil);
            setLRT(
                'Asrama Haji ke Bandara',
                DataMaps.namaStasiunGanjil,
                'asrama',
                stasiun,
                tipePeron,
                DataMaps.bandarakeasrama,
                posisiSekarang,
                jarak,
                false,
                FungsiMaps.iconLRTGanjil);
            // ========================================== Tambah Marker LRT =========================================== //
          }
        }
      }
    }

    // BANDARA KE DJKA (GENAP)
    if (DataMaps.jadwalBandaraKeDJKA.length ==
        DataMaps.namaStasiunGenap.length) {
      // print("Jadwal Genap : ${DataMaps.jadwalBandaraKeDJKA[0][0]} | Panjang ${DataMaps.jadwalBandaraKeDJKA.length}");
      // print("Jadwal ${DataMaps.jadwalBandaraKeDJKA[0]}");
      for (int stasiun = 0;
          stasiun < DataMaps.namaStasiunGenap.length;
          stasiun++) {
        for (int peron = 0;
            peron < DataMaps.jadwalBandaraKeDJKA[stasiun].length;
            peron++) {
          int idSampai = stasiun + 1 < DataMaps.namaStasiunGenap.length - 1
              ? stasiun + 1
              : DataMaps.jadwalBandaraKeDJKA.length - 1;
          DateTime jadwalPeronBerangkat = DateFormat('HH:mm:ss')
              .parse(DataMaps.jadwalBandaraKeDJKA[stasiun][peron]);
          DateTime jadwalPeronSampai = DateFormat('HH:mm:ss')
              .parse(DataMaps.jadwalBandaraKeDJKA[idSampai][peron]);

          if (realTime().isAfter(jadwalPeronBerangkat) &&
              realTime().isBefore(jadwalPeronSampai)) {
            int tipePeron = (peron + 1) * 2; // Menjadi Genap
            int jarak = durasiDetik(jadwalPeronBerangkat, jadwalPeronSampai);
            int posisiSekarang = durasiDetik(realTime(), jadwalPeronSampai);
            // print("Jadwal Genap: ${DataMaps.namaStasiunGenap[stasiun]}(Peron $tipePeron) | Berangkat : $jadwalPeronBerangkat | Sampai : $jadwalPeronSampai");

            // ========================================== Tambah Marker LRT =========================================== //
            setLRT(
                'Bandara ke Asrama Haji',
                DataMaps.namaStasiunGenap,
                'bandara',
                stasiun,
                tipePeron,
                DataMaps.bandarakeasrama,
                posisiSekarang,
                jarak,
                true,
                FungsiMaps.iconLRTGenap);
            setLRT(
                'Asrama Haji ke Punti Kayu',
                DataMaps.namaStasiunGenap,
                'asrama',
                stasiun,
                tipePeron,
                DataMaps.asramakepuntikayu,
                posisiSekarang,
                jarak,
                true,
                FungsiMaps.iconLRTGenap);
            setLRT(
                'Punti Kayu ke RSUD',
                DataMaps.namaStasiunGenap,
                'puntikayu',
                stasiun,
                tipePeron,
                DataMaps.puntikayukersud,
                posisiSekarang,
                jarak,
                true,
                FungsiMaps.iconLRTGenap);
            setLRT(
                'RSUD ke Garuda Dempo',
                DataMaps.namaStasiunGenap,
                'rsud',
                stasiun,
                tipePeron,
                DataMaps.rsudkegarudadempo,
                posisiSekarang,
                jarak,
                true,
                FungsiMaps.iconLRTGenap);
            setLRT(
                'Garuda Dempo ke Demang Lebar Daun',
                DataMaps.namaStasiunGenap,
                'garudadempo',
                stasiun,
                tipePeron,
                DataMaps.garudadempokedemang,
                posisiSekarang,
                jarak,
                true,
                FungsiMaps.iconLRTGenap);
            setLRT(
                'Demang Lebar D ke Bumi Sriwijaya',
                DataMaps.namaStasiunGenap,
                'demang',
                stasiun,
                tipePeron,
                DataMaps.demangkebumisriwijaya,
                posisiSekarang,
                jarak,
                true,
                FungsiMaps.iconLRTGenap);
            setLRT(
                'Bumi Sriwijaya ke DISHUB',
                DataMaps.namaStasiunGenap,
                'bumisriwijaya',
                stasiun,
                tipePeron,
                DataMaps.bumisriwijayakedishub,
                posisiSekarang,
                jarak,
                true,
                FungsiMaps.iconLRTGenap);
            setLRT(
                'DISHUB ke Cinde',
                DataMaps.namaStasiunGenap,
                'dishub',
                stasiun,
                tipePeron,
                DataMaps.dishubkecinde,
                posisiSekarang,
                jarak,
                true,
                FungsiMaps.iconLRTGenap);
            setLRT(
                'Cinde ke Ampera',
                DataMaps.namaStasiunGenap,
                'cinde',
                stasiun,
                tipePeron,
                DataMaps.cindekeampera,
                posisiSekarang,
                jarak,
                true,
                FungsiMaps.iconLRTGenap);
            setLRT(
                'Ampera ke Polresta',
                DataMaps.namaStasiunGenap,
                'ampera',
                stasiun,
                tipePeron,
                DataMaps.amperakepolresta,
                posisiSekarang,
                jarak,
                true,
                FungsiMaps.iconLRTGenap);
            setLRT(
                'Polresta ke Jakabaring',
                DataMaps.namaStasiunGenap,
                'polresta',
                stasiun,
                tipePeron,
                DataMaps.polrestakejakabaring,
                posisiSekarang,
                jarak,
                true,
                FungsiMaps.iconLRTGenap);
            setLRT(
                'Jakabaring ke DJKA',
                DataMaps.namaStasiunGenap,
                'jakabaring',
                stasiun,
                tipePeron,
                DataMaps.jakabaringkedjka,
                posisiSekarang,
                jarak,
                true,
                FungsiMaps.iconLRTGenap);
            // ========================================== Tambah Marker LRT =========================================== //
          }
        }
      }
    }

    return markers;
  }

  setLRT(
      String tujuanLRT,
      List<dynamic> namaStasiun,
      String idStasiun,
      int indexStasiun,
      int peron,
      List<dynamic> lengthDataMaps,
      int posisiSekarang,
      int jarak,
      bool ganjilGenap,
      BitmapDescriptor icon) {
    // print("Jadwal ${namaStasiun[indexStasiun]}");
    if (namaStasiun[indexStasiun] == idStasiun) {
      int increment;
      ganjilGenap == true
          ? increment =
              mapping(posisiSekarang, jarak, 0, 0, lengthDataMaps.length)
          : increment =
              mapping(posisiSekarang, jarak, 0, lengthDataMaps.length, 0);

      if (increment >= 0 && increment <= lengthDataMaps.length - 1) {
        if (statusCam == false) {
          updateCamMaps(mapsController, lengthDataMaps[increment], 15.5, 80);
        }
        statusCam = true;

        if (tapUpdateCamLRT == peron) {
          updateCamMaps(mapsController, lengthDataMaps[increment], 15.5, 50);
        }
        markers.add(markerLRT(icon, lengthDataMaps[increment], peron,
            "LRT($peron) $tujuanLRT", (v) => tapUpdateCamLRT = v));
      } else {
        markers.clear();
        setMarkerStasiun(markers, mapsController);
        setMarkerPlaces(markers, mapsController);
      }
    }
  }
}
