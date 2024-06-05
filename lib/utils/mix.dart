import 'package:intl/intl.dart';

//get today date
  String getTodayDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(now);
  } 

  //get status absensi masuk
  String getPresenceEntryStatus(String jamMasuk) {
    if (jamMasuk.isEmpty) return 'Unknown';
    String jamMasuk2 = (jamMasuk == '--:--')? '00:00':jamMasuk;
    final time = DateFormat('HH:mm').parse(jamMasuk2);
    final startTime = DateTime(time.year, time.month, time.day, 6, 0); // 06:00
    final endTime = DateTime(time.year, time.month, time.day, 8, 0); // 08:00

    if (time.isAfter(startTime) && time.isBefore(endTime)) {
      return 'Tepat Waktu';
    } else {
      return 'Terlambat';
    }
  }
  //get status absensi kelar
  String getPresenceExitStatus(String jamKeluar) {
    if (jamKeluar.isEmpty) return 'Unknown';
    String jamKeluar2 = (jamKeluar == '--:--')? '00:00':jamKeluar;
    final time = DateFormat('HH:mm').parse(jamKeluar2);
    final startTime = DateTime(time.year, time.month, time.day, 6, 0); // 06:00
    final endTime = DateTime(time.year, time.month, time.day, 8, 0); // 08:00

    if (time.isAfter(startTime) && time.isBefore(endTime)) {
      return 'Tepat Waktu';
    } else {
      return 'Pulang Cepat';
    }
  }