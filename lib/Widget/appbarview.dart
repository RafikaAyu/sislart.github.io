import 'package:flutter/material.dart';
import 'package:sislart/Function/function.dart';
import 'package:sislart/Widget/svgview.dart';
import 'package:sislart/Widget/textview.dart';

///////////////////
appBarSplash() {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 60,
          margin: const EdgeInsets.only(left: 7.0),
          child: Image.asset('assets/images/splash/lrt_sumsel.png'),
        ),
        Row(
          children: [
            Container(
              height: 35,
              margin: const EdgeInsets.only(left: 7.0),
              child: Image.asset('assets/images/splash/plg.png'),
            ),
            Container(
              height: 35,
              margin: const EdgeInsets.only(left: 7.0),
              child: Image.asset('assets/images/splash/dishub.png'),
            ),
          ],
        ),
      ],
    ),
    automaticallyImplyLeading: false,
  );
}

///////////////////////////
appBarHome(String textuser, BuildContext context, ditekan) {
  return AppBar(
    backgroundColor: Colors.white,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            height: 55,
            margin: const EdgeInsets.only(left: 7.0),
            child: Image.asset("assets/images/appbar/sislart.png")),
        //////////////
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                textView(textuser != "" ? "Hai" : "", 13, rgba(18, 44, 61, 1),
                    FontWeight.w700, TextAlign.start, const EdgeInsets.all(0)),
                textViewFlow(textuser, MediaQuery.of(context).size.width / 2.1,
                    14, rgba(18, 44, 61, 1), FontWeight.bold),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.account_circle_rounded,
                  color: Color.fromARGB(255, 8, 21, 58)),
              iconSize: 33,
              onPressed: ditekan,
            ),
          ],
        ),
        /////////////
      ],
    ),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(25),
      bottomRight: Radius.circular(25),
    )),
    automaticallyImplyLeading: false,
  );
}

///////////////////
appBarCustom(String text1, ditekan1, String text2, bool status, ditekan2) {
  return AppBar(
    backgroundColor: Colors.white,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              child: IconButton(
                icon: Icon(Icons.arrow_back,
                    color: rgba(18, 44, 61, 1), size: 33),
                onPressed: ditekan1,
              ),
            ),
            textFlow(text1, 16, rgba(18, 44, 61, 1), FontWeight.w700,
                TextAlign.center, const EdgeInsets.all(0)),
          ],
        ),
        status != true
            ? Container(
                height: 55,
                margin: const EdgeInsets.only(right: 8.0),
                child: Image.asset('assets/images/appbar/sislart.png'),
              )
            : textButtonClickCustom(text2, 15, rgba(18, 44, 61, 1), ditekan2),
      ],
    ),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(25),
      bottomRight: Radius.circular(25),
    )),
    automaticallyImplyLeading: false,
  );
}

///////////////////
appBarCustom2(Color warna, ditekan, {required onPressed}) {
  return AppBar(
    backgroundColor: Colors.white,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color: warna, size: 33),
          onPressed: ditekan,
        ),
        Container(
          height: 60,
          margin: const EdgeInsets.only(left: 7.0),
          child: Image.asset('assets/images/appbar/sislart.png'),
        ),
      ],
    ),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(25),
      bottomRight: Radius.circular(25),
    )),
    automaticallyImplyLeading: false,
  );
}

//////////
appBarLoginDaftar(String assetSVG, ditekan) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 60,
          margin: const EdgeInsets.only(left: 7.0),
          child: IconButton(
            icon: svgImage(assetSVG),
            iconSize: 33,
            onPressed: ditekan,
          ),
        ),
      ],
    ),
    automaticallyImplyLeading: false,
  );
}
