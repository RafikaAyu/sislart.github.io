import 'package:flutter/material.dart';
import 'package:sislart/Account/signup.dart';
import 'package:sislart/Firebase/authentication.dart';
import 'package:sislart/Firebase/firestore_user.dart';
import 'package:sislart/Function/function.dart';
import 'package:sislart/Home/home.dart';
import 'package:sislart/LocalData/userdata.dart';
import 'package:sislart/Widget/appbarview.dart';
import 'package:sislart/Widget/textview.dart';
import 'package:sislart/Widget/toastview.dart';
import 'package:sislart/Widget/widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;

  void login() {
    loginAuthEmail(
        emailController.text.toString(), passwordController.text.toString(),
        (valueAuth) {
      if (valueAuth == "Berhasil") {
        getStoreUserNoDelay(emailController.text.toString(), 'name',
            (value) => UsersData.userName = value);
        setState(() {
          UsersData.userEmail = emailController.text;
          UsersData.userStatus = true;
          toastShort("Berhasil", Colors.black);
          navigationReplace(context, const HomeApp());
        });
      } else {
        UsersData.userName = "";
        toastShort(valueAuth, Colors.black);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarLoginDaftar("assets/svg/appbar/svg_xlatter.svg",
          () => navigationReplace(context, const HomeApp())),
      body: Center(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(left: 30, right: 30),
          children: [
            Container(
                margin: const EdgeInsets.only(
                    top: 10, bottom: 90, left: 70, right: 70),
                child: Image.asset('assets/images/icon/sislart2.png')),
            inputEmailController(
                emailController, Icons.account_circle, "Email"),
            inputPasswordController(passwordController, passwordVisible,
                () => setState(() => passwordVisible = !passwordVisible)),
            ///////////////////
            Container(
                child: textButtonBox(
                    "Masuk", 16, 45, 15, rgba(227, 208, 80, 1), () => login()),
                margin: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 40, top: 30)),
            ///////////////////
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textView("Belum memiliki akun?  ", 15, Colors.black,
                    FontWeight.w600, TextAlign.start, const EdgeInsets.all(0)),
                textButtonClick("Daftar disini",
                    () => navigationPush(context, const Signup())),
              ],
            ),
            /*textView("atau", 15, Colors.black, FontWeight.w600,
                TextAlign.center, const EdgeInsets.all(0)),
            textView("Daftar melalui Google", 15, Colors.black, FontWeight.w600,
                TextAlign.center, const EdgeInsets.only(bottom: 25)),
            ///////////////////
            Container(
              margin: const EdgeInsets.only(left: 90, right: 90, bottom: 50),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: rgba(18, 44, 61, 1),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      SocialMediaIcons.google,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Google",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),*/
            // ====================== Bagian Bawah Login =================== //
          ],
        ),
      ),
    );
  }
}
