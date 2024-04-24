import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class AttandanceRecapScreen extends StatefulWidget{
  const AttandanceRecapScreen({super.key});

  @override
  State<AttandanceRecapScreen> createState(){
    return _AttandanceRecapSreenApp();
  }
}

class _AttandanceRecapSreenApp extends State<AttandanceRecapScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100.0,
        title: Text(
          'Rekap Absensi',
          style: GoogleFonts.manrope(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color:const Color(0xff101317),
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios)
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left:16.0,top:0.0,right:16.0,bottom:16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Color (0xff3498DB), width: 1.0), // Gray border for the Card
                          borderRadius: BorderRadius.circular(10.0), // Rounded corners
                        ),
                        color: const Color(0xffE5F3FC), 
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Jumlah Izin',
                                style: GoogleFonts.manrope(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff101317),
                                )
                              ),
                              const SizedBox(height:10.0,),
                              Text(
                                '0',
                                style: GoogleFonts.lexend(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff3085FE),
                                ),
                              )
                            ],
                          ),
                        ),
                    )
                  ),
                  const SizedBox(width: 8.0,),
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Color (0xffA3D139), width: 1.0), // Gray border for the Card
                          borderRadius: BorderRadius.circular(10.0), // Rounded corners
                        ),
                        color: const Color(0xffEEF8D6), 
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Jumlah Hadir',
                                style: GoogleFonts.manrope(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff101317),
                                )
                              ),
                              const SizedBox(height:10.0,),
                              Text(
                                '2',
                                style: GoogleFonts.lexend(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xffA3D139),
                                ),
                              )
                            ],
                          ),
                        ),
                    )
                  )
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Color (0xff9B59B6), width: 1.0), // Gray border for the Card
                          borderRadius: BorderRadius.circular(10.0), // Rounded corners
                        ),
                        color: const Color(0xffF1DCFA), 
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Jumlah Sakit',
                                style: GoogleFonts.manrope(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff101317),
                                )
                              ),
                              const SizedBox(height:10.0,),
                              Text(
                                '0',
                                style: GoogleFonts.lexend(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff9B59B6),
                                ),
                              )
                            ],
                          ),
                        ),
                    )
                  ),
                  const SizedBox(width: 8.0,),
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Color (0xffE74C3C), width: 1.0), // Gray border for the Card
                          borderRadius: BorderRadius.circular(10.0), // Rounded corners
                        ),
                        color: const Color(0xffFFE5E2), 
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Jumlah Alpa',
                                style: GoogleFonts.manrope(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff101317),
                                )
                              ),
                              const SizedBox(height:10.0,),
                              Text(
                                '0',
                                style: GoogleFonts.lexend(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xffB33022),
                                ),
                              )
                            ],
                          ),
                        ),
                    )
                  )
                ],
              ),
              TableCalendar(
                focusedDay: DateTime.now(), 
                firstDay: DateTime.utc(2010,1,1), 
                lastDay: DateTime.utc(2040,12,31),
                headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Aktifitas',
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff101317)
                    ),
                  ),
                  GestureDetector(
                    onTap: (){},
                    child: Text(
                      'Lihat Semua',
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        color: const Color(0xff12A3DA)
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      )
    );
  }
}

  
