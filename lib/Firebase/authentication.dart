import 'package:firebase_auth/firebase_auth.dart';

// ============================ GET AUTH ============================ //
getAuthStatus<bool>() {
  User? firebaseAuth = FirebaseAuth.instance.currentUser;
  firebaseAuth = FirebaseAuth.instance.currentUser;

  if (firebaseAuth != null) {
    return true;
  } else {
    return false;
  }
}

getAuthEmail<String>() {
  User? firebaseAuth = FirebaseAuth.instance.currentUser;
  firebaseAuth = FirebaseAuth.instance.currentUser;

  if (firebaseAuth != null) {
    return firebaseAuth.email.toString();
  } else {
    return "";
  }
}

getAuthUID<String>() {
  User? firebaseAuth = FirebaseAuth.instance.currentUser;
  firebaseAuth = FirebaseAuth.instance.currentUser;

  if (firebaseAuth != null) {
    return firebaseAuth.uid.toString();
  }
}

// ============================ CREATE AUTH ============================ //
signUpAuthEmail<String>(String email, String password, void Function(String) callbackGetData) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: "$email", password: "$password");
    callbackGetData("Berhasil" as String);
  } on FirebaseAuthException catch (e) {
    String error = e.code
        .toString()
        .replaceAll("unknown", "Form Tidak Boleh Kosong!")
        .replaceAll("user-not-found", "Email Tidak Terdaftar!")
        .replaceAll("too-many-requests", "Terlalu Banyak Aksi!")
        .replaceAll("weak-password", "Password Minimal Harus 6 Karakter!")
        .replaceAll("email-already-in-use", "Akun Tersebut Sudah Terdaftar!")
        .replaceAll("invalid-email", "Format Email Yang Anda Masukkan Salah!")
        .replaceAll("wrong-password", "Email atau Password Yang Anda Masukkan Salah!")
        .replaceAll("network-request-failed", "Koneksi Internet Anda Terputus, Coba Lagi!") as String;
    callbackGetData(error);
  }
}

loginAuthEmail<String>(String email, String password, void Function(String) callbackGetData) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: "$email", password: "$password");
    callbackGetData("Berhasil" as String);
  } on FirebaseAuthException catch (e) {
    String error = e.code
        .toString()
        .replaceAll("unknown", "Form Tidak Boleh Kosong!")
        .replaceAll("user-not-found", "Email Tidak Terdaftar!")
        .replaceAll("too-many-requests", "Terlalu Banyak Aksi!")
        .replaceAll("weak-password", "Password Minimal Harus 6 Karakter!")
        .replaceAll("invalid-email", "Format Email Yang Anda Masukkan Salah!")
        .replaceAll("wrong-password", "Email atau Password Yang Anda Masukkan Salah!")
        .replaceAll("network-request-failed", "Koneksi Internet Anda Terputus, Coba Lagi!") as String;
    callbackGetData(error);
  }
}

signOutAuth<String>(void Function(String) callbackGetData) async {
  try {
    await FirebaseAuth.instance.signOut();
    callbackGetData("Logout" as String);
  } on FirebaseAuthException catch (e) {
    String error = e.code
        .replaceAll("unknown", "Form Tidak Boleh Kosong!")
        .replaceAll("user-not-found", "Email Tidak Terdaftar!")
        .replaceAll("too-many-requests", "Terlalu Banyak Aksi!")
        .replaceAll("network-request-failed", "Koneksi Internet Anda Terputus, Coba Lagi!") as String;
    callbackGetData(error);
  }
}
