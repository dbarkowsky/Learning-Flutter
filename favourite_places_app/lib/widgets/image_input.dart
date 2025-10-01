import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final void Function(File image) onChooseImage;
  const ImageInput({super.key, required this.onChooseImage});

  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    // This is finicky in the emulator. Settings have to be just right.
    final image = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (image != null) {
        widget.onChooseImage(File(image.path));
        setState(() {
          _selectedImage = File(image.path);
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: _selectedImage != null
          ? GestureDetector(
              onTap: _takePicture,
              child: Image.file(
                _selectedImage!,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            )
          : TextButton.icon(
              onPressed: _takePicture,
              icon: const Icon(Icons.camera),
              label: const Text("Take picture"),
            ),
    );
  }
}
