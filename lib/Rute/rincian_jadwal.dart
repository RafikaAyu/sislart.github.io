import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sislart/Function/function.dart';
import 'package:sislart/Home/home.dart';
import 'package:sislart/Widget/appbarview.dart';
import 'package:sislart/Widget/svgview.dart';

class RincianJadwal extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const RincianJadwal({Key? key});

  @override
  State<RincianJadwal> createState() => _RincianJadwalState();
}

class ListItem {
  final String title;
  final String subtitle;

  ListItem({required this.title, required this.subtitle});
}

class _RincianJadwalState extends State<RincianJadwal> {
  // ignore: unused_field
  final bool _isBottomSheetExpanded = false;
  final List<ListItem> items = [
    ListItem(
        title: "Stasiun Sultan Mahmud Badaruddin II",
        subtitle: "selengkapnya.."),
    ListItem(title: "Stasiun Asrama Haji", subtitle: "selengkapnya.."),
    ListItem(title: "Stasiun Punti Kayu", subtitle: "selengkapnya.."),
    ListItem(title: "Stasiun RSUD Prov. Sumsel", subtitle: "selengkapnya.."),
    ListItem(title: "Stasiun Garuda Dempo", subtitle: "selengkapnya.."),
    ListItem(title: "Stasiun Demang Lebar Daun", subtitle: "selengkapnya.."),
    ListItem(title: "Stasiun Bumi Sriwijaya", subtitle: "selengkapnya.."),
    ListItem(title: "Stasiun Dishub Kominfo", subtitle: "selengkapnya.."),
    ListItem(title: "Stasiun Pasar Cinde", subtitle: "selengkapnya.."),
    ListItem(title: "Stasiun Terpadu Ampera", subtitle: "selengkapnya.."),
    ListItem(title: "Stasiun Polresta", subtitle: "selengkapnya.."),
    ListItem(title: "Stasiun Stadion Jakabaring", subtitle: "selengkapnya.."),
    ListItem(title: "Stasiun DJKA", subtitle: "selengkapnya.."),
  ];

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
      body: const Stack(
        children: [
          // ... (tambahkan widget lain sesuai kebutuhan)
        ],
      ),
      bottomSheet: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.4,
        maxChildSize: 0.9,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 5,
                    width: 50,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 63, 84, 98),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        ListView.separated(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: items.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(height: 2, color: Colors.black54),
                          itemBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 55,
                              child: ListTile(
                                leading:
                                    svgImage("assets/svg/stasiun/svg_lrt1.svg"),
                                title: Text(
                                  items[index].title,
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        color: Color.fromARGB(255, 63, 84, 98),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.chevron_right_rounded,
                                  color: Color.fromARGB(255, 63, 84, 98),
                                ),
                                onTap: () {
                                  navigationPush(context, const HomeApp());
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
