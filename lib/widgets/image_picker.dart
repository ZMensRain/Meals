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
          // SafeArea(
          //         child: Container(
          //           child: new Wrap(
          //             children: <Widget>[
          //               new ListTile(
          //                   leading: new Icon(Icons.photo_library),
          //                   title: new Text('Photo Library'),
          //                   onTap: () {
          //                     _imgFromGallery();
          //                     Navigator.of(context).pop();
          //                   }),
          //               new ListTile(
          //                 leading: new Icon(Icons.photo_camera),
          //                 title: new Text('Camera'),
          //                 onTap: () {
          //                   _imgFromCamera();
          //                   Navigator.of(context).pop();
          //                 },
          //               ),
          //             ],
          //           ),
          //         ),
          //       );
          //     }
          //   );

          var useCamera = await showModalBottomSheet<bool>(
            clipBehavior: Clip.hardEdge,
            context: context,
            builder: (context) => SafeArea(
              child: Wrap(
                children: [
                  ListTile(
                    title: const Text("Camera"),
                    onTap: () {
                      Navigator.pop(context, true);
                    },
                  ),
                  ListTile(
                    title: const Text("Gallery"),
                    onTap: () {
                      Navigator.pop(context, false);
                    },
                  ),
                ],
              ),
            ),
          );
          if (useCamera == null) {
            return;
          }
          var picker = ImagePicker();
          XFile? file;

          if (useCamera) {
            file = await picker.pickImage(
              source: ImageSource.camera,
            );
          } else {
            file = await picker.pickImage(
              source: ImageSource.gallery,
            );
          }
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
