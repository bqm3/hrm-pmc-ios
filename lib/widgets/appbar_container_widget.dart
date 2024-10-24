import 'package:flutter/material.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/resources/app_resource.dart';
import 'package:salesoft_hrm/widgets/component/back_button_widget.dart';

class AppBarContainerWidget extends StatelessWidget {
  const AppBarContainerWidget({Key? key, this.title, this.body})
      : super(key: key);

  final Widget? title;
  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 186,
          child: AppBar(
            leading: const BackButtonWidget(),
            automaticallyImplyLeading: false,
            elevation: 0,
            toolbarHeight: 90,
            title: title ??
                const Row(
                  children: [],
                ),
            flexibleSpace: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    AppResource.icbannervnpt,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 150,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
              ),
              color: AppColors.grey60,
            ),
            child: body,
          ),
        ),
      ],
    );
  }
}
