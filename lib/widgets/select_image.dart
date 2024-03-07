import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class SelectImage extends StatefulWidget {
  const SelectImage({super.key});

  @override
  State<SelectImage> createState() => _SelectImageState();
}

class _SelectImageState extends State<SelectImage> {

  File? _image;                //I think is library s web pr image select ni hoti
  final picker = ImagePicker();
  String? selectedImageName; // Variable to store the selected file name

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade100),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              getGalleryImage();
            },
            child: Container(
              height: 37,
              width: 134,
              margin: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                  color: const Color(0xff07aeaf),
                  borderRadius:
                  BorderRadius.circular(8)),
              child: const Center(
                child: Text('Choose Image',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              selectedImageName != null
                  ? (selectedImageName!.length > 10
                  ? selectedImageName!
                  .substring(0, 10) +
                  '...'
                  : selectedImageName!)
                  : 'Image name',
              // Display selected file name or 'File name'
              // if none is selected
              overflow: TextOverflow.ellipsis,
              // Handle overflow with ellipsis
              style: const TextStyle(
                  color: Colors.black, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }

  Future getGalleryImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        selectedImageName = pickedFile.name;
      } else {
        print('no image picked');
      }
    });
  }
}
