import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Upload(),
    );
  }
}

class Upload extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Upload> {
  File? _document;

  Future<void> _getDocument() async {
    final documentPicker = ImagePicker();
    final pickedFile = await documentPicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _document = File(pickedFile.path);
      });
    }
  }

  void _viewDocument() {
    if (_document != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              width: 300,
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      Icons.picture_as_pdf,
                      size: 50,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Document Name.pdf',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam eget augue eget sapien lacinia vestibulum.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    } else {
      // Show a message or handle when there's no document to show
      print("No document to show.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Document Upload and View'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _getDocument,
              child: Text('Upload Document'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _viewDocument,
              child: Text('View Document'),
            ),
          ],
        ),
      ),
    );
  }
}
