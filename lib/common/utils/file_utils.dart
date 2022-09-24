// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:get/get.dart';
// import 'package:moneylover/biz/app_banner_controller.dart';

// extension FileExtention on File {
//   String get name {
//     return this?.path?.split("/")?.last;
//   }
// }

// class FileUtils {
//   static Future<PlatformFile> pickPdfFile() async {
//     Get.find<AppBannerController>().setPreventShowSplashScreen();
//     FilePickerResult result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowMultiple: false,
//       allowedExtensions: ['pdf'],
//     );
//     if (result == null || result.files.isEmpty) {
//       return null;
//     }
//     return result.files.first;
//   }

//   static void downloadFile({String url, String filePath}) async {
//     // var text = ''.obs;
//     // final downloaderUtils = DownloaderUtils(
//     //   progressCallback: (current, total) {
//     //     final progress = (current / total) * 100;
//     //     print('Downloading: $progress');
//     //     // Get.snackbar('Downloading', 'Progress: $progress% ');
//     //   },
//     //   file: File(filePath),
//     //   progress: ProgressImplementation(),
//     //   onDone: () => OpenFile.open(filePath),
//     //   deleteOnCancel: true,
//     // );
//     // Get.snackbar(
//     //   'Downloading !',
//     //   'Please wait...',
//     //   snackPosition: SnackPosition.BOTTOM,
//     // );
//     // await Flowder.download(url, downloaderUtils);
//   }
// }
