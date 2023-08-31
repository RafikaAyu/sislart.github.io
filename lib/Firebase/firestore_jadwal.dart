import 'package:cloud_firestore/cloud_firestore.dart';

getStoreJadwalBandaraKeDJKA(String namaStasiun, void Function(List<dynamic>) callback) {
  FirebaseFirestore.instance.collection('stasiun').doc('bandara-djka').collection(namaStasiun).doc('kereta').get().then((DocumentSnapshot<Object?> snapshot) {
    if (snapshot.exists) {
      callback(snapshot.get('jadwalPeron'));
    }
  });
}

getStoreJadwalDJKAkeBandara(String namaStasiun, void Function(List<dynamic>) callback) {
  FirebaseFirestore.instance.collection('stasiun').doc('djka-bandara').collection(namaStasiun).doc('kereta').get().then((DocumentSnapshot<Object?> snapshot) {
    if (snapshot.exists) {
      callback(snapshot.get('jadwalPeron'));
    }
  });
}
