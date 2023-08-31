import 'package:flutter/material.dart';
import 'package:sislart/Function/function.dart';
import 'package:sislart/Home/home.dart';
import 'package:sislart/Payment/payment.dart';
import 'package:sislart/Widget/appbarview.dart';

class FormPemesanan extends StatefulWidget {
  const FormPemesanan({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _FormPemesananState createState() => _FormPemesananState();
}

class _FormPemesananState extends State<FormPemesanan> {
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  int jumlahTiket = 0;

  // Map dengan stasiun dan jumlah tiket sebagai kunci, serta link pembayaran sebagai nilai
  Map<String, Map<int, String>> paymentLinks = {
    "Stasiun DJKA - Stasiun Bandara SMB II": {
      1: "stasiunbandaradjka-1",
      2: "stasiundjkastasiunbandarasmbii",
      3: "stasiundjkastasiunbandarasmbii-1",
      4: "stasiundjkastasiunbandarasmbii-2",
      5: "stasiundjkastasiunbandarasmbii-3",
      6: "stasiundjkastasiunbandarasmbii-4",
      7: "stasiundjkastasiunbandarasmbii-5",
      8: "stasiundjkastasiunbandarasmbii-6",
      9: "stasiundjkastasiunbandarasmbii-7",
      10: "stasiundjkastasiunbandarasmbii-8",
      // Tambahkan link pembayaran sesuai dengan jumlah tiket yang diinginkan di stasiun A
    },
    "Stasiun Bandara SMB II - Stasiun DJKA": {
      1: "stasiunbandaradjka",
      2: "stasiunbandarasmbiistasiundjka-1",
      3: "stasiunbandarasmbiistasiundjka-2",
      4: "stasiunbandarasmbiistasiundjka-3",
      5: "stasiunbandarasmbiistasiundjka-4",
      6: "stasiunbandarasmbiistasiundjka-5",
      7: "stasiunbandarasmbiistasiundjka-6",
      8: "stasiunbandarasmbiistasiundjka-7",
      9: "stasiunbandarasmbiistasiundjka-8",
      10: "stasiunbandarasmbiistasiundjka-9",
      // Tambahkan link pembayaran sesuai dengan jumlah tiket yang diinginkan di stasiun B
    },
    // Tambahkan stasiun lain beserta link pembayaran sesuai kebutuhan
  };

  String? selectedStation;
  int totalHarga = 0;

  void updateTotalHarga() {
    int hargaPerTiket = 100000;
    setState(() {
      totalHarga = jumlahTiket * hargaPerTiket;
    });
  }

  void navigateToPembayaran() {
    if (selectedStation == null || jumlahTiket <= 0) {
      // Tampilkan pesan bahwa stasiun dan jumlah tiket harus dipilih
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Peringatan"),
          content:
              const Text("Pilih stasiun dan jumlah tiket terlebih dahulu."),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } else {
      // Dapatkan link pembayaran berdasarkan stasiun dan jumlah tiket yang dipilih
      Map<int, String>? stationLinks = paymentLinks[selectedStation!];
      String? selectedPaymentLink = stationLinks?[jumlahTiket];

      if (selectedPaymentLink == null) {
        // Tampilkan pesan bahwa jumlah tiket yang dipilih tidak memiliki link pembayaran yang tersedia
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Peringatan"),
            content: const Text(
                "Jumlah tiket yang dipilih tidak memiliki link pembayaran yang tersedia."),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      } else {
        // Pindah ke halaman pembayaran dengan membawa data pemesanan, link pembayaran stasiun, dan total harga
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentGateway(
              dataLinkPayment: selectedPaymentLink,
              dataStatusPayment: false,
            ),
          ),
        );
      }
    }
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "Form Pemesanan",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                const SizedBox(height: 16),
                DropdownButton<String>(
                  value: selectedStation,
                  hint: const Text("Pilih Stasiun"),
                  onChanged: (newValue) {
                    setState(() {
                      selectedStation = newValue;
                      totalHarga = 0;
                    });
                  },
                  // Tampilkan pilihan stasiun sesuai dengan keys dari paymentLinks
                  items: paymentLinks.keys.map((stasiun) {
                    return DropdownMenuItem<String>(
                      value: stasiun,
                      child: Text(stasiun),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Jumlah Tiket",
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          jumlahTiket++;
                          updateTotalHarga();
                        });
                      },
                      child: const Icon(Icons.add),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "$jumlahTiket",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (jumlahTiket > 0) {
                            jumlahTiket--;
                            updateTotalHarga();
                          }
                        });
                      },
                      child: const Icon(Icons.remove),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              "Total Harga: Rp $totalHarga",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: navigateToPembayaran,
              child: const Text("Lanjutkan ke Pembayaran"),
            ),
          ],
        ),
      ),
    );
  }
}
