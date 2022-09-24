import 'package:flutter/material.dart';
import 'package:moneylover/theme/suntec_colors.dart';
import 'package:moneylover/theme/suntec_fonts.dart';

class SuntecButton extends StatelessWidget {
  final Function onTap;
  final String title;
  final Color textColor;
  final Widget child;
  final bool haveShadow;
  final Color backgroundColor;
  final double radius;
  final bool isFullWidth;
  final EdgeInsets padding;
  final Color borderColor;
  final TextStyle textStyle;
  final Size minimumSize;

  const SuntecButton({
    this.title,
    this.onTap,
    this.textColor,
    this.child,
    this.haveShadow = false,
    this.isFullWidth = false,
    this.backgroundColor,
    this.radius = 8.0,
    this.padding,
    this.textStyle,
    this.borderColor = Colors.transparent,
    this.minimumSize,
  });

  @override
  Widget build(BuildContext context) {
    Widget widget = ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        primary: backgroundColor ?? SuntecColor.colorBlue001A4B,
        textStyle: SuntecFonts.semiBold(
            color: textColor ?? Colors.white, fontSize: 13),
        shadowColor: Colors.black,
        minimumSize: minimumSize ?? const Size(200.0, 44.0),
        padding: EdgeInsets.zero,
        elevation: haveShadow ? 4 : 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: BorderSide(color: borderColor),
        ),
      ),
      child: _buildChild(),
    );

    if (isFullWidth) {
      return SizedBox(
        width: double.infinity,
        child: widget,
      );
    }

    return widget;
  }

  Widget _buildChild() {
    if (child != null) return child;

    return Padding(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
      child: Text(
        title ?? "",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: textStyle ??
            SuntecFonts.semiBold(
                color: textColor ?? Colors.white,
                fontSize: 13,
                height: 20 / 13),
      ),
    );
  }
}
