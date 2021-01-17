import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  ImageInput(this.onSelectImage);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;
  final picker = ImagePicker();
  Future<void> _getImage() async {
    final pickedImage = await picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    setState(() {
      _storedImage = File(pickedImage.path);
    });
    try {
      final appDir = await sysPaths.getApplicationDocumentsDirectory();
      final fileName = path.basename(pickedImage.path);
      final savedImage =
          File(pickedImage.path).copy('${appDir.path}/$fileName');
      widget.onSelectImage(savedImage);
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image Selected',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
              icon: Icon(Icons.camera),
              label: Text(
                'Take Picture',
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                return showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(
                      'Alert',
                    ),
                    content: Text(
                      'you want take image from Camera or Gallery ?',
                    ),
                    actions: [
                      FlatButton.icon(
                        icon: Icon(Icons.camera),
                        onPressed: () {
                          _getImage();
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        label: Text('Camera'),
                      ),
                      // FlatButton.icon(
                      //   icon: Icon(Icons.photo_camera_back),
                      //   onPressed: () {
                      //     _getImage(ImageSource.gallery);
                      //     Navigator.of(context, rootNavigator: true).pop();
                      //   },
                      //   label: Text('Gallery'),
                      // ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
