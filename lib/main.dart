import 'package:flutter/material.dart';
import 'package:presensi_app/screen/splash_screen.dart';
import 'package:intl/date_symbol_data_local.dart'; 

Future<void> main() async {
  //untuk format tanggal indonesia
  await initializeDateFormatting('id', null);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'Presensi App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
