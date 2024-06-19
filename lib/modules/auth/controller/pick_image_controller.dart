import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PickImageController extends GetxController {
  Future<dynamic> loadImage(ImageSource source) async {
    XFile? image;
    final ImagePicker picker = ImagePicker();
    if (source == ImageSource.camera) {
      await picker.pickImage(source: ImageSource.camera).then((img) {
        image = img;
        debugPrint("======== $image");
      });
    } else {
      await picker.pickImage(source: ImageSource.gallery).then((img) {
        image = img;
      });
    }
  }
}
