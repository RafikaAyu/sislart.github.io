import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sislart/Function/function.dart';
import 'package:sislart/Home/home.dart';
import 'package:sislart/Widget/appbarview.dart';
import 'package:sislart/Widget/textview.dart';

class RincianPemesanan extends StatefulWidget {
  final String name;
  final String email;
  final String keberangkatan;
  final String tujuan;
  final String tanggal;
  final String jumlahtiket;
  final String totalharga;
  final String idPayment;

  const RincianPemesanan({
    super.key,
    required this.name,
    required this.email,
    required this.keberangkatan,
    required this.tujuan,
    required this.tanggal,
    required this.jumlahtiket,
    required this.totalharga,
    required this.idPayment,
  });

  @override
  State<RincianPemesanan> createState() => _RincianPemesananState();
}

class _RincianPemesananState extends State<RincianPemesanan> {
  String idPayment = "";

  @override
  void initState() {
    super.initState();
    idPayment = widget.idPayment;
  }

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
      body: ListView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        children: [
          textView("Kode Pemesanan : $idPayment", 18, Colors.black, FontWeight.w700, TextAlign.center, const EdgeInsets.only(top: 20, bottom: 20)),
          Container(
            alignment: Alignment.center,
            child: QrImageView(
              data: idPayment,
              version: QrVersions.auto,
              size: 200,
              gapless: true,
            ),
          )
        ],
      ),
    );
  }
}
