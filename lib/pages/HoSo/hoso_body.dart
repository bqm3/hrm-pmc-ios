import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/common/router.dart';
import 'package:salesoft_hrm/resources/app_resource.dart';

class HoSoBody extends StatefulWidget {
  const HoSoBody({super.key});

  @override
  State<HoSoBody> createState() => _HoSoBodyState();
}

class _HoSoBodyState extends State<HoSoBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 60,
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: GestureDetector(
            onTap: () {
              Get.toNamed(ERouter.information.name);
            },
            child: Row(
              children: [
                Image.asset(
                  AppResource.icLylich,
                  width: AppConstant.getScreenSizeWidth(context) * 0.1,
                  fit: BoxFit.fill,
                  color: AppColors.orBgr,
                ),
                const SizedBox(
                  width: 15,
                ),
                const Expanded(
                  flex: 6,
                  child: Text(
                    'Sơ yếu lý lịch',
                    style: TextStyle(color: AppColors.orBgr, fontSize: 18),
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: Icon(Icons.arrow_forward_ios, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          thickness: 2,
          height: 1,
        ),
        Container(
          height: 60,
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: GestureDetector(
            onTap: () {
              Get.toNamed(ERouter.quanhe.name);
            },
            child: Row(
              children: [
                Image.asset(
                  AppResource.icFamily,
                  width: AppConstant.getScreenSizeWidth(context) * 0.1,
                  fit: BoxFit.fill,
                  color: AppColors.orBgr,
                ),
                const SizedBox(
                  width: 15,
                ),
                const Expanded(
                  flex: 6,
                  child: Text(
                    'Quan hệ gia đình',
                    style: TextStyle(color: AppColors.orBgr, fontSize: 18),
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.orBgr,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          thickness: 2,
          height: 1,
        ),
        Container(
          height: 60,
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: GestureDetector(
            onTap: () {
              Get.toNamed(ERouter.luong.name);
            },
            child: Row(
              children: [
                Image.asset(
                  AppResource.icCash,
                  width: AppConstant.getScreenSizeWidth(context) * 0.1,
                  fit: BoxFit.fill,
                  color: AppColors.orBgr,
                ),
                const SizedBox(
                  width: 15,
                ),
                const Expanded(
                  flex: 6,
                  child: Text(
                    'Quá trình lương',
                    style: TextStyle(color: AppColors.orBgr, fontSize: 18),
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: Icon(Icons.arrow_forward_ios, color: AppColors.orBgr),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          thickness: 2,
          height: 1,
        ),
        Container(
          height: 60,
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: GestureDetector(
            onTap: () {
              Get.toNamed(ERouter.qtCongTac.name);
            },
            child: Row(
              children: [
                Image.asset(
                  AppResource.icWorking,
                  width: AppConstant.getScreenSizeWidth(context) * 0.1,
                  fit: BoxFit.fill,
                  color: AppColors.orBgr,
                ),
                const SizedBox(
                  width: 15,
                ),
                const Expanded(
                  flex: 6,
                  child: Text(
                    'Quá trình công tác',
                    style: TextStyle(color: AppColors.orBgr, fontSize: 18),
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: Icon(Icons.arrow_forward_ios, color: AppColors.orBgr),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          thickness: 2,
          height: 1,
        ),
        Container(
          height: 60,
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: GestureDetector(
            onTap: () {
              Get.toNamed(ERouter.ktkl.name);
            },
            child: Row(
              children: [
                Image.asset(
                  AppResource.icReward,
                  width: AppConstant.getScreenSizeWidth(context) * 0.1,
                  fit: BoxFit.fill,
                  color: AppColors.orBgr,
                ),
                const SizedBox(
                  width: 15,
                ),
                const Expanded(
                  flex: 6,
                  child: Text(
                    'Khen thưởng, kỷ luật',
                    style: TextStyle(color: AppColors.orBgr, fontSize: 18),
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: Icon(Icons.arrow_forward_ios, color: AppColors.orBgr),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
