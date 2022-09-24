import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneylover/common/common.dart';
import 'package:moneylover/language/string_manager.dart';
import 'package:moneylover/theme/suntec_colors.dart';
import 'package:moneylover/theme/suntec_fonts.dart';
import 'package:moneylover/theme/suntec_images.dart';

class DialogUtils {
  static void showDialog(
      {String title = "",
      String description = "",
      Widget content,
      bool isShowClose = true,
      bool barrierDismissible = true,
      bool isShowIconImage = true,
      String iconImage = SuntecImages.icCheck,
      double radius = 12,
      EdgeInsets paddingBottom,
      String actionButtonTitle = "PROCEED",
      Function onTap,
      Function onTapClose,
      bool isShowCancelButton = false}) {
    paddingBottom ??= const EdgeInsets.only(bottom: 20.0);
    Get.dialog(
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.only(
                  left: 24, right: 24, bottom: 24, top: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radius),
              ),
              child: Column(
                children: [
                  if (isShowClose)
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: onTapClose ?? Get.back,
                        child: const Icon(Icons.close,
                            size: 24, color: SuntecColor.colorBlack262626),
                      ),
                    ),
                  if (isShowIconImage)
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 28),
                      child: Image.asset(
                        iconImage,
                        width: 85,
                        height: 85,
                      ),
                    ),
                  if (title.isNotEmpty)
                    Padding(
                      padding: paddingBottom,
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: SuntecFonts.semiBold(
                            fontSize: 15, color: SuntecColor.big1Color),
                      ),
                    ),
                  if (description.isNotEmpty)
                    Padding(
                      padding: paddingBottom,
                      child: Text(
                        description,
                        textAlign: TextAlign.center,
                        style: SuntecFonts.regular(
                            fontSize: 15, color: SuntecColor.colorGrey434343),
                      ),
                    ),
                  if (content != null)
                    Padding(
                      padding: paddingBottom,
                      child: content,
                    ),
                  if (onTap != null)
                    SuntecButton(
                      title: actionButtonTitle.tr,
                      textStyle: SuntecFonts.regular(
                          fontSize: 12, color: Colors.white),
                      radius: 8,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      onTap: onTap,
                    ),
                  if (isShowCancelButton)
                    TextButton(
                      child: Text(StringManager.cancel.tr,
                          style: SuntecFonts.regular(
                            fontSize: 12,
                          )),
                      onPressed: () => Get.back(),
                    )
                ],
              ),
            ),
          ],
        ),
        barrierDismissible: barrierDismissible);
  }

  static void showSuccessDialog(String text) {
    DialogUtils.showDialog(
        barrierDismissible: false,
        isShowClose: false,
        radius: 12,
        content: Column(
          children: [
            buildHeight(20),
            Text(
              text,
              style: SuntecFonts.medium(
                fontSize: 15,
                color: SuntecColor.colorGrey595959,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ));
  }

  static void showDialogSuccess(String text) async {
    Get.dialog(
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/ic_success.png',
                  width: 40,
                  height: 40,
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
      barrierColor: Colors.black.withOpacity(0.35),
      barrierDismissible: false,
    );
    await Future.delayed(const Duration(milliseconds: 1500));
    Get.back();
  }

  static void showDialogCorporate(
      {Function onTapOk, String content, String title}) async {
    return Get.dialog(
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: Get.width * 0.7,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: SuntecFonts.bold(
                    fontSize: 15,
                    height: 24 / 15,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  content,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                SuntecButton(
                  title: 'OK',
                  onTap: onTapOk,
                ),
              ],
            ),
          ),
        ],
      ),
      barrierColor: Colors.black.withOpacity(0.35),
      barrierDismissible: false,
    );
  }

  static OverlayEntry showOverlayDialog(Widget dialog, {int second}) {
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(builder: (context) {
      return Scaffold(
        body: dialog,
        backgroundColor: Colors.black26,
      );
    });
    Overlay.of(Get.context).insert(overlayEntry);
    if (second != null) {
      Timer(Duration(seconds: second), () {
        overlayEntry.remove();
      });
    }
    return overlayEntry;
  }

  static void showInternalServerErrorMessage() {
    // while (Get.isDialogOpen) {
    //   Get.back();
    // }
    Get.dialog(
      CupertinoAlertDialog(
        content: const Text(
            'System is currently running schedule maintenance. Please try again after few minutes later.'),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
      barrierColor: Colors.black.withOpacity(0.35),
      barrierDismissible: false,
    );
  }

  static Future<DateTime> showCupertinoDatePicker() async {
    Rx<DateTime> selectedDate = Rx<DateTime>(DateTime.now());
    await Get.dialog(Column(
      children: [
        const Spacer(),
        Container(
          height: 300,
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Text(
                      'Date of Birth',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Obx(
                      () => InkWell(
                        onTap: () => Get.back(),
                        child: Text(
                          selectedDate.value.formatDateMMMddYYY,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.05),
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  initialDateTime: selectedDate.value,
                  onDateTimeChanged: (DateTime value) {
                    selectedDate.value = value;
                  },
                  mode: CupertinoDatePickerMode.date,
                  maximumDate: DateTime.now(),
                  maximumYear: DateTime.now().year,
                ),
              ),
            ],
          ),
        ),
      ],
    ));

    return selectedDate.value;
  }
}
