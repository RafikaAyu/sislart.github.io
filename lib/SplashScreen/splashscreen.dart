import 'package:flutter/material.dart';
import 'package:sislart/Function/function.dart';
import 'package:sislart/Home/home.dart';
import 'package:sislart/SplashScreen/initialisasi.dart';
import 'package:sislart/Widget/appbarview.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    initialisasiSplash();
    navigationReplaceDelay(context, const HomeApp(), 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: appBarSplash(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 50, right: 55),
            child: Image.asset('assets/images/splash/splash.png'),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
