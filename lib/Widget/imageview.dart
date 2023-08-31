import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sislart/Home/konektivitas.dart';
import 'package:sislart/Home/naiklrt.dart';
import 'package:sislart/Home/rutebaru.dart';

Widget imageView(
    double height,
    double top,
    double bottom,
    double leftRight,
    double rounded,
    PageController controller,
    DefaultCacheManager cacheManager,
    List<dynamic> image,
    double currentImage) {
  return Column(
    children: [
      Container(
        height: height,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        margin: EdgeInsets.only(top: top, left: leftRight, right: leftRight),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: image.length,
          controller: controller,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(left: leftRight, right: leftRight),
              width: MediaQuery.of(context).size.width - (leftRight * 2),
              child: Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - (leftRight * 2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(rounded),
                      child: CachedNetworkImage(
                        cacheManager: cacheManager,
                        key: UniqueKey(),
                        fit: BoxFit.fill,
                        imageUrl: image[index],
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: GestureDetector(
                      onTap: () {
                        // Ganti dengan navigasi ke halaman yang diinginkan berdasarkan index
                        switch (index) {
                          case 0:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const NaikLRT(
                                  title:
                                      'LRT, BUS, DAN Angkot Sudah Saling Terintegrasi, Kini Naik Angkutan Umum Semakin Mudah',
                                ),
                              ),
                            );
                            break;
                          case 1:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Konektivitas(
                                  title:
                                      'Konektivitas Transportasi Integrasi Antar Moda Permudah Kaum Perempuan & UMKM',
                                ),
                              ),
                            );
                            break;
                          default:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FeederBaru(
                                  title:
                                      'Kementrian Perhubungan tambah 5 rute baru Angkot Feeder LRT Sumsel',
                                ),
                              ),
                            );
                        }
                      },
                      child: Text(
                        index == 0
                            ? 'LRT, BUS, dan Angkot Sudah Saling Terintegrasi'
                            : index == 1
                                ? 'Konektivitas Transportasi Integrasi Antar Moda Permudah Kaum Perempuan & UMKM'
                                : 'Kementrian Perhubungan tambah 5 rute baru Angkot Feeder LRT Sumsel ',
                        style: GoogleFonts.quicksand(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 16, bottom: bottom),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            image.length,
            (index) {
              return Container(
                margin: const EdgeInsets.only(right: 5),
                alignment: Alignment.center,
                height: 9,
                width: 9,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentImage == index ? Colors.black : Colors.white,
                ),
              );
            },
          ),
        ),
      ),
    ],
  );
}

Widget imageView2(
    double height,
    double top,
    double bottom,
    double leftRight,
    double rounded,
    PageController controller,
    DefaultCacheManager cacheManager,
    List<dynamic> image,
    double currentImage) {
  return Column(
    children: [
      Container(
        height: height,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        margin: EdgeInsets.only(top: top, left: leftRight, right: leftRight),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: image.length,
          controller: controller,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(left: leftRight, right: leftRight),
              width: MediaQuery.of(context).size.width - (leftRight * 2),
              child: Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - (leftRight * 2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(rounded),
                      child: CachedNetworkImage(
                        cacheManager: cacheManager,
                        key: UniqueKey(),
                        fit: BoxFit.fill,
                        imageUrl: image[index],
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 16, bottom: bottom),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            image.length,
            (index) {
              return Container(
                margin: const EdgeInsets.only(right: 5),
                alignment: Alignment.center,
                height: 9,
                width: 9,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentImage == index ? Colors.black : Colors.white,
                ),
              );
            },
          ),
        ),
      ),
    ],
  );
}
