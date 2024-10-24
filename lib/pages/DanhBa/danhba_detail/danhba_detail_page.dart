import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/common/format_date.dart';
import 'package:salesoft_hrm/pages/DanhBa/danhba_detail/danhba_detail_body.dart';
import 'package:salesoft_hrm/pages/DanhBa/danhba_detail/danhba_detail_controller.dart';
import 'package:salesoft_hrm/resources/app_resource.dart';
import 'package:salesoft_hrm/widgets/appbar_container_widget.dart';
import 'package:salesoft_hrm/widgets/component/back_button_widget.dart';
import 'package:salesoft_hrm/widgets/component/title_appbar_widget.dart';

class danhbaDtPage extends StatelessWidget {
  const danhbaDtPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DtController dtController = Get.find<DtController>();

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
                                  dtController.kh.value,
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
                                    '${dtController.hoDem.value} ${dtController.ten.value}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      height: 1.5,
                                    ),
                                  )), AppConstant.spaceVerticalSmallExtra,
                              Obx(() => Text(
                                    'Ngày sinh: ${formatDate(dtController.ngaySinh.value)} ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          height: 1.5,
                                        ),
                                  )),
                                   AppConstant.spaceVerticalSmallExtra,
                              Obx(() => Text(
                                    'Phòng: ${dtController.phongBan.value} ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          height: 1.5,
                                        ),
                                  )),
                              AppConstant.spaceVerticalSmallExtra,
                              Obx(() => Text(
                                    'Chức vụ: ${dtController.chucVu.value} ',
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
              const HoSoDtBody(),
            ]),
          ),

//
        ],
      ),
//       children: [
//         const AppBarContainerWidget(
//           title: Text(
//             'Hồ Sơ',
//             style: TextStyle(color: Colors.white),
//           ),
//           body: HoSoDtBody(),
//         ),
//         Positioned(
//           top: AppConstant.getScreenSizeHeight(context) / 8,
//           left: 0,
//           right: 0,
//           child: Container(
//             color: Colors.transparent,
//             child: Center(
//               child: SizedBox(
//                 width: MediaQuery.of(context).size.width - 80,
//                 child: Card(
//                   elevation: 6,
//                   color: Colors.white,
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Row(
//                       children: [
//                         Obx(() {
//                           Color avatarColor;
//                           if (dtController.gioiTinh.value == "Nam") {
//                             avatarColor = Colors.blue;
//                           } else {
//                             avatarColor = Colors.pink;
//                           }

//                           return Container(
//                             width:
//                                 AppConstant.getScreenSizeWidth(context) * 0.2,
//                             height:
//                                 AppConstant.getScreenSizeWidth(context) * 0.2,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: avatarColor,
//                             ),
//                             child: ClipOval(
//                               child: Center(
//                                 child: Text(
//                                   dtController.kh.value,
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 24,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         }),
//                         const SizedBox(width: 30),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Obx(() => Text(
//                                     '${dtController.hoDem.value} ${dtController.ten.value}',
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 18,
//                                       height: 1.5,
//                                     ),
//                                   )),
//                               AppConstant.spaceVerticalSmallExtra,
//                               Obx(() => Text(
//                                     'Chức vụ: ${dtController.chucVu.value} ',
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .titleSmall
//                                         ?.copyWith(
//                                           height: 1.5,
//                                         ),
//                                   )),
//                               AppConstant.spaceVerticalSmallExtra,
//                               Obx(() => Text(
//                                     'Phòng: ${dtController.phongBan.value} ',
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .titleSmall
//                                         ?.copyWith(
//                                           height: 1.5,
//                                         ),
//                                   )),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
// //
//       ],
    );
  }
}
