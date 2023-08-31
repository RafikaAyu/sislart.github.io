import 'package:cloud_firestore/cloud_firestore.dart';

getStoreImage(String docs, String getData, void Function(List<dynamic>) callback) {
  FirebaseFirestore.instance.collection('konten').doc(docs).get().then((DocumentSnapshot<Object?> snapshot) {
    if (snapshot.exists) {
      callback(snapshot.get(getData));
    }
  });
}
