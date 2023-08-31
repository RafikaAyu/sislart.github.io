import 'package:flutter/material.dart';
import 'package:sislart/Function/function.dart';
import 'package:sislart/Payment/form_payment.dart';
import 'package:sislart/Payment/rincian_pemesanan.dart';
import 'package:sislart/Widget/appbarview.dart';

// Buat class atau model untuk menyimpan data riwayat pemesanan
class PemesananModel {
  final String idPemesanan;
  final String name;
  final String email;
  final String keberangkatan;
  final String tujuan;
  final String tanggal;
  final String jumlahTiket;
  final String totalHarga;

  PemesananModel({
    required this.idPemesanan,
    required this.name,
    required this.email,
    required this.keberangkatan,
    required this.tujuan,
    required this.tanggal,
    required this.jumlahTiket,
    required this.totalHarga,
  });
}

class RiwayatPemesanan extends StatefulWidget {
  final List<PemesananModel> dataRiwayat;

  const RiwayatPemesanan({Key? key, required this.dataRiwayat}) : super(key: key);

  @override
  State<RiwayatPemesanan> createState() => _RiwayatPemesananState();
}

class _RiwayatPemesananState extends State<RiwayatPemesanan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(
        "Riwayat Pemesanan",
        () => navigationReplace(context, const FormPemesanan()),
        "",
        false,
        () {},
      ),
      body: ListView.builder(
        itemCount: widget.dataRiwayat.length,
        itemBuilder: (context, index) {
          PemesananModel pemesanan = widget.dataRiwayat[index];
          return ListTile(
            onTap: () {
              // Navigasi ke halaman RincianPemesanan dengan mengirimkan ID pemesanan
              navigationPush(
                context,
                RincianPemesanan(
                  idPayment: pemesanan.idPemesanan,
                  name: pemesanan.name,
                  email: pemesanan.email,
                  keberangkatan: pemesanan.keberangkatan,
                  tujuan: pemesanan.tujuan,
                  tanggal: pemesanan.tanggal,
                  jumlahtiket: pemesanan.jumlahTiket,
                  totalharga: pemesanan.totalHarga,
                ),
              );
            },
            title: Text("ID Pemesanan: ${pemesanan.idPemesanan}"),
            // Tambahkan atribut lain sesuai kebutuhan
            // ...
          );
        },
      ),
    );
  }
}
