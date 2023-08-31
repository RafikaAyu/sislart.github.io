import 'package:cloud_firestore/cloud_firestore.dart';

// =============================== GET DATA ================================== //
getStoreAllUser<String>(void Function(String) callback) {
  FirebaseFirestore.instance.collection('users').get().then((QuerySnapshot<Object?> snapshot) {
    for (var dataSnapshot in snapshot.docs) {
      callback(dataSnapshot.data() as String);
    }
  });
}

getStoreAllUserName<String>(String callsign, void Function(String) callback) {
  FirebaseFirestore.instance.collection('users').get().then((QuerySnapshot<Object?> snapshot) {
    for (var dataSnapshot in snapshot.docs) {
      final data = dataSnapshot.data() as Map<String, dynamic>?; // Konversi ke Map<String, dynamic>

      callback(data?['name']);
    }
  });
}

getStoreUserFull<String>(String email, void Function(String) callback) {
  FirebaseFirestore.instance.collection('users').doc("$email").get().then((DocumentSnapshot<Object?> snapshot) {
    if (snapshot.exists) {
      callback(snapshot.data().toString() as String);
    }
  });
}

getStoreUser<String>(String email, String getData, void Function(String) callbackGetData) {
  FirebaseFirestore.instance.collection('users').where('email', isEqualTo: email).get().then((QuerySnapshot<Object?> snapshot) {
    if (snapshot.docs.isNotEmpty) {
      var data = snapshot.docs[0].get("$getData");
      if (data != null) {
        callbackGetData(data.toString() as String);
      } else {
        callbackGetData("" as String);
        Future.delayed(const Duration(milliseconds: 500), () {
          getStoreUser(email, getData, callbackGetData);
        });
      }
    }
  });
}

getStoreUserNoDelay<String>(String email, String getData, void Function(String) callbackGetData) {
  FirebaseFirestore.instance.collection('users').where('email', isEqualTo: email).get().then((QuerySnapshot<Object?> snapshot) {
    if (snapshot.docs.isNotEmpty) {
      var data = snapshot.docs[0].get("$getData");
      if (data != null) {
        callbackGetData(data.toString() as String);
      }
    }
  });
}

// ==================================== CREATE DATA =========================================== //
createStoreUserEmail<bool>(String name, String phone, String email, void Function(bool) callbackGetData) {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentReference userAccount = firestore.collection('users').doc(email);
  var waktuSekarang = Timestamp.now().millisecondsSinceEpoch;

  userAccount.set({
    'create': waktuSekarang,
    'name': name.toString(),
    'phone': phone.toString(),
    'email': email.toString().trim(),
  }).then(
    (value) => {
      callbackGetData(true as bool),
    },
  );
}
