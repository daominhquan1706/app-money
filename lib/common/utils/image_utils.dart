// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:moneylover/biz/app_banner_controller.dart';

// class ImageUtils {
//   static Widget getNetworkImage(String url,
//       {double height, double width, BoxFit fit = BoxFit.contain, Color color}) {
//     return CachedNetworkImage(
//       imageUrl: url,
//       width: width,
//       height: height,
//       color: color,
//       fit: fit,
//     );
//   }

//   static Future<PickedFile> onImagePickerCamera() async {
//     final ImagePicker _picker = ImagePicker();
//     Get.find<AppBannerController>().setPreventShowSplashScreen();
//     final PickedFile photo = await _picker.getImage(source: ImageSource.camera);
//     return photo;
//   }

//   static Future<PickedFile> onImagePickerGallery() async {
//     final ImagePicker _picker = ImagePicker();
//     Get.find<AppBannerController>().setPreventShowSplashScreen();
//     final PickedFile photo =
//         await _picker.getImage(source: ImageSource.gallery);
//     return photo;
//   }
// }
