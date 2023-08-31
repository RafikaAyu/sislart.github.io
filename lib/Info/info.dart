import 'package:flutter/material.dart';
import 'package:sislart/Function/function.dart';
import 'package:sislart/Home/home.dart';
import 'package:sislart/Widget/appbarview.dart';
import 'package:sislart/Widget/textview.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(227, 208, 80, 1),
      appBar: appBarCustom2(
        const Color.fromRGBO(227, 208, 80, 1),
        () {
          navigationReplace(context, const HomeApp());
        },
        onPressed: null,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textView(
              "Tentang Aplikasi:",
              16,
              Colors.black,
              FontWeight.bold,
              TextAlign.left,
              const EdgeInsets.only(top: 30),
            ),
            const SizedBox(height: 10),
            textView(
              "sislarT Wong Kito dirancang untuk memenuhi kebutuhan dan kemudahan terhadap layanan transportasi Umum LRT, berbagai fitur dibangun sesuai dengan apa yang dibutuhkan masyarakat terutama pada akses informasi dan layanan pengoperasian LRT yang sejalan dengan Program Pemerintah yaitu (Gerakan Kembali Ke Angkutan Umum) sebagai dorongan kepada masyarakat, sekaligus penghubung Pemerintah sebagai penyedia layanan dan Masyarakat sebagai pengguna layanan. Nikmati pengalaman menarik dengan menggunakan aplikasi ini!",
              14,
              Colors.black,
              FontWeight.w600,
              TextAlign.justify,
              EdgeInsets.zero,
            ),
            const SizedBox(height: 20),
            textView(
              "Dikelola oleh Ditjen Perkeretaapian melalui Balai Pengelolah Kereta Api Ringan Sumatera Selatan.",
              14,
              Colors.black,
              FontWeight.bold,
              TextAlign.left,
              const EdgeInsets.only(top: 10),
            ),
            const SizedBox(height: 20),
            textView(
              "Informasi Kontak:",
              16,
              Colors.black,
              FontWeight.bold,
              TextAlign.left,
              const EdgeInsets.only(top: 20),
            ),
            ////////////
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.location_on_sharp, color: Colors.black),
                const SizedBox(width: 10),
                textView(
                  "Jalan Noerdin Pandji, Jakabaring Selatan, Banyuasin",
                  14,
                  Colors.black,
                  FontWeight.normal,
                  TextAlign.justify,
                  EdgeInsets.zero,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.phone, color: Colors.black),
                const SizedBox(width: 10),
                textView(
                  "0711-5542499",
                  14,
                  Colors.black,
                  FontWeight.normal,
                  TextAlign.left,
                  EdgeInsets.zero,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.fax_rounded, color: Colors.black),
                const SizedBox(width: 10),
                textView(
                  "0711-5542499",
                  14,
                  Colors.black,
                  FontWeight.normal,
                  TextAlign.left,
                  EdgeInsets.zero,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.email, color: Colors.black),
                const SizedBox(width: 10),
                textView(
                  "balailrtsumsel@dephub.go.id",
                  14,
                  Colors.black,
                  FontWeight.normal,
                  TextAlign.left,
                  EdgeInsets.zero,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.email_rounded, color: Colors.black),
                const SizedBox(width: 10),
                textView(
                  "sislarT@wongkito.com",
                  14,
                  Colors.black,
                  FontWeight.normal,
                  TextAlign.left,
                  EdgeInsets.zero,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
