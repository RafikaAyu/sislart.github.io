import 'package:flutter/material.dart';
import 'package:sislart/Function/function.dart';
import 'package:sislart/Home/home.dart';
import 'package:sislart/Widget/appbarview.dart';

class NaikLRT extends StatefulWidget {
  const NaikLRT({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<NaikLRT> createState() => _NaikLRTState();
}

class _NaikLRTState extends State<NaikLRT> {
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
              'https://assetsquokka.files.wordpress.com/2023/07/rectangle-19.png', // Ganti dengan URL gambar yang sesuai
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16), // Jarak antar elemen
            // Paragraf tulisan
            const Text(
              '“Naik angkutan umum di Kota Palembang sekarang semakin nyaman dan bisa diandalkan. Harga terjangkau, aksesnya mudah, tidak macet, mengurangi tingkat kecelakaan, dan lebih ramah lingkungan,” kata Menhub.Menhub menjelaskan, Gerakan Nasional Kembali Ke Angkutan Umum merupakan bagian dari upaya pemerintah untuk mengembangkan angkutan umum berbasis jalan dan rel di kawasan perkotaan. Melalui gerakan ini, Kemenhub mengajak masyarakat untuk mengutamakan penggunaan angkutan umum daripada kendaraan pribadi dalam melakukan aktivitasnya sehari-hari. Kota Palembang menjadi kota percontohan dari gerakan ini, yang nantinya dapat diaplikasikan di kota-kota lainnya yang memiliki karakteristik yang sama.“Kota Palembang menjadi salah satu kota yang memiliki angkutan umum yang lengkap, mulai dari bus, LRT, angkot, sampai ke angkutan sungai dan danau, yang saling terhubung. Kita ingin angkutan massal yang sudah dibangun ini dapat dimanfaatkan secara maksimal oleh masyarakat Palembang dan sekitarnya,” ujarnya. ',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
