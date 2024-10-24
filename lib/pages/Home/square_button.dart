import 'package:flutter/material.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';

class SquareButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String image;

  const SquareButton({
    Key? key,
    required this.onPressed,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: AppConstant.getScreenSizeHeight(context) * 0.05,
        height: AppConstant.getScreenSizeHeight(context) * 0.05,
        decoration: BoxDecoration(
          color: AppColors.blueVNPT,
          border: Border.all(color: Colors.blueAccent, width: 2),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        alignment: Alignment.center,
        child: Image.asset(
          image,
        ),
      ),
    );
  }
}
