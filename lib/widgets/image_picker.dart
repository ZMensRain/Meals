import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerCard extends StatelessWidget {
  const ImagePickerCard(
    this.imageFile, {
    super.key,
    required this.onImagePicked,
  });

  final File? imageFile;
  final void Function(File image) onImagePicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () async {
          var picker = ImagePicker();
          var file = await picker.pickImage(
            source: ImageSource.camera,
          );
          if (file == null) {
            return;
          }

          onImagePicked(File(file.path));
        },
        child: Stack(
          children: [
            if (imageFile != null)
              Image(
                image: FileImage(imageFile!),
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            const Center(child: Icon(Icons.camera_alt)),
          ],
        ),
      ),
    );
  }
}
