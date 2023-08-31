import 'package:flutter/material.dart';
import 'package:sislart/Account/login.dart';
import 'package:sislart/Firebase/authentication.dart';
import 'package:sislart/Firebase/firestore_user.dart';
import 'package:sislart/Function/function.dart';
import 'package:sislart/Home/home.dart';
import 'package:sislart/LocalData/userdata.dart';
import 'package:sislart/Widget/appbarview.dart';
import 'package:sislart/Widget/textview.dart';
import 'package:sislart/Widget/toastview.dart';
import 'package:sislart/Widget/widget.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;

  void daftar() {
    FocusScope.of(context).requestFocus(FocusNode());

    signUpAuthEmail(
        emailController.text.toString(), passwordController.text.toString(),
        (valueSignUp) {
      if (valueSignUp == "Berhasil") {
        createStoreUserEmail(
            nameController.text.toString(),
            phoneController.text.toString(),
            emailController.text.toString(), (valueCreate) {
          if (valueCreate == true) {
            setState(() {
              UsersData.userName = nameController.text;
              UsersData.userPhone = phoneController.text;
              UsersData.userEmail = emailController.text;
              UsersData.userStatus = true;
              toastShort("Berhasil", Colors.black);
              navigationReplace(context, const HomeApp());
            });
          }
        });
      } else {
        toastShort(valueSignUp, Colors.black);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarLoginDaftar("assets/svg/appbar/svg_left.svg", () {
        navigationReplace(context, const Login());
      }),
      body: Center(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(left: 30, right: 30),
          children: [
            Container(
                margin: const EdgeInsets.only(
                    top: 10, bottom: 40, left: 70, right: 70),
                child: Image.asset('assets/images/icon/sislart2.png')),
            textView("Daftar Akun", 18, rgba(18, 44, 61, 1), FontWeight.bold,
                TextAlign.center, const EdgeInsets.only(top: 5, bottom: 20)),
            inputEmailController(nameController, Icons.near_me, "Nama"),
            inputEmailController(
                emailController, Icons.account_circle, "Email"),
            inputPhoneController(phoneController, Icons.phone, "No Handphone"),
            inputPasswordController(passwordController, passwordVisible, () {
              setState(() {
                passwordVisible = !passwordVisible;
              });
            }),
            textView(
                "Dengan mendaftar, Anda menyetujui",
                13,
                Colors.black,
                FontWeight.w600,
                TextAlign.center,
                const EdgeInsets.only(top: 25)),
            textView(
                "Ketentuan Layanan dan Kebijakan Privacy",
                13,
                Colors.black,
                FontWeight.w600,
                TextAlign.center,
                const EdgeInsets.all(0)),
            const SizedBox(height: 25),
            ///////////////////
            Container(
              padding: const EdgeInsets.only(bottom: 40, left: 0, right: 0),
              child: textButtonBox("Daftar", 16, 45, 15, rgba(227, 208, 80, 1),
                  () {
                daftar();
              }),
            ),
            ///////////////////
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textView("Sudah memiliki akun?  ", 15, Colors.black,
                    FontWeight.w600, TextAlign.start, const EdgeInsets.all(0)),
                textButtonClick("Masuk disini",
                    () => navigationPush(context, const Login())),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
