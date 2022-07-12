import 'dart:io';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage, {Key? key}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  _takePicture() async {
    final ImagePicker _picker = ImagePicker();
    XFile imageFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    ) as XFile;

    setState(() {
      _storedImage = File(imageFile.path);
    });

    Directory appDirectory = await syspath.getApplicationDocumentsDirectory();
    String filename = path.basename(_storedImage!.path);
    final savedImage = await _storedImage!.copy(
      '${appDirectory.path}/$filename',
    );

    widget.onSelectImage(savedImage);
  }

  _getFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    XFile imageFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    ) as XFile;

    setState(() {
      _storedImage = File(imageFile.path);
    });

    Directory appDirectory = await syspath.getApplicationDocumentsDirectory();
    String filename = path.basename(_storedImage!.path);
    final savedImage = await _storedImage!.copy(
      '${appDirectory.path}/$filename',
    );

    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 180,
          height: 200,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _storedImage != null
              ? Image.file(_storedImage!,
                  width: double.infinity, fit: BoxFit.cover)
              : const Text('Nenhuma imagem'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            children: [
              TextButton.icon(
                style: TextButton.styleFrom(
                    primary: Theme.of(context).primaryColor),
                icon: Icon(Icons.camera),
                label: Text('Tirar foto'),
                onPressed: _takePicture,
              ),
              SizedBox(height: 5),
              TextButton.icon(
                style: TextButton.styleFrom(
                    primary: Theme.of(context).primaryColor),
                icon: Icon(Icons.photo),
                label: Text('Galeria'),
                onPressed: _getFromGallery,
              ),
            ],
          ),
        )
      ],
    );
  }
}
