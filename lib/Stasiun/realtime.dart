import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class InfoLRT extends StatefulWidget {
  const InfoLRT({super.key});

  @override
  State<InfoLRT> createState() => _InfoLRTState();
}

class _InfoLRTState extends State<InfoLRT> {
  late Timer timer;
  double rel = 0.17;

  lrtJalan() {
    timer = Timer.periodic(const Duration(milliseconds: 100), (Timer timer) {
      setState(() {
        rel = rel + 0.0015;
        if (rel > 1.0) {
          rel = 0.17;
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    lrtJalan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(rel.toString()),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: LinearPercentIndicator(
              width: MediaQuery.of(context).size.width - 50,
              animationDuration: 100000,
              animation: false,
              lineHeight: 15.0,
              percent: rel,
              progressColor: const Color.fromARGB(255, 110, 110, 110),
              backgroundColor: const Color.fromARGB(255, 171, 170, 170),
              widgetIndicator: Container(margin: const EdgeInsets.only(bottom: 40, right: 100), width: 50, child: Image.asset("assets/images/marker/marker_lrt.png")),
            ),
          ),
        ],
      ),
    );
  }
}
