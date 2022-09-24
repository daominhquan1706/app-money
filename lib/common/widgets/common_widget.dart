import 'package:moneylover/theme/suntec_colors.dart';
import 'package:moneylover/theme/suntec_fonts.dart';
import 'package:moneylover/theme/suntec_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneylover/language/string_manager.dart';

double get paddingBottom => MediaQuery.of(Get.context).padding.bottom;

double get paddingTop => MediaQuery.of(Get.context).padding.top;

Widget buildHeight(double height) {
  return SizedBox(
    height: height,
  );
}

Widget buildWidth(double width) {
  return SizedBox(
    width: width,
  );
}

List<BoxShadow> suntecShadow = [
  const BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.15),
    offset: Offset(0, 2),
    blurRadius: 8,
  ),
];

List<BoxShadow> suntecGridItemShadow = [
  BoxShadow(
    color: Colors.black.withOpacity(0.15),
    offset: const Offset(0, 2),
    blurRadius: 8,
  ),
];

Widget buildLineSeparated({
  Color lineColor,
  EdgeInsets margin,
  bool isShadow = false,
  double height = 1.0,
}) {
  return Container(
    margin: margin ?? const EdgeInsets.only(top: 16, bottom: 20),
    height: height,
    width: Get.width,
    decoration: BoxDecoration(
      color: lineColor ?? SuntecColor.colorBlue7A8FA6,
      boxShadow: isShadow ? suntecShadow : null,
    ),
  );
}

Widget buildSuntecLogo(
    {double width, double height, BoxFit fit, bool isWhite = false}) {
  return Image.asset(
    !isWhite ? SuntecImages.icLogo : SuntecImages.icLogoWhite,
    width: width,
    height: height,
    fit: fit,
  );
}

Widget buildPoweredBy({Color color}) {
  return Text(
    StringManager.poweredBy.tr,
    style: SuntecFonts.regular(
        color: color ?? SuntecColor.colorGrey595959, fontSize: 12, height: 1),
  );
}
