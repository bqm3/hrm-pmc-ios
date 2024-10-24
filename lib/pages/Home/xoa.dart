import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/common/router.dart';
import 'package:salesoft_hrm/pages/ChamCong/chamcong_controller.dart';
import 'package:salesoft_hrm/pages/Home/drawer.dart';
import 'package:salesoft_hrm/pages/Home/home_animated.dart';
import '../../resources/app_resource.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isPressed = false;
  bool isLoading = false;

  Future<Position> getUserCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        _showPermissionDeniedDialog();
        return Future.error('Location permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  void _showPermissionDeniedDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Image.asset(
            AppResource.icWarning,
            height: 80.h,
            width: 80.w,
          ),
          content: Text(
            'Bạn cần cấp quyền truy cập vị trí để sử dụng tính năng này.',
            style: TextStyle(
              fontFamily: 'Arimo',
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: Text(
                'OK',
                style: TextStyle(
                  fontFamily: 'Arimo',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.blueVNPT),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    checkinController controller = Get.put(checkinController());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          top: true,
          bottom: false,
          left: false,
          right: false,
          child: Scaffold(
              backgroundColor: Colors.grey[50],
              drawer: MyDrawer(),
              body: Stack(children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: AppConstant.getScreenSizeHeight(context) * 0.07,
                        left: 20.w,
                        right: 20.w,
                      ),
                      child: Column(
                        children: [
                          Container(
                            width:
                                AppConstant.getScreenSizeWidth(context) * 0.96,
                            height: 115.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 13,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: Stack(
                                children: [
                                  GoogleMap(
                                    onMapCreated: (controller2) {
                                      controller.googleMapController1 =
                                          controller2;
                                    },
                                    initialCameraPosition: CameraPosition(
                                      target: controller.currentLocation != null
                                          ? LatLng(
                                              controller
                                                  .currentLocation!.latitude,
                                              controller
                                                  .currentLocation!.longitude,
                                            )
                                          : const LatLng(0, 0),
                                      zoom: 14,
                                    ),
                                    rotateGesturesEnabled: true,
                                    zoomControlsEnabled: false,
                                    tiltGesturesEnabled: true,
                                    myLocationEnabled: true,
                                    myLocationButtonEnabled: false,
                                    markers: Set<Marker>.of(controller.markers),
                                  ),
                                  Positioned(
                                    bottom: 16.h,
                                    right: 16.w,
                                    child: FloatingActionButton(
                                      onPressed: () {
                                        controller.getCurrentLocation2(1);
                                      },
                                      child: const Icon(
                                        Icons.my_location,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              setState(() {
                                isLoading = true;
                              });

                              await getUserCurrentLocation()
                                  .then((value) {
                                    Get.find<checkinController>()
                                        .getCurrentLocation();

                                    Get.toNamed(ERouter.chamCong.name);
                                  })
                                  .catchError((error) {})
                                  .whenComplete(() {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  });
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  AppResource.icChamCong,
                                  width: 50.w,
                                  height: 50.h,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  'Chấm công',
                                  style: TextStyle(
                                    fontFamily: 'Arimo',
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 24.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(ERouter.doica.name);
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  AppResource.icDoiCa,
                                  width: 50.w,
                                  height: 50.h,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  'Đổi ca',
                                  style: TextStyle(
                                    fontFamily: 'Arimo',
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 24.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(ERouter.denghi.name);
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  AppResource.icDeNghi,
                                  width: 50.w,
                                  height: 50.h,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  'Đề nghị',
                                  style: TextStyle(
                                    fontFamily: 'Arimo',
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 5,
                                        blurRadius: 13,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: AnimatedButton(
                                    onTap: () {
                                      Get.toNamed(ERouter.daotao.name);
                                    },
                                    width: 150.w,
                                    height: 125.h,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        Expanded(
                                            flex: 7,
                                            child: Image.asset(
                                              AppResource.icDaoTao,
                                              width: 66.w,
                                              height: 66.h,
                                            )),
                                        Expanded(
                                            flex: 3,
                                            child: Text(
                                              'Đào tạo',
                                              style: TextStyle(
                                                fontFamily: 'Arimo',
                                                color: AppColors.blueVNPT,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20.w),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 5,
                                        blurRadius: 13,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: AnimatedButton(
                                    onTap: () {
                                      Get.toNamed(ERouter.nghiPhep.name);
                                    },
                                    width: 150.w,
                                    height: 125.h,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        Expanded(
                                            flex: 7,
                                            child: Image.asset(
                                                AppResource.icNghiPhep)),
                                        Expanded(
                                            flex: 3,
                                            child: Text(
                                              'Đăng ký nghỉ',
                                              style: TextStyle(
                                                fontFamily: 'Arimo',
                                                color: AppColors.blueVNPT,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 5,
                                        blurRadius: 13,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: AnimatedButton(
                                    onTap: () {
                                      Get.toNamed(ERouter.bangluong.name);
                                    },
                                    width: 150.w,
                                    height: 125.h,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        Expanded(
                                            flex: 7,
                                            child: Image.asset(
                                                AppResource.icBangLuong)),
                                        Expanded(
                                            flex: 3,
                                            child: Text(
                                              'Bảng lương',
                                              style: TextStyle(
                                                fontFamily: 'Arimo',
                                                color: AppColors.blueVNPT,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 5,
                                        blurRadius: 13,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: AnimatedButton(
                                    onTap: () {
                                      Get.toNamed(ERouter.xetduyet.name);
                                    },
                                    width: 150.w,
                                    height: 125.h,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        Expanded(
                                            flex: 7,
                                            child: Image.asset(
                                                AppResource.icXetDuyet)),
                                        Expanded(
                                            flex: 3,
                                            child: Text(
                                              'Xét duyệt',
                                              style: TextStyle(
                                                fontFamily: 'Arimo',
                                                color: AppColors.blueVNPT,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
                if (isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: _buildLoadingIndicator(),
                    ),
                  ),
              ]))),
    );
  }
}
