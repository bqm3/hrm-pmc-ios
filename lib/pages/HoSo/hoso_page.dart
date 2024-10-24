import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/common/format_date.dart';
import 'package:salesoft_hrm/pages/HoSo/hoso_body.dart';
import 'package:salesoft_hrm/pages/Home/home_controller.dart';
import 'package:salesoft_hrm/resources/app_resource.dart';
import 'package:salesoft_hrm/widgets/component/back_button_widget.dart';
import 'package:salesoft_hrm/widgets/component/title_appbar_widget.dart';

class HoSoPage extends StatelessWidget {
  const HoSoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonWidget(),
        backgroundColor: AppColors.blueVNPT,
        centerTitle: false,
        elevation: 0,
        title: const TitleAppBarWidget(title: "Hồ sơ nhân sự"),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppResource.icBackground),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.only(
              top: AppConstant.getScreenSizeHeight(context) * 0.02,
            ),
            color: Colors.transparent,
            child: Column(children: [
              SizedBox(
                width: AppConstant.getScreenSizeWidth(context) * 0.8,
                child: Card(
                  elevation: 6,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Obx(() {
                          Color avatarColor;

                          avatarColor = AppColors.blueVNPT;

                          return Container(
                            width:
                                AppConstant.getScreenSizeWidth(context) * 0.2,
                            height:
                                AppConstant.getScreenSizeWidth(context) * 0.2,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: avatarColor,
                            ),
                            child: ClipOval(
                              child: Center(
                                child: Text(
                                  homeController.kh.value,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                        const SizedBox(width: 30),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() => Text(
                                    '${homeController.hoDem.value} ${homeController.ten.value}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      height: 1.5,
                                    ),
                                  )),
                              AppConstant.spaceVerticalSmallExtra,
                              Obx(() => Text(
                                    'Ngày sinh: ${formatDate(homeController.ngaySinh.value)}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          height: 1.5,
                                        ),
                                  )),
                              AppConstant.spaceVerticalSmallExtra,
                              Obx(() => Text(
                                    'Phòng: ${homeController.phongBan.value} ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          height: 1.5,
                                        ),
                                  )),
                              AppConstant.spaceVerticalSmallExtra,
                              Obx(() => Text(
                                    'Chức vụ: ${homeController.chucVu.value} ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          height: 1.5,
                                        ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.05,
              ),
              const HoSoBody(),
            ]),
          ),

//
        ],
      ),
    );
//     return
  }
}
