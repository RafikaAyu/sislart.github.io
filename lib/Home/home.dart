import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sislart/Account/login.dart';
import 'package:sislart/Account/profile.dart';
import 'package:sislart/Function/function.dart';
import 'package:sislart/Info/info.dart';
import 'package:sislart/Jadwal/jadwal_lrt.dart';
import 'package:sislart/LocalData/localdata.dart';
import 'package:sislart/LocalData/userdata.dart';
import 'package:sislart/Payment/form_payment.dart';
import 'package:sislart/Payment/rincian_pemesanan.dart';
import 'package:sislart/SplashScreen/initialisasi.dart';
import 'package:sislart/Stasiun/list_stasiun.dart';
import 'package:sislart/Rute/rute_lrt.dart';
import 'package:sislart/Rute/rute_transit_angkutan_umum.dart';
import 'package:sislart/Widget/appbarview.dart';
import 'package:sislart/Widget/imageview.dart';
import 'package:sislart/Widget/textview.dart';
import 'package:sislart/Widget/widget.dart';

// ignore: unused_import
import 'package:sislart/Wisata/destinasi.dart';
import 'package:social_media_buttons/social_media_icons.dart';
import 'package:url_launcher/url_launcher.dart';
// ignore: depend_on_referenced_packages

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  Timer? timerAddData, timer1, timer2;
  FocusNode focusSearch = FocusNode();
  TextEditingController searchController = TextEditingController();
  PageController controllerImage1 = PageController(viewportFraction: 1.0);
  PageController controllerImage2 = PageController(viewportFraction: 1.0);
  double currentImage1 = 0;
  double currentImage2 = 0;

  @override
  void initState() {
    initialisasiHome();
    timerAddData = Timer.periodic(
        const Duration(milliseconds: 200),
        (timers) => getJadwalGanjil() && getJadwalGenap() == false
            ? timerAddData?.cancel()
            : null);

    focusAdd(focusSearch, searchController);

    playView();
    imageViewerLoop();
    super.initState();
  }

  @override
  void dispose() {
    stopCalledView();
    timerAddData?.cancel();
    searchController.dispose();
    focusSearch.dispose();
    controllerImage1.dispose();
    controllerImage2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 63, 84, 98),
      appBar:
          appBarHome(UsersData.userName ?? "Kamu Belum Login!", context, () {
        stopCalledView();
        navigationPush(context,
            UsersData.userStatus == true ? const ProfileUser() : const Login());
      }),
      body: WillPopScope(
        onWillPop: () async {
          final value = await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                    title: const Text("Pemberitahuan"),
                    content: const Text("Kamu Ingin Keluar Dari Aplikasi?"),
                    backgroundColor: const Color.fromARGB(237, 255, 255, 255),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 192, 51, 41),
                              padding: const EdgeInsets.all(12),
                            ),
                            child: const Text("Iya"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.all(12),
                            ),
                            child: const Text("Tidak"),
                          )
                        ],
                      )
                    ]);
              });
          if (value != null) {
            return Future.value(value);
          } else {
            return Future.value(false);
          }
        },
        child: GestureDetector(
          onTap: () => focusReq(context), // Melepas fokus Search
          child: ListView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            children: [
              imageView2(
                  190,
                  30,
                  5,
                  15,
                  15,
                  controllerImage1,
                  LocalData.cacheImageHomeUrl,
                  LocalData.imageHomeUrl,
                  currentImage1),
              ////////////
              /*Container(
                margin: const EdgeInsets.only(
                    left: 22, right: 22, top: 25, bottom: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: inputTextController(
                          searchController, focusSearch, "Mau Kemana Hari Ini"),
                    ),
                    IconButton(
                      onPressed: () {
                        // Aksi pencarian ketika tombol search ditekan
                        String searchQuery = searchController.text;
                        String filterBy =
                            "Stasiun"; // Ganti dengan filter yang sesuai
                        performSearch(searchQuery, filterBy);
                      },
                      icon: const Icon(Icons.search),
                      color: Colors.white,
                    ),
                  ],
                ),
              ),*/

              ////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  svgButton("Stasiun LRT", "assets/svg/home/svg_stasiun.svg",
                      45, () => navigationPush(context, const ListStasiun())),
                  iconButton(
                      "Jadwal LRT",
                      Icons.access_time_filled_rounded,
                      45,
                      rgba(18, 44, 61, 1),
                      () => navigationPush(context, const JadwalLRT())),
                  svgButton("Rute LRT", "assets/svg/home/svg_rute_lrt.svg", 45,
                      () => navigationPush(context, const PetaGoogle())),
                  iconButton(
                      "Destinasi Wisata",
                      Icons.wallet_travel_outlined,
                      45,
                      rgba(18, 44, 61, 1),
                      () => navigationPush(context, const Destinasi())),
                ],
              ),
              /////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  svgButton("Pesan Tiket", "assets/svg/home/svg_tiket.svg", 45,
                      () {
                    navigationPush(context, const FormPemesanan());
                  }),
                  iconButton("Riwayat Pemesanan", Icons.history, 45,
                      rgba(18, 44, 61, 1), () {
                    navigationPush(
                        context,
                        const RincianPemesanan(
                            idPayment: "",
                            name: "",
                            email: "",
                            keberangkatan: "",
                            tujuan: "",
                            jumlahtiket: "",
                            totalharga: "",
                            tanggal: ""));
                  }),
                  svgButton(
                      "Rute Transit",
                      "assets/svg/home/svg_rute_transit.svg",
                      45,
                      () =>
                          navigationPush(context, const TransitAngkutanUmum())),
                  svgButton("Tentang App", "assets/svg/home/svg_info.svg", 45,
                      () => navigationPush(context, const Info())),
                ],
              ),
              ////////////
              textView("Artikel dan Berita", 16, Colors.white, FontWeight.w700,
                  TextAlign.start, const EdgeInsets.only(left: 30, top: 20)),
              ////////////
              imageView(
                  180,
                  15,
                  20,
                  15,
                  15,
                  controllerImage2,
                  LocalData.cacheImageArtikelUrl,
                  LocalData.imageArtikelUrl,
                  currentImage2),
              ////////////
              textView(
                  "Ikuti Sosial Media LRT Sumsel :",
                  15,
                  Colors.white,
                  FontWeight.bold,
                  TextAlign.start,
                  const EdgeInsets.only(left: 30, top: 20)),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 5, bottom: 20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // ignore: deprecated_member_use
                        launch(
                            "https://www.instagram.com/lrtsumselofficial/?hl=id");
                      },
                      icon: const Icon(SocialMediaIcons.instagram),
                      color: Colors.white,
                      iconSize: 30,
                    ),
                    IconButton(
                      onPressed: () {
                        // ignore: deprecated_member_use
                        launch(
                            "https://twitter.com/lrtsumsel?s=21&t=djbRedL0GW8yy0q5Y1r3vA");
                      },
                      icon: const Icon(SocialMediaIcons.twitter),
                      color: Colors.white,
                      iconSize: 30,
                    ),
                    IconButton(
                      onPressed: () {
                        // ignore: deprecated_member_use
                        launch("https://www.facebook.com/LRTSumselOfficial");
                      },
                      icon: const Icon(SocialMediaIcons.facebook),
                      color: Colors.white,
                      iconSize: 30,
                    ),
                    IconButton(
                      onPressed: () {
                        // ignore: deprecated_member_use
                        launch("https://www.youtube.com/@lrtsumsel4659/videos");
                      },
                      icon: const Icon(SocialMediaIcons.youtube_play),
                      color: Colors.white,
                      iconSize: 30,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      ////////////
    );
  }

  playView() {
    controllerImage1.addListener(() {
      setState(() {
        currentImage1 = controllerImage1.page!.toDouble();
      });
    });

    controllerImage2.addListener(() {
      setState(() {
        currentImage2 = controllerImage2.page!.toDouble();
      });
    });
  }

  stopCalledView() {
    timer1?.cancel();
    timer2?.cancel();

    controllerImage1.removeListener(() {
      setState(() {});
    });

    controllerImage2.removeListener(() {
      setState(() {});
    });
  }

  imageViewerLoop() {
    timer2 = Timer.periodic(const Duration(seconds: 10), (Timer timer) async {
      if (currentImage1 < LocalData.imageHomeUrl.length - 1) {
        currentImage1++;
      } else {
        currentImage1 = 0;
      }
      controllerImage1.animateToPage(
        currentImage1.toInt(),
        duration: const Duration(milliseconds: 1000),
        curve: Curves.fastOutSlowIn,
      );
    });

    timer1 = Timer.periodic(const Duration(seconds: 15), (Timer timer) async {
      if (currentImage2 < LocalData.imageArtikelUrl.length - 1) {
        currentImage2++;
      } else {
        currentImage2 = 0;
      }
      controllerImage2.animateToPage(
        currentImage2.toInt(),
        duration: const Duration(milliseconds: 1000),
        curve: Curves.fastOutSlowIn,
      );
    });
  }
}

void performSearch(String searchQuery, String filterBy) {
  List<String> dataList = [
    'Jembatan Ampera',
    'Jakabaring',
    'Palembang Icon',
    'Bumi Sriwijaya',
    'Punti Kayu',
    'Destinasi Kota Palembang',
    'Stasiun Pertama',
    'Stasiun Terakhir',
  ];

  // Filter data berdasarkan query pencarian
  List<String> searchResults = dataList
      .where((data) => data.toLowerCase().contains(searchQuery.toLowerCase()))
      .toList();

  // Jika filterBy bukan null, tambahkan logika filterisasi berdasarkan kategori atau atribut lainnya
  if (filterBy == 'Stasiun') {
    searchResults = searchResults
        .where((data) => data.toLowerCase().contains('stasiun'.toLowerCase()))
        .toList();
  }
  // Contoh filter berdasarkan lokasi
  else if (filterBy == 'Palembang') {
    searchResults = searchResults
        .where((data) => data.toLowerCase().contains('palembang'))
        .toList();
  }

  // Cetak hasil pencarian setelah filterisasi
  // ignore: avoid_print
  print('Hasil pencarian dengan filter ($filterBy): $searchResults');
}
