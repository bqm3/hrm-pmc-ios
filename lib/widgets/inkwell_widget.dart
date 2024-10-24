import 'package:flutter/material.dart';
import 'package:salesoft_hrm/common/app_colors.dart';

class InkWellWidget extends StatelessWidget {
  final Widget child;
  final Function()? onPress;
  final EdgeInsets? padding;
  final Color? onPressColor;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? highlightColor;
  final double? borderRadius;

  const InkWellWidget({
    Key? key,
    required this.child,
    this.onPress,
    this.padding,
    this.onPressColor,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        focusColor: focusColor ?? AppColors.greyBackground,
        hoverColor: hoverColor,
        highlightColor: highlightColor,
        onTap: onPress,
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: child,
        ),
      ),
    );
  }
}
