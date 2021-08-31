import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;
  Future<void> _takePicture() async {
    // Formerly we just had to call pickImage
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    File realImageFile = File(imageFile.path);

    setState(() {
      // Wrapping imageFile with File() constructor to convert that into a sdart File object
      _storedImage = File(imageFile.path);
    });

    // spelled  'syspaths' in the course flutter version
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(realImageFile.path);
    final savedImage = await realImageFile.copy('${appDir.path}/$fileName');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'Preview not available',
                  textAlign: TextAlign.center,
                ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take a photo'),
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}
