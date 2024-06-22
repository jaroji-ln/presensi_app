import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:presensi_app/model/log_activity.dart';
import 'package:presensi_app/screen/log_activity_screen/add_log_screen.dart';
import 'package:presensi_app/screen/log_activity_screen/update_log_screen.dart';

class LogsActivityScreen extends StatefulWidget {
  final String nik; // Assume you pass nik from previous screen
  final String token; // JWT token

  LogsActivityScreen({required this.nik, required this.token});

  @override
  _ActivityLogsScreenState createState() => _ActivityLogsScreenState();
}

class _ActivityLogsScreenState extends State<LogsActivityScreen> {
  late Future<List<LogActivity>> futureLogs;

  @override
  void initState() {
    super.initState();
    futureLogs = fetchActivityLogs();
  }

  Future<List<LogActivity>> fetchActivityLogs() async {
    final response = await http.get(
      Uri.parse('https://presensi.spilme.id/activities?nik=${widget.nik}'),
      headers: {
        'Authorization': 'Bearer ${widget.token}',
      },
    );
    
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((log) => LogActivity.fromJson(log)).toList();
    } else {
      throw Exception('Data aktifitas tidak tersedia');
    }
  }

  void _addLog() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddLogScreen(token: widget.token, nik: widget.nik),
      ),
    ).then((value) {
      if (value == true) {
        setState(() {
          futureLogs = fetchActivityLogs();
        });
      }
    });
  }

  void _editLog(LogActivity log) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateLogScreen(token: widget.token, log: log),
      ),
    ).then((value) {
      if (value == true) {
        setState(() {
          futureLogs = fetchActivityLogs();
        });
      }
    });
  }

    Future<void> _deleteLog(int logId) async {
    final response = await http.delete(
      Uri.parse('https://presensi.spilme.id/activity?id=$logId'),
      headers: {
        'Authorization': 'Bearer ${widget.token}',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        futureLogs = fetchActivityLogs();
      });
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Log deleted successfully')),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete log')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100.0,
        title: Text(
          'Log Aktivitas',
          style: GoogleFonts.manrope(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xff101317),
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            color: const Color(0xff101317),
            onPressed: _addLog,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 0.0, right: 16.0, bottom: 16.0),
          child: FutureBuilder<List<LogActivity>>(
            future: futureLogs,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No logs available'));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final log = snapshot.data![index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(
                          log.aktifitas,
                          style: GoogleFonts.manrope(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff111111),
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              'Tanggal: ${log.tanggal}',
                              style: GoogleFonts.manrope(
                                fontSize: 14,
                                color: const Color(0xff707070),
                              ),
                            ),
                            const SizedBox(height: 4),
                            if (log.bukti.isNotEmpty)
                              Image.network(
                                'https://presensi.spilme.id/uploads/images/karyawan/${log.bukti}',
                                height: 100,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () => _editLog(log),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _deleteLog(log.id),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}