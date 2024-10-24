import 'package:flutter/material.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/widgets/inkwell_widget.dart';


class FunctionItemWidget extends StatelessWidget {
  const FunctionItemWidget({
    Key? key,
    this.onPress,
    required this.title,
    required this.imageAssetName,
    required this.backgroundColor,
    this.width = 53,
    this.height = 53,
    this.widthIcon,
    this.iconData,
  }) : super(key: key);

  final Function()? onPress;
  final String title;
  final String imageAssetName;
  final Color backgroundColor;
  final double width;
  final double height;
  final double? widthIcon;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return InkWellWidget(
      onPress: onPress,
      borderRadius: 5.0,
      padding: EdgeInsets.all(AppConstant.kSpaceVerticalSmall),
      child: Column(
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(5.0),
              ),
              shape: BoxShape.rectangle,
            ),
            child: Align(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: AppConstant.kSpaceVerticalSmall,
                ),
                child: iconData != null
                    ? Icon(
                        iconData,
                        size: 50,
                        color: Colors.white,
                      )
                    : Image.asset(
                        imageAssetName,
                        fit: BoxFit.fill,
                        width: widthIcon ?? width * 2 / 3,
                      ),
              ),
            ),
          ),
          AppConstant.spaceVerticalSmallExtra,
          SizedBox(
            width: width,
            child: Text(
              title,
              maxLines: 2,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 10,
                    color: AppColors.grey,
                  ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
