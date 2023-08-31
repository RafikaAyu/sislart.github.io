import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:sislart/LocalData/userdata.dart';

void inputNameEmail(InAppWebViewController webViewController, int durasi) async {
  await Future.delayed(Duration(seconds: durasi));

  String script = '''
    // Menghapus Mode Pengujian
    document.querySelector('.sc-jlyJG').remove();

    // Menghapus Kata Pembayaran
    document.querySelector('.sc-TOsTZ.EBNPR').remove();

    // Menganti Kata Akun Flip
    document.querySelector('.u-text-base.u-font-bold').innerHTML = 'Masukkan Data <span class="u-text-flip_orange u-cursor-pointer">Sesuai</span> Akun';

    // Menghapus Kata Mengirim Uang
    document.querySelector('.u-max-w-sm.u-mx-auto').remove();

    // Menganti Kata Nama Pengguna SislarT
    document.querySelector('.sc-jKJlTe.iTeFVQ.c-field-label').innerText = 'Nama Pengguna SislarT';

    // Mengisi Data Nama
    var nameElement = document.querySelector('input[data-testid="qa-field"][name="name"]');
    if (nameElement) {
        nameElement.value = '${UsersData.userName}'; 
        nameElement.dispatchEvent(new Event('input', { bubbles: true, cancelable: true })); // Panggil event input
        nameElement.dispatchEvent(new Event('change', { bubbles: true, cancelable: true })); // Panggil event change
        nameElement.reportValidity(); // Periksa validitas elemen input
    }

    // Mengisi Data Email
    var emailElement = document.querySelector('input[data-testid="qa-field"][name="email"]');
    if (emailElement) {
        emailElement.value = '${UsersData.userEmail}'; 
        emailElement.dispatchEvent(new Event('input', { bubbles: true, cancelable: true })); // Panggil event input
        emailElement.dispatchEvent(new Event('change', { bubbles: true, cancelable: true })); // Panggil event change
        emailElement.reportValidity(); // Periksa validitas elemen input
    }

    // Menghidupkan Tombol Pembayaran
    document.querySelector('button[data-testid="qa-button"]').disabled = false;
    ''';
  webViewController.evaluateJavascript(source: script);
}

void removeModePengujian(InAppWebViewController webViewController) async {
  await Future.delayed(const Duration(seconds: 1));
  String script = '''
    // Menghapus Mode Pengujian
    document.querySelector('.sc-jlyJG').remove();
    ''';
  webViewController.evaluateJavascript(source: script);
}

void waitingPayment(InAppWebViewController webViewController) async {
  await Future.delayed(const Duration(seconds: 1));
  String script = '''
    // Menghapus Mode Pengujian
    document.querySelector('.sc-jlyJG').remove();

    // Mengganti Kata Ke SislarT
    document.querySelector('.u-font-bold.u-text-xs').innerHTML = 'Ke SislarT';
    ''';
  webViewController.evaluateJavascript(source: script);
}

successPaymentNoDirect(InAppWebViewController webViewController, void Function(String) callbackGetIdTransaction, void Function(bool) callbackStatusTransaction) async {
  await Future.delayed(const Duration(seconds: 1));
  String script = '''
    // Menghapus Mode Pengujian
    document.querySelector('.sc-jlyJG').remove();

    // Menghapus Status Berhasil
    document.querySelector('.sc-jlyJG.kuyeHw').remove();
    
    // Mengganti Kata Ke SislarT
    document.getElementsByClassName('font--medium overflow--break-word')[0].innerText = 'SislarT';
    document.getElementsByClassName('font--medium overflow--break-word')[2].innerText = '${UsersData.userEmail}';
    document.querySelector('.sc-cJSrbW.keOYqx').innerText = 'SislarT';

    // Mengambil Data ID Transaksi Menjadi Value
    document.querySelector('span.float-right').innerText;
    ''';
  webViewController.evaluateJavascript(source: script).then((value) {
    callbackGetIdTransaction(value.toString().replaceAll("ID", "").replaceAll("#", "").replaceAll(" ", "").trim());
    callbackStatusTransaction(true);
  });
}
