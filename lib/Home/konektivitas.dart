import 'package:flutter/material.dart';
import 'package:sislart/Function/function.dart';
import 'package:sislart/Home/home.dart';
import 'package:sislart/Widget/appbarview.dart';

class Konektivitas extends StatefulWidget {
  const Konektivitas({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<Konektivitas> createState() => _KonektivitasState();
}

class _KonektivitasState extends State<Konektivitas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom2(
        const Color.fromRGBO(227, 208, 80, 1),
        () {
          navigationReplace(context, const HomeApp());
        },
        onPressed: null,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul dengan gambar jaringan (Network Image)
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16), // Jarak antar elemen
            // Gambar jaringan (Network Image)
            Image.network(
              'https://assetsquokka.files.wordpress.com/2023/07/konektivitas-1.png?w=1400&h=', // Ganti dengan URL gambar yang sesuai
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16), // Jarak antar elemen
            // Paragraf tulisan
            const Text(
                "“Naik transportasi umum di kota Palembang sekarang lebih mudah, murah, dan aman. Seperti misalnya naik LRT Palembang. Di stasiun-stasiun banyak petugas yang berjaga, kemudian banyak feeder seperti angkot yang semakin memperluas jangkauan dan gratis. Ini juga sangat membantu para pelaku UMKM karena tarifnya terjangkau,” ungkap Menhub. Seorang peserta perempuan bernama Novi yang hadir dalam diskusi, sebelumnya menyampaikan pengalamannya naik angkutan umum di Kota Palembang yang saat ini sudah semakin mudah diakses, namun dirinya masih mengkhawatirkan soal keamanannya. Menhub menjelaskan selain ada petugas yang berjaga, di dalam angkutan massal seperti LRT maupun angkutan feeder juga dipasang CCTV untuk memastikan seluruh penumpang mendapatkan keamanan dan kenyamanan. Jika ada pengemudi yang ugal-ugalan atau tidak sopan bisa diketahui segera untuk dilakukan tindakan teguran atau sanksi baik oleh operator maupun regulator. Menhub menyampaikan, kota Palembang merupakan pionir integrasi antarmoda di Indonesia, yang meliputi moda angkutan udara, jalan, laut, sungai dan kereta api.")
          ],
        ),
      ),
    );
  }
}
