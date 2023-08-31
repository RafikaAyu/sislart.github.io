import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sislart/Function/function.dart';
import 'package:sislart/Home/home.dart';
import 'package:sislart/LocalData/mapsdata.dart';
import 'package:sislart/SplashScreen/initialisasi.dart';
import 'package:sislart/Widget/appbarview.dart';

class JadwalLRT extends StatefulWidget {
  const JadwalLRT({Key? key}) : super(key: key);

  @override
  State<JadwalLRT> createState() => _JadwalLRTState();
}

class _JadwalLRTState extends State<JadwalLRT> {
  final List<String> dataItems = [
    "JADWAL STASIUN LRT DJKA - BANDARA",
    "JADWAL STASIUN LRT BANDARA - DJKA"
  ];
  String selectedItems = "JADWAL STASIUN LRT DJKA - BANDARA";
  Timer? timerAddData;
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();

  @override
  void initState() {
    timerAddData = Timer.periodic(
      const Duration(milliseconds: 200),
      (timers) => getJadwalGanjil() && getJadwalGenap() == false
          ? timerAddData?.cancel()
          : null,
    );
    super.initState();
  }

  @override
  void dispose() {
    timerAddData?.cancel();
    _horizontalScrollController.dispose();
    _verticalScrollController.dispose();
    super.dispose();
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: Text(
                  selectedItems,
                  style: GoogleFonts.quicksand(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
                items: dataItems
                    .map(
                      (String item) => DropdownMenuItem<String>(
                        value: item,
                        alignment: Alignment.center,
                        child: Text(
                          item,
                          style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                value: selectedItems,
                onChanged: (value) => setState(() => selectedItems = value!),
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _verticalScrollController,
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                controller: _horizontalScrollController,
                scrollDirection: Axis.horizontal,
                child: selectedItems == dataItems[0]
                    ? DataMaps.namaStasiunGanjil.length ==
                            DataMaps.jadwalDJKAkeBandara.length
                        ? tableView(DataMaps.jadwalDJKAkeBandara,
                            DataMaps.namaStasiunGanjil, "Ganjil")
                        : Container()
                    : DataMaps.namaStasiunGenap.length ==
                            DataMaps.jadwalBandaraKeDJKA.length
                        ? tableView(DataMaps.jadwalBandaraKeDJKA,
                            DataMaps.namaStasiunGenap, "Genap")
                        : Container(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tableView(List<List<dynamic>> dataJadwal, List<dynamic> namaStasiun,
      String ganjilGenap) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 0,
        horizontalMargin: 0,
        border: TableBorder.all(
          borderRadius: BorderRadius.circular(1),
          color: const Color.fromARGB(255, 7, 21, 91),
        ),
        columns: [
          DataColumn(
            label: Container(
              color: Colors.blue,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(18),
              child: Text(
                "KA",
                style: GoogleFonts.quicksand(
                  color: const Color.fromARGB(255, 246, 246, 246),
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          ...namaStasiun.map(
            (namaStasiun) => DataColumn(
              label: Container(
                color: Colors.blue,
                child: Container(
                  width: 70,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(18),
                  child: Text(
                    namaStasiun,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.quicksand(
                      color: const Color.fromARGB(255, 246, 246, 246),
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
        rows: List<DataRow>.generate(
          dataJadwal[0].length,
          (index) => DataRow(
            cells: [
              DataCell(
                Container(
                  color: Colors.orangeAccent,
                  alignment: Alignment.center,
                  child: Text(
                    "P${ganjilGenap != "Ganjil" ? (index + 1) * 2 : (index * 2) + 1}",
                    style: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 40, 43, 45),
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              ...dataJadwal.map(
                (peron) => DataCell(
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      peron[index]
                          .toString()
                          .substring(0, peron[index].toString().length - 3),
                      style: GoogleFonts.quicksand(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
