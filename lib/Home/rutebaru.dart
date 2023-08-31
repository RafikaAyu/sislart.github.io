import 'package:flutter/material.dart';
import 'package:sislart/Function/function.dart';
import 'package:sislart/Home/home.dart';
import 'package:sislart/Widget/appbarview.dart';

class FeederBaru extends StatefulWidget {
  const FeederBaru({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<FeederBaru> createState() => _FeederBaruState();
}

class _FeederBaruState extends State<FeederBaru> {
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
              'https://assetsquokka.files.wordpress.com/2023/07/feeder.png?w=1024', // Ganti dengan URL gambar yang sesuai
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16), // Jarak antar elemen
            // Paragraf tulisan
            const Text(
                "Adapun lima rute yang baru ditambahkan antara lain: Stasiun LRT Polresta Palembang-Kompleks OPI, Stasiun LRT RSUD-Sukawinatan, Stasiun LRT Asrama Haji-Talang Betutu, Stasiun LRT DJKA-Terminal Pasar Plaju, serta Kamboja-Bukit Siguntang via Stasiun Demang. Kelima rute tersebut melengkapi dua koridor yang sudah ada sebelumnya, yaitu Talang Kelapa-Talang Buruk via Stasiun Asrama Haji dan Stasiun Asrama Haji-Sematang Borang via Jalan Noerdin Pandji. Hingga saat ini, jumlah angkot feeder LRT yang melayani di kota Palembang berjumlah 58 unit. Menteri Perhubungan Budi Karya Sumadi mengatakan, upaya peningkatan layanan angkutan massal yang dilakukan, merupakan wujud nyata implementasi Gerakan Nasional Kembali ke Angkutan Umum (GNKAU) yang dikampanyekan Kemenhub sejak awal tahun ini. “Integrasi antarmoda adalah suatu keharusan. Oleh karenanya, hari ini kita tambah lima rute baru angkot feeder untuk menambah minat masyarakat Palembang dan sekitarnya menggunakan LRT. Penambahan rute ini telah melalui hasil riset yang dikerjasamakan dengan perguruan tinggi,” ujar Menhub saat menghadiri kegiatan peluncuran lima koridor baru angkot feeder LRT Sumsel secara daring, Sabtu (10/12)."),
          ],
        ),
      ),
    );
  }
}
