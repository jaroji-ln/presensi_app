import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddLogScreen extends StatefulWidget {
  final String nik;
  final String token;

  AddLogScreen({required this.nik, required this.token});

  @override
  _AddLogScreenState createState() => _AddLogScreenState();
}

class _AddLogScreenState extends State<AddLogScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _activityController = TextEditingController();
  DateTime? _selectedDate;
  File? _selectedImage;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
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
    print('widget ${widget.nik} ${widget.token}');
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      final uri = Uri.parse('https://presensi.spilme.id/activity');
      final request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = 'Bearer ${widget.token}';
      request.fields['nik'] = widget.nik;
      request.fields['tanggal'] = _selectedDate!.toIso8601String();
      request.fields['aktifitas'] = _activityController.text;
      if (_selectedImage != null) {
        request.files.add(await http.MultipartFile.fromPath('bukti', _selectedImage!.path));
      }

      final response = await request.send();
      
      if (response.statusCode == 201) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Log added successfully')),
        );
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to add log')),
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
          'Tambah Log Aktivitas',
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
                          ? 'Tanggal belum dipilih'
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
                        ? const Text('Bukti kerja belum dipilih (jpg, png).')
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
                    child: const Text('Tambah Log'),
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
