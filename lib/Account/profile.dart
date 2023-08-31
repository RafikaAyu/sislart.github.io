import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sislart/Firebase/authentication.dart';
import 'package:sislart/Function/function.dart';
import 'package:sislart/Home/home.dart';
import 'package:sislart/LocalData/userdata.dart';
import 'package:sislart/Widget/appbarview.dart';
import 'package:sislart/Widget/textview.dart';
import 'package:sislart/Widget/toastview.dart';

class ProfileUser extends StatefulWidget {
  const ProfileUser({super.key});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  File? _image;

  Future _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarLoginDaftar("assets/svg/appbar/svg_left.svg", () {
        navigationReplace(context, const HomeApp());
      }),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.only(
          left: 30,
          right: 30,
          top: 30,
          bottom: 30,
        ),
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: _image != null ? FileImage(_image!) : null,
          ),
          ElevatedButton(
            onPressed: _getImage,
            child: const Text('Change Avatar'),
          ),
          textButtonBox(
            "Change Password",
            12,
            45,
            15,
            rgba(227, 208, 80, 1),
            () {},
          ),
          textButtonBox("Sign Out", 12, 45, 15, rgba(227, 208, 80, 1), () {
            signOutAuth((value) {
              toastShort(value, Colors.black);
              if (value == "Logout") {
                setState(() {
                  UsersData.userName = "";
                  UsersData.userEmail = "";
                  UsersData.userPhone = "";
                  UsersData.userStatus = false;
                  navigationReplace(context, const HomeApp());
                });
              }
            });
          }),
        ],
      ),
    );
  }
}
