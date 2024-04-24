import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presensi_app/screen/dashboard_screen.dart';
import 'package:presensi_app/screen/login_screen.dart';

class SplashScreen extends StatelessWidget{
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context){

    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false);
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo_polbeng.png',
              width: 128,
            ),
            const SizedBox(height: 8,),
            Text(
              'PresensiApp',
              style: GoogleFonts.manrope(
                fontSize: 34,
                color: const Color(0xFF12A3DA),
                fontWeight: FontWeight.w700,
              )  
            ),
          ],
        ),),
    );
  }
}