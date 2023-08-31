import 'package:sislart/Firebase/authentication.dart';
import 'package:sislart/Firebase/firestore_jadwal.dart';
import 'package:sislart/Firebase/firestore_konten.dart';
import 'package:sislart/Firebase/firestore_user.dart';
import 'package:sislart/Function/data_cache.dart';
import 'package:sislart/GoogleMaps/function_maps.dart';
import 'package:sislart/LocalData/localdata.dart';
import 'package:sislart/LocalData/mapsdata.dart';
import 'package:sislart/LocalData/userdata.dart';

initialisasiSplash() async {
  // ================================== Set Icon Marker ======================================= //
  setIconMarker("assets/images/marker/marker_lrt_ganjil.png", (value) => FungsiMaps.iconLRTGanjil = value);
  setIconMarker("assets/images/marker/marker_lrt_genap.png", (value) => FungsiMaps.iconLRTGenap = value);
  setIconMarker("assets/images/marker/marker_stasiun.png", (value) => FungsiMaps.iconStasiun = value);
  setIconMarker("assets/images/marker/marker_polsri.png", (value) => FungsiMaps.iconPolsri = value);
  // ================================== Set Icon Marker ======================================= //

  // ========================== Get Data Cache URL Home Konten ================================ //
  await getListCache('imageHomeUrl', (value) => LocalData.imageHomeUrl = value);
  await getListCache('imageArtikelUrl', (value) => LocalData.imageArtikelUrl = value);
  // ========================== Get Data Cache URL Home Konten ================================ //

  UsersData.userStatus = getAuthStatus();
  UsersData.userEmail = getAuthEmail();
  getStoreUser(getAuthEmail(), 'name', (value) => UsersData.userName = value);
}

initialisasiHome() {
  // ================================== Set Icon Marker ======================================= //
  setIconMarker("assets/images/marker/marker_lrt_ganjil.png", (value) => FungsiMaps.iconLRTGanjil = value);
  setIconMarker("assets/images/marker/marker_lrt_genap.png", (value) => FungsiMaps.iconLRTGenap = value);
  setIconMarker("assets/images/marker/marker_stasiun.png", (value) => FungsiMaps.iconStasiun = value);
  setIconMarker("assets/images/marker/marker_polsri.png", (value) => FungsiMaps.iconPolsri = value);
  // ================================== Set Icon Marker ======================================= //

  // ==================== Get Data Store URL Home Konten & Save Cache ========================= //
  getStoreImage('home', 'imageurl', (value) {
    LocalData.imageHomeUrl != value ? LocalData.imageHomeUrl = value : null;
    saveListCache('imageHomeUrl', value);
  });

  getStoreImage('artikel', 'imageurl', (value) {
    LocalData.imageArtikelUrl != value ? LocalData.imageArtikelUrl = value : null;
    saveListCache('imageArtikelUrl', value);
  });
  // ==================== Get Data Store URL Home Konten & Save Cache ========================= //
}

bool getJadwalGanjil() {
  if (LocalData.indexGetDataGanjil < DataMaps.namaStasiunGanjil.length && DataMaps.jadwalDJKAkeBandara.length < DataMaps.namaStasiunGanjil.length) {
    getStoreJadwalDJKAkeBandara(DataMaps.namaStasiunGanjil[LocalData.indexGetDataGanjil], (value) {
      if (value.toString() != LocalData.valueCurrentGetDataGanjil) {
        DataMaps.jadwalDJKAkeBandara.add(value);
        LocalData.valueCurrentGetDataGanjil = value.toString();
        LocalData.indexGetDataGanjil++;
      } else {
        getJadwalGanjil(); // Memanggil kembali addData() sampai data berbeda ditemukan
      }
    });
  } else {
    return false;
  }
  return true;
}

bool getJadwalGenap() {
  if (LocalData.indexGetDataGenap < DataMaps.namaStasiunGenap.length && DataMaps.jadwalBandaraKeDJKA.length < DataMaps.namaStasiunGenap.length) {
    getStoreJadwalBandaraKeDJKA(
      DataMaps.namaStasiunGenap[LocalData.indexGetDataGenap],
      (value) {
        if (value.toString() != LocalData.valueCurrentGetDataGenap) {
          DataMaps.jadwalBandaraKeDJKA.add(value);
          LocalData.valueCurrentGetDataGenap = value.toString();
          LocalData.indexGetDataGenap++;
        } else {
          getJadwalGenap(); // Memanggil kembali addData() sampai data berbeda ditemukan
        }
      },
    );
  } else {
    return false;
  }
  return true;
}
