import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UploadCv extends StatefulWidget {
  Function(File?) bindingValue;
  UploadCv({super.key, required this.bindingValue});

  @override
  State<UploadCv> createState() => _UploadCvState();
}

class _UploadCvState extends State<UploadCv> {
  bool isUploaded = false;
  bool? _isLoading;
  PlatformFile? _selectedFile;

  Future<void> _pickFile() async {
    setState(() {
      _isLoading = true;
      _selectedFile = null;
    });

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'docx', 'doc'],
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          _selectedFile = result.files.single;
          widget.bindingValue(File(_selectedFile!.path!));
        });
      }
    } catch (e) {
      print("Lỗi khi chọn file: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildFileInfo() {
    if (_selectedFile == null) return _mainUpload();

    return Card(
      color: Colors.grey[100],
      // color: Color.fromRGBO(67, 177, 183, .7),
      margin: EdgeInsets.symmetric(vertical: 15),
      child: ListTile(
        leading: Icon(
          Icons.file_present_outlined,
          size: 30,
          color: const Color.fromRGBO(0, 0, 0, .7),
        ),
        title: Text(_selectedFile!.name),
        subtitle: Text(
          "${(_selectedFile!.size / 1024).toStringAsFixed(2)} KB",
        ),
        trailing: GestureDetector(
          onTap: () {
            setState(() {
              _selectedFile = null;
            });
          },
          child: Icon(Icons.close, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _mainUpload() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: GestureDetector(
            onTap: () {
              _pickFile();
            },
            child: Container(
              decoration: BoxDecoration(
                // color: Color.fromRGBO(254, 212, 8, .8),
                border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: .9,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.file_upload_outlined,
                          size: 25,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Upload your CV",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "(Support *.pdf, *.doc, *.docx and has size < 5MB)",
                      style: TextStyle(
                          fontSize: 13,
                          color: const Color.fromRGBO(0, 0, 0, .5)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: 15,
      ),
      Text(
        "Application infomation",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      _buildFileInfo()
    ]);
  }
}
