import 'package:flutter/material.dart';

class FilterWidget extends StatelessWidget {
  final Color textColor;
  final String title;
  final String value;
  final String imageAssetName;
  final VoidCallback onPress;

  const FilterWidget({
    Key? key,
    required this.textColor,
    required this.title,
    required this.value,
    required this.imageAssetName,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(imageAssetName, width: 20, height: 20),
              const SizedBox(width: 5),
              Text(
                title,
                style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(color: textColor),
          ),
        ],
      ),
    );
  }
}
