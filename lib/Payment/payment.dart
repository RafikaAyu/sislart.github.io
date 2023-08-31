import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:sislart/Function/function.dart';
import 'package:sislart/LocalData/userdata.dart';
import 'package:sislart/Payment/form_payment.dart';
import 'package:sislart/Payment/function_payment.dart';
import 'package:sislart/Payment/rincian_pemesanan.dart';
import 'package:sislart/Widget/appbarview.dart';

class PaymentGateway extends StatefulWidget {
  final String dataLinkPayment;
  final bool dataStatusPayment;
  const PaymentGateway(
      {super.key,
      required this.dataLinkPayment,
      required this.dataStatusPayment});

  @override
  State<PaymentGateway> createState() => _PaymentGatewayState();
}

class _PaymentGatewayState extends State<PaymentGateway> {
  String userPayment = "https://flip.id/pwf-sandbox/\$sislart/#";
  String linkPayment = "";
  String idPayment = "";
  bool statusPayment = false;
  String? statusWeb = "";
  InAppWebViewController? webViewController;

  void changeData() {
    if (statusWeb == "Bayar via Flip") {
      inputNameEmail(webViewController!, 1);
      inputNameEmail(webViewController!, 3);
    } else if (statusWeb == "Metode pembayaran") {
      removeModePengujian(webViewController!);
    } else if (statusWeb == "Metode Pembayaran") {
      removeModePengujian(webViewController!);
    } else if (statusWeb == "Transaksi sedang diproses") {
      waitingPayment(webViewController!);
    } else if (statusWeb == "Transaksi berhasil") {
      setState(() {
        statusPayment = true;
        successPaymentNoDirect(webViewController!, (idTransaksi) {
          UsersData.idTransaksi = idTransaksi.toString();
          idPayment = idTransaksi.toString();
        }, (status) => statusPayment = status);
        timerDelay(7, () {
          statusPayment = false;
          navigationReplace(
              context,
              RincianPemesanan(
                  idPayment: idPayment,
                  name: "",
                  email: "",
                  keberangkatan: "",
                  tujuan: "",
                  jumlahtiket: "",
                  totalharga: "",
                  tanggal: ""));
        });
      });
    } else {
      waitingPayment(webViewController!);
    }
  }

  @override
  void initState() {
    super.initState();
    statusPayment = widget.dataStatusPayment;
    linkPayment = userPayment + widget.dataLinkPayment;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: appBarCustom(
        "Pembayaran",
        () => navigationReplace(context, const FormPemesanan()),
        "",
        false,
        () {},
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(linkPayment)),
        onWebViewCreated: (controller) async {
          webViewController = controller;
          changeData();
        },
        onTitleChanged: (controller, title) async {
          setState(() => statusWeb = title.toString());
          changeData();
        },
      ),
    );
  }
}
