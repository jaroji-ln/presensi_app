import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:presensi_app/model/log_activity.dart';

class UpdateLogScreen extends StatefulWidget {
  final String token;
  final LogActivity log;

  UpdateLogScreen({required this.token, required this.log});

  @override
  _UpdateLogScreenState createState() => _UpdateLogScreenState();
}

class _UpdateLogScreenState extends State<UpdateLogScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _activityController;
  DateTime? _selectedDate;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _activityController = TextEditingController(text: widget.log.aktifitas);
    _selectedDate = DateTime.parse(widget.log.tanggal);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      final uri = Uri.parse('https://presensi.spilme.id/activity?id=${widget.log.id}');
      final request = http.MultipartRequest('PUT', uri);
      request.headers['Authorization'] = 'Bearer ${widget.token}';
      request.fields['aktifitas'] = _activityController.text;
      request.fields['tanggal'] = _selectedDate!.toIso8601String();
      if (_selectedImage != null) {
        request.files.add(await http.MultipartFile.fromPath('bukti', _selectedImage!.path));
      }

      final response = await request.send();
      
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Log updated successfully')),
        );
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update log')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100.0,
        title: Text(
          'Update Log Aktivitas',
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
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _activityController,
                  decoration: const InputDecoration(labelText: 'Aktivitas'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an activity';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'Tanggal belum dipilih!'
                          : '${_selectedDate!.toLocal()}'.split(' ')[0],
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: const Text('Pilih Tanggal'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _selectedImage == null
                        ? widget.log.bukti.isEmpty
                            ? const Text('Bukti kerja belum dipilih (jpg, png)')
                            : Image.network(
                                'https://presensi.spilme.id/uploads/images/activities/${widget.log.bukti}',
                                height: 100,
                                width: 100,
                              )
                        : Image.file(_selectedImage!, height: 100, width: 100),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _selectImage,
                      child: const Text('Pilih Gambar'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Update Aktifitas'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
