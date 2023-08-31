import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Color rgba(int r, int g, int b, double opacity) {
  return Color.fromRGBO(r, g, b, opacity);
}

focusAdd(FocusNode foc, TextEditingController controller) {
  foc.addListener(() => !foc.hasFocus ? controller.clear() : null);
}

focusReq(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

navigationPush(BuildContext context, toPage) {
  focusReq(context);
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => toPage),
  );
}

navigationReplace(BuildContext context, toPage) {
  focusReq(context);

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => toPage),
  );
}

navigationReplaceDelay(BuildContext context, Widget widget, int time) async {
  Timer(Duration(seconds: time), () {
    focusReq(context);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget));
  });
}

timerDelay(int seconds, Function() execution) {
  return Timer(Duration(seconds: seconds), execution);
}

int mapping(int dataYangAkandiMapping, int inMin, int inMax, int outMin, int outMax) {
  return ((dataYangAkandiMapping - inMin) * (outMax - outMin) / (inMax - inMin) + outMin).round();
}

DateTime realTime() {
  String time = DateFormat('HH:mm:ss').format(DateTime.now());
  DateTime waktuSekarang = DateFormat('HH:mm:ss').parse(time);

  return waktuSekarang;
}
