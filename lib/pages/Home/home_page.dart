import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salesoft_hrm/API/provider/regsystem_provider.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/common/router.dart';
import 'package:salesoft_hrm/pages/ChamCong/chamcong_controller.dart';
import 'package:salesoft_hrm/pages/Home/home_animated.dart';
import 'package:salesoft_hrm/widgets/dialog_thatbai.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../resources/app_resource.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isPressed = false;
  bool isLoading = false;
  final IRegsystemProvider regsystemProvider = RegsystemProviderAPI();

  Future<void> _openEmployeeHandbook(String code) async {
    try {
      final response = await regsystemProvider.getRegsystem(code: code);

      if (response != null && response['value'] != null) {
        final url = response['value'].trim();

        if (url.isEmpty) {
          Get.dialog(
            thongBaoDialog2(
              text: 'URL không xác định',
            ),
          );
          return;
        }
        if (await canLaunch(url)) {
          await launch(url);

          // Future.delayed(Duration(seconds: 1), () {
          //   SystemNavigator.pop();
          // }
          // );
        } else {
          Get.dialog(
            thongBaoDialog2(
              text: 'URL không xác định',
            ),
          );
          throw 'Could not launch $url';
        }
      }
    } catch (e) {
      print("Error: $e");
    }
  }

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
            top: false,
            bottom: false,
            left: false,
            right: false,
            child: Scaffold(
              body: Stack(
                // Sử dụng Stack để chồng các widget
                children: [
                  Column(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(AppResource.icAnhNen),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                  Color.fromARGB(204, 28, 66, 251),
                                  BlendMode.darken,
                                )),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50.h,
                              ),
                              Container(
                                width: AppConstant.getScreenSizeWidth(context) *
                                    0.9,
                                height: 150.h,
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
                                          target:
                                              controller.currentLocation != null
                                                  ? LatLng(
                                                      controller
                                                          .currentLocation!
                                                          .latitude,
                                                      controller
                                                          .currentLocation!
                                                          .longitude,
                                                    )
                                                  : const LatLng(0, 0),
                                          zoom: 14,
                                        ),
                                        rotateGesturesEnabled: true,
                                        zoomControlsEnabled: false,
                                        tiltGesturesEnabled: true,
                                        myLocationEnabled: true,
                                        myLocationButtonEnabled: false,
                                        markers:
                                            Set<Marker>.of(controller.markers),
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
                      ),
                      Expanded(
                        flex: 6,
                        child: Container(
                          color: Colors.grey[100],
                          child: Column(
                            children: [
                              SizedBox(
                                height: 40.h,
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.0.r),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                spreadRadius: 5,
                                                blurRadius: 13,
                                                offset: const Offset(0, 1),
                                              ),
                                            ],
                                          ),
                                          child: AnimatedButton(
                                            onTap: () {
                                              Get.toNamed(
                                                  ERouter.xetduyet.name);
                                            },
                                            width: 150.w,
                                            height: 125.h,
                                            color: Colors.white,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                    flex: 7,
                                                    child: Image.asset(
                                                        AppResource.xetduyet)),
                                                Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      'Xét duyệt',
                                                      style: TextStyle(
                                                        fontFamily: 'Arimo',
                                                        color: Colors.black,
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        )),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.0.r),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
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
                                                        AppResource.daotao)),
                                                Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      'Đào tạo',
                                                      style: TextStyle(
                                                        fontFamily: 'Arimo',
                                                        color: Colors.black,
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        )),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.0.r),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                spreadRadius: 5,
                                                blurRadius: 13,
                                                offset: const Offset(0, 1),
                                              ),
                                            ],
                                          ),
                                          child: AnimatedButton(
                                            onTap: () {
                                              Get.toNamed(
                                                  ERouter.bangluong.name);
                                            },
                                            width: 150.w,
                                            height: 125.h,
                                            color: Colors.white,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                    flex: 7,
                                                    child: Image.asset(
                                                        AppResource.bangluong)),
                                                Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      'Bảng lương',
                                                      style: TextStyle(
                                                        fontFamily: 'Arimo',
                                                        color: Colors.black,
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        )),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.0.r),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                spreadRadius: 5,
                                                blurRadius: 13,
                                                offset: const Offset(0, 1),
                                              ),
                                            ],
                                          ),
                                          child: AnimatedButton(
                                            onTap: () {
                                              _openEmployeeHandbook(
                                                  'LinkSoTayNhanVien');
                                            },
                                            width: 150.w,
                                            height: 125.h,
                                            color: Colors.white,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                    flex: 7,
                                                    child: Image.asset(
                                                        AppResource
                                                            .sotaynhanvien)),
                                                Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      'Sổ tay nhân viên',
                                                      style: TextStyle(
                                                        fontFamily: 'Arimo',
                                                        color: Colors.black,
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        )),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.0.r),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                spreadRadius: 5,
                                                blurRadius: 13,
                                                offset: const Offset(0, 1),
                                              ),
                                            ],
                                          ),
                                          child: AnimatedButton(
                                            onTap: () {
                                              _openEmployeeHandbook(
                                                  'LinkSoTayChinhSach');
                                            },
                                            width: 150.w,
                                            height: 125.h,
                                            color: Colors.white,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                    flex: 7,
                                                    child: Image.asset(
                                                        AppResource
                                                            .chinhsachnhansu)),
                                                Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      'Chính sách nhân sự',
                                                      style: TextStyle(
                                                        fontFamily: 'Arimo',
                                                        color: Colors.black,
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        )),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.0.r),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                spreadRadius: 5,
                                                blurRadius: 13,
                                                offset: const Offset(0, 1),
                                              ),
                                            ],
                                          ),
                                          child: AnimatedButton(
                                            onTap: () {
                                              _openEmployeeHandbook(
                                                  'LinkDaoDucNgheNghiep');
                                            },
                                            width: 150.w,
                                            height: 125.h,
                                            color: Colors.white,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                    flex: 7,
                                                    child: Image.asset(
                                                        AppResource
                                                            .daoducnghenghiep)),
                                                Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      'Đạo đức nghề nghiệp',
                                                      style: TextStyle(
                                                        fontFamily: 'Arimo',
                                                        color: Colors.black,
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        )),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.0.r),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                spreadRadius: 5,
                                                blurRadius: 13,
                                                offset: const Offset(0, 1),
                                              ),
                                            ],
                                          ),
                                          child: AnimatedButton(
                                            onTap: () {
                                              _openEmployeeHandbook(
                                                  'LinkWorkSafe');
                                            },
                                            width: 150.w,
                                            height: 125.h,
                                            color: Colors.white,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                    flex: 7,
                                                    child: Image.asset(
                                                        AppResource
                                                            .antoanlaodong)),
                                                Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      'An toàn lao động',
                                                      style: TextStyle(
                                                        fontFamily: 'Arimo',
                                                        color: Colors.black,
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        )),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.0.r),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                spreadRadius: 5,
                                                blurRadius: 13,
                                                offset: const Offset(0, 1),
                                              ),
                                            ],
                                          ),
                                          child: AnimatedButton(
                                            onTap: () {
                                              _openEmployeeHandbook('LinkOSHE');
                                            },
                                            width: 150.w,
                                            height: 125.h,
                                            color: Colors.white,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                    flex: 7,
                                                    child: Image.asset(
                                                        AppResource.oshe)),
                                                Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      'OSHE',
                                                      style: TextStyle(
                                                        fontFamily: 'Arimo',
                                                        color: Colors.black,
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        )),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.0.r),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                spreadRadius: 5,
                                                blurRadius: 13,
                                                offset: const Offset(0, 1),
                                              ),
                                            ],
                                          ),
                                          child: AnimatedButton(
                                            onTap: () {
                                              _openEmployeeHandbook(
                                                  'LinkCamNang');
                                            },
                                            width: 150.w,
                                            height: 125.h,
                                            color: Colors.white,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                    flex: 7,
                                                    child: Image.asset(
                                                        AppResource.camnang)),
                                                Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      'Cẩm nang',
                                                      style: TextStyle(
                                                        fontFamily: 'Arimo',
                                                        color: Colors.black,
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        )),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    top: 230.h,
                    left: 16.w,
                    right: 16.w,
                    child: Container(
                      height: 80.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: AnimatedButton(
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
                              width: 150.w,
                              height: 125.h,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Expanded(
                                      flex: 7,
                                      child: Image.asset(
                                        AppResource.chamcong,
                                        width: 66.w,
                                        height: 66.h,
                                      )),
                                  Expanded(
                                      flex: 3,
                                      child: Text(
                                        'Chấm công',
                                        style: TextStyle(
                                          fontFamily: 'Arimo',
                                          color: Colors.black,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 1.w,
                            height: 30.h,
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          Expanded(
                            flex: 1,
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
                                        AppResource.dangkynghi,
                                        width: 66.w,
                                        height: 66.h,
                                      )),
                                  Expanded(
                                      flex: 3,
                                      child: Text(
                                        'Đăng ký nghỉ',
                                        style: TextStyle(
                                          fontFamily: 'Arimo',
                                          color: Colors.black,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 1.w,
                            height: 30.h,
                            color: Colors.grey.withOpacity(0.2),
                          ),
                          Expanded(
                            flex: 1,
                            child: AnimatedButton(
                              onTap: () {
                                Get.toNamed(ERouter.doica.name);
                              },
                              width: 150.w,
                              height: 125.h,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Expanded(
                                      flex: 7,
                                      child: Image.asset(
                                        AppResource.doica,
                                        width: 66.w,
                                        height: 66.h,
                                      )),
                                  Expanded(
                                      flex: 3,
                                      child: Text(
                                        'Đổi ca',
                                        style: TextStyle(
                                          fontFamily: 'Arimo',
                                          color: Colors.black,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 1.w,
                            height: 30.h,
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          Expanded(
                            flex: 1,
                            child: AnimatedButton(
                              onTap: () {
                                Get.toNamed(ERouter.denghi.name);
                              },
                              width: 150.w,
                              height: 125.h,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Expanded(
                                      flex: 7,
                                      child: Image.asset(
                                        AppResource.dangkynghi,
                                        width: 66.w,
                                        height: 66.h,
                                      )),
                                  Expanded(
                                      flex: 3,
                                      child: Text(
                                        'Đề nghị',
                                        style: TextStyle(
                                          fontFamily: 'Arimo',
                                          color: Colors.black,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
