import 'package:flutter/material.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';

class EditText extends StatelessWidget {
  final String title;
  final Function(String)? onChange;
  final String value;
  final bool isHideValue;
  final TextEditingController? controllerTF;
  final Widget? suffix;
  final String? errorMessage;

  const EditText({
    Key? key,
    required this.title,
    required this.onChange,
    required this.value,
    this.isHideValue = false,
    this.controllerTF,
    this.suffix,
    this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = controllerTF ?? TextEditingController(text: value);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.orBgr
              ),
        ),
        AppConstant.spaceVerticalSmallMedium,
        TextField(
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.black,
              ),
          controller: controller,
          obscureText: isHideValue,
          maxLines: 1,
          onChanged: onChange,
          decoration: InputDecoration(
            fillColor: AppColors.blue100,
            filled: true,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppConstant.kSpaceHorizontalSmallExtraExtraExtra,
              vertical: AppConstant.kSpaceVerticalSmallExtra,
            ),
            hintText: 'Chạm để nhập',
            suffix: suffix,
          ),
        ),
        if (errorMessage != null)
          Text(
            errorMessage!,
            style: const TextStyle(color: AppColors.red),
          ),
      ],
    );
  }
}
