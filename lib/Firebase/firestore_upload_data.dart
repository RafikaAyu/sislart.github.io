import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sislart/Widget/toastview.dart';

class UploadDataPage extends StatefulWidget {
  const UploadDataPage({super.key});

  @override
  State<UploadDataPage> createState() => _UploadDataPageState();
}

class _UploadDataPageState extends State<UploadDataPage> {
  String stasiun = 'bandara';

  final List<List<dynamic>> data = [
    [
      '06:49:00',
      '07:06:00',
      '07:24:00',
      '07:42:00',
      '08:00:00',
      '08:17:00',
      '08:35:00',
      '08:53:00',
      '09:11:00',
      '09:28:00',
      '09:46:00',
      '10:04:00',
      '10:22:00',
      '10:39:00',
      '10:57:00',
      '11:15:00',
      '11:33:00',
      '11:50:00',
      '12:08:00',
      '12:26:00',
      '12:44:00',
      '13:01:00',
      '13:19:00',
      '13:37:00',
      '13:55:00',
      '14:12:00',
      '14:30:00',
      '14:48:00',
      '15:06:00',
      '15:23:00',
      '15:41:00',
      '15:59:00',
      '16:17:00',
      '16:34:00',
      '16:52:00',
      '17:10:00',
      '17:28:00',
      '17:45:00',
      '18:03:00',
      '18:21:00',
      '18:39:00',
      '18:56:00',
      '19:14:00',
      '19:32:00'
    ]
  ];

  void uploadDataToFirestore() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference<Map<String, dynamic>> collection = firestore.collection('stasiun').doc('djka-bandara').collection(stasiun);

    for (int i = 0; i < data.length; i++) {
      DocumentReference<Map<String, dynamic>> document = collection.doc('kereta');
      List<String> waktuPeronLrt = data[i].cast<String>();
      document.set({'jadwalPeron': waktuPeronLrt});
    }

    toastShort("BERHASIL MEMASUKKAN DATA $stasiun", Colors.black);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Data'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: uploadDataToFirestore,
          child: const Text('Upload Data to Firestore'),
        ),
      ),
    );
  }
}
