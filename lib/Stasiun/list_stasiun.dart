import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sislart/Function/function.dart';
import 'package:sislart/Home/home.dart';
import 'package:sislart/Widget/appbarview.dart';
import 'package:sislart/Widget/svgview.dart';

class ListStasiun extends StatefulWidget {
  const ListStasiun({Key? key}) : super(key: key);

  @override
  State<ListStasiun> createState() => _ListStasiunState();
}

class ListItem {
  final String imageUrl;
  final String title;
  final String description;
  final List<String> facilities;

  ListItem({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.facilities,
  });
}

class _ListStasiunState extends State<ListStasiun> {
  final List<ListItem> items = [
    ListItem(
      imageUrl:
          "https://assetsquokka.files.wordpress.com/2023/07/bandara-2.png?w=860",
      title: "Stasiun Sultan Mahmud Badaruddin II",
      description:
          "Lokasi : Jl. Bandara Sultan Mahmud Badaruddin II, Talang Betutu, Kec. Sukarami, Kota Palembang, Sumatera Selatan 30961",
      facilities: [
        'Toilet',
        'Mushollah'
            'Rest Area',
        'Charging Area',
      ],
    ),
    ListItem(
      imageUrl:
          "https://assetsquokka.files.wordpress.com/2023/07/asrama.png?w=1400&h=",
      title: "Stasiun Asrama Haji",
      description:
          "Lokasi : Jl. Letjen Harun Sohar, Kebun Bunga, Kec. Sukarami, Kota Palembang, Sumatera Selatan 30961",
      facilities: [
        'Toilet',
        'Mushollah'
            'Rest Area',
        'Charging Area',
      ],
    ),
    ListItem(
      imageUrl:
          "https://assetsquokka.files.wordpress.com/2023/07/puntikayu.png?w=1024",
      title: "Stasiun Punti Kayu",
      description:
          "Lokasi : Jl. Kol. H. Burlian No.69, Karya Baru, Kec. Sukarami, Kota Palembang, Sumatera Selatan 30961",
      facilities: [
        'Toilet',
        'Mushollah'
            'Rest Area',
        'Charging Area',
      ],
    ),
    ListItem(
      imageUrl:
          "https://assetsquokka.files.wordpress.com/2023/07/rsud.png?w=1024",
      title: "Stasiun RSUD Prov. Sumsel",
      description:
          "Lokasi : Jl. Kol. H. Burlian, Suka Bangun, Kec. Sukarami, Kota Palembang, Sumatera Selatan 30961",
      facilities: [
        'Toilet',
        'Mushollah'
            'Rest Area',
        'Charging Area',
      ],
    ),
    ListItem(
      imageUrl:
          "https://assetsquokka.files.wordpress.com/2023/07/gapo.png?w=1024",
      title: "Stasiun Garuda Dempo",
      description:
          "Lokasi : Jl. Kol. H. Burlian, Ario Kemuning, Kec. Kemuning, Kota Palembang, Sumatera Selatan 30151",
      facilities: [
        'Toilet',
        'Mushollah'
            'Rest Area',
        'Charging Area',
      ],
    ),
    ListItem(
      imageUrl:
          "https://assetsquokka.files.wordpress.com/2023/07/demang.png?w=1024",
      title: "Stasiun Demang Lebar Daun",
      description:
          "Lokasi : Jl. Demang Lebar Daun Siring Agung, Kec. Ilir Bar. I, Kota Palembang, Sumatera Selatan",
      facilities: [
        'Toilet',
        'Mushollah'
            'Rest Area',
        'Charging Area',
      ],
    ),
    ListItem(
      imageUrl:
          "https://assetsquokka.files.wordpress.com/2023/07/pi.png?w=1024",
      title: "Stasiun Bumi Sriwijaya",
      description:
          "Lokasi : Jl. Angkatan 45, Lorok Pakjo, Kec. Ilir Bar. I (Palembang Icon Mall) , Kota Palembang, Sumatera Selatan 30121",
      facilities: [
        'Toilet',
        'Mushollah'
            'Rest Area',
        'Charging Area',
      ],
    ),
    ListItem(
      imageUrl:
          "https://assetsquokka.files.wordpress.com/2023/07/dishub.png?w=1024",
      title: "Stasiun Dishub Kominfo",
      description:
          "Lokasi : Jl. Kapten A. Rivai, Sungai Pangeran, Kec. Ilir Tim. I, Kota Palembang, Sumatera Selatan 30127",
      facilities: [
        'Toilet',
        'Mushollah'
            'Rest Area',
        'Charging Area',
      ],
    ),
    ListItem(
      imageUrl: "https://assetsquokka.files.wordpress.com/2023/07/cinde.png",
      title: "Stasiun Pasar Cinde",
      description:
          "Lokasi : Jl. Jend. Sudirman No.530B, 17 Ilir, Kec. Ilir Tim. I, Kota Palembang, Sumatera Selatan 30114",
      facilities: [
        'Toilet',
        'Mushollah'
            'Rest Area',
        'Charging Area',
      ],
    ),
    ListItem(
      imageUrl:
          "https://assetsquokka.files.wordpress.com/2023/07/ampera.png?w=1024",
      title: "Stasiun Ampera Terpadu",
      description:
          "Lokasi : Jl. Jend. Sudirman, 16 Ilir, Kec. Ilir Tim. I, Kota Palembang, Sumatera Selatan 30111",
      facilities: [
        'Toilet',
        'Mushollah'
            'Rest Area',
        'Charging Area',
      ],
    ),
    ListItem(
      imageUrl:
          "https://assetsquokka.files.wordpress.com/2023/07/polresta.png?w=1024",
      title: "Stasiun Polresta",
      description:
          "Lokasi : Jl. Gubernur H Bastari No.161, 8 Ulu, Kecamatan Seberang Ulu I, Kota Palembang, Sumatera Selatan 30267",
      facilities: [
        'Toilet',
        'Mushollah'
            'Rest Area',
        'Charging Area',
      ],
    ),
    ListItem(
      imageUrl:
          "https://assetsquokka.files.wordpress.com/2023/07/jkbring.png?w=1024",
      title: "Stasiun Jakabaring",
      description:
          "Lokasi : Jl. Gubernur H. A Bastari No.1039, 15 Ulu, Kecamatan Seberang Ulu I, Kota Palembang, Sumatera Selatan 30267",
      facilities: [
        'Toilet',
        'Mushollah'
            'Rest Area',
        'Charging Area',
      ],
    ),
    ListItem(
      imageUrl:
          "https://assetsquokka.files.wordpress.com/2023/07/djka.png?w=1024",
      title: "Stasiun DJKA",
      description:
          "Lokasi : Jl. H.M. Noerdin Pandji Sungai Kedukan, Kec. Rambutan, Kab. Banyuasin, Sumatera Selatan",
      facilities: [
        'Toilet',
        'Mushollah'
            'Rest Area',
        'Charging Area',
      ],
    ),
  ];

  ///////////// list
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 63, 84, 98),
      appBar: appBarCustom2(
        const Color.fromRGBO(227, 208, 80, 1),
        () {
          navigationReplace(context, const HomeApp());
        },
        onPressed: null,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "STASIUN LRT SUMSEL",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(left: 15, right: 15),
              itemCount: items.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                height: 2,
                color: Color.fromARGB(255, 63, 84, 98),
              ),
              itemBuilder: (BuildContext context, int index) {
                final ListItem item = items[index];
                return Container(
                  color: const Color.fromRGBO(227, 208, 80, 1),
                  child: ListTile(
                    leading: svgImage("assets/svg/stasiun/svg_lrt2.svg"),
                    title: Text(
                      item.title,
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: Color.fromARGB(255, 63, 84, 98),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    trailing: const Icon(Icons.chevron_right_rounded,
                        color: Color.fromARGB(255, 63, 84, 98)),
                    onTap: () {
                      navigationPush(
                        context,
                        DetailStasiunPage(
                          imageUrl: item.imageUrl,
                          title: item.title,
                          description: item.description,
                          facilities: item.facilities,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          /*Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      navigationPush(context, const JadwalLRT());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(227, 208, 80, 1),
                    ),
                    child: const Text(
                      'Jadwal',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      navigationPush(context, const PetaGoogle());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(227, 208, 80, 1),
                    ),
                    child: const Text(
                      'Rute',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ],
              ))*/
        ],
      ),
    );
  }
}

//////////// detail
class DetailStasiunPage extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final List<String> facilities;

  const DetailStasiunPage({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.facilities,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 63, 84, 98),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Montserrat',
              color: Colors.white,
            ),
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          )),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 25, bottom: 10),
              child: Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 38, 53, 63),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Text(
                description,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Text(
                'Fasilitas Stasiun:',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 38, 53, 63),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        svgImageColor(
                          "assets/svg/stasiun/svg_toilet.svg",
                          const Color.fromARGB(255, 38, 53, 63),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Toilet",
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: const Color.fromARGB(255, 38, 53, 63),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        svgImageColor(
                          "assets/svg/stasiun/svg_charger.svg",
                          const Color.fromARGB(255, 38, 53, 63),
                          width: 28, // Ubah ukuran sesuai kebutuhan Anda
                          height: 28,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Charging",
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: const Color.fromARGB(255, 38, 53, 63),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        svgImageColor(
                          "assets/svg/stasiun/svg_mushollah.svg",
                          const Color.fromARGB(255, 38, 53, 63),
                          width: 30, // Ubah ukuran sesuai kebutuhan Anda
                          height: 30,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Mushollah",
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: const Color.fromARGB(255, 38, 53, 63),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        svgImageColor(
                          "assets/svg/stasiun/svg_rest.svg",
                          const Color.fromARGB(255, 38, 53, 63),
                          width: 30, // Ubah ukuran sesuai kebutuhan Anda
                          height: 30,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Rest Area",
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: const Color.fromARGB(255, 38, 53, 63),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        svgImageColor(
                          "assets/svg/stasiun/svg_ibu.svg",
                          const Color.fromARGB(255, 38, 53, 63),
                          width: 27, // Ubah ukuran sesuai kebutuhan Anda
                          height: 27,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Ruang Menyusui",
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: const Color.fromARGB(255, 38, 53, 63),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        svgImageColor(
                          "assets/svg/stasiun/svg_med.svg",
                          const Color.fromARGB(255, 38, 53, 63),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Ruang Kesehatan",
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: const Color.fromARGB(255, 38, 53, 63),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
