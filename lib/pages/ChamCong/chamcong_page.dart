import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/pages/ChamCong/chamcong_controller.dart';
import 'package:salesoft_hrm/pages/ChamCong/list_chamcong_controller.dart';
import 'package:salesoft_hrm/pages/ChamCong/list_chamcong_item.dart';
import 'package:salesoft_hrm/widgets/component/back_button_widget.dart';
import 'package:salesoft_hrm/widgets/component/title_appbar_widget.dart';
import 'package:salesoft_hrm/widgets/empty_data_widget.dart';

Tab buildTab(BuildContext context, String text) {
  return Tab(
    child: Text(
      text,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontFamily: 'Arimo',
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
    ),
  );
}

class ChamCongPage extends StatefulWidget {
  const ChamCongPage({Key? key}) : super(key: key);

  @override
  _ChamCongPageState createState() => _ChamCongPageState();
}

class _ChamCongPageState extends State<ChamCongPage> {
  final checkinController controller = Get.put(checkinController());
  bool isButtonEnabled = true;

  @override
  void initState() {
    super.initState();
    controller.distanceController.text = "100";
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      controller.updateMarkers();
    });
  }

  void _disableButtonForDuration() {
    setState(() {
      isButtonEnabled = false;
    });

    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        isButtonEnabled = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<checkinController>(
      builder: (controller) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: const BackButtonWidget(),
              centerTitle: false,
              elevation: 0,
              title: const TitleAppBarWidget(
                title: "Chấm công",
              ),
              bottom: const TabBar(
                indicatorColor: AppColors.blueVNPT,
                labelColor: AppColors.blueVNPT,
                unselectedLabelColor: Colors.black,
                tabs: const [
                  Tab(text: "Chấm công"),
                  Tab(text: "Lịch sử chấm công"),
                ],
              ),
            ),
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildChamCongTab(context),
                _buildLichSuChamCongTab(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildChamCongTab(BuildContext context) {
    return GetBuilder<checkinController>(
      builder: (controller) {
        return Scaffold(
          body: Stack(
            children: [
              controller.currentLocation == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: GoogleMap(
                            onMapCreated: (controller2) {
                              controller.googleMapController1 = controller2;
                            },
                            initialCameraPosition: CameraPosition(
                              target: controller.currentLocation != null
                                  ? LatLng(
                                      controller.currentLocation!.latitude,
                                      controller.currentLocation!.longitude,
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
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 30.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.0.w, right: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Chấm công',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Arimo',
                                      fontSize: 18.sp,
                                    ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                'Địa điểm làm việc:',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Arimo',
                                  fontSize: 12.sp,
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  _showBottomSheet(
                                      context, controller.offices, controller);
                                },
                                child: controller.selectedOffice != null
                                    ? Text(
                                        controller.selectedOffice!.name,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Arimo',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12.sp,
                                        ),
                                      )
                                    : Text(
                                        ' ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Arimo',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                              ),
                              const Divider(
                                color: Colors.grey,
                                thickness: 0.5,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: controller.ca.isEmpty
                                ? Center(
                                    child: Text(
                                      'Chưa được phân ca làm việc',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Arimo',
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: controller.ca.length,
                                    itemBuilder: (context, index) {
                                      final shift = controller.ca[index];
                                      return Card(
                                        color: AppColors.blueVNPT2,
                                        child: ListTile(
                                          leading: Checkbox(
                                            value: controller.selectedShift ==
                                                '${shift.ten} (${shift.gioVao} - ${shift.gioRa})',
                                            onChanged: (bool? value) {
                                              if (value == true) {
                                                controller.selectedShift =
                                                    '${shift.ten} (${shift.gioVao} - ${shift.gioRa})';
                                                controller.selectedShiftMa =
                                                    shift.ma!;
                                                controller.update();
                                              } else {}
                                            },
                                            activeColor: AppColors.blueVNPT,
                                            checkColor: Colors.white,
                                          ),
                                          title: Text(
                                            shift.ten!,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Arimo',
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                          subtitle: Text(
                                            '${shift.gioVao} - ${shift.gioRa}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Arimo',
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ),
                        Container(
                          width: AppConstant.getScreenSizeHeight(context) * 0.8,
                          padding: EdgeInsets.only(
                            bottom: 40.h,
                            left:
                                AppConstant.getScreenSizeWidth(context) * 0.03,
                            right:
                                AppConstant.getScreenSizeWidth(context) * 0.03,
                          ),
                          child: CupertinoButton(
                            color: AppColors.blueVNPT,
                            onPressed: isButtonEnabled
                                ? () async {
                                    controller.checkIn();
                                    _disableButtonForDuration();
                                  }
                                : null,
                            child: Text(
                              controller.btnChamCongText,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Arimo',
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height / 2 + 16.0.h,
                right: 16.0.w,
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
        );
      },
    );
  }

  Widget _buildLichSuChamCongTab(BuildContext context) {
    final ListChamCongController controller = Get.put(ListChamCongController());
    void _reloadData() {
      controller.fetchListContent();
    }

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8.0),
      child: controller.obx(
        (contentDisplay) {
          return SmartRefresher(
            controller: controller.refreshController,
            enablePullDown: true,
            enablePullUp: false,
            onRefresh: () async {
              controller.fetchListContent();
              controller.refreshController.refreshCompleted();
            },
            onLoading: () async {
              controller.fetchListContent(isLoadMore: true);
              controller.refreshController.loadComplete();
            },
            child: ListView.builder(
              itemCount: contentDisplay?.items.length ?? 0,
              itemBuilder: (context, index) {
                final item = contentDisplay?.items[index];
                return ListChamCongItemView(
                  caLamViec: item?.caLamViec ?? '',
                  diaDiem: item?.diaDiem ?? '',
                  checkIn: item?.checkIn ?? false,
                  thoiGian: item?.thoiGian ?? '',
                  lyDo: item?.lyDo ?? '',
                  id: item?.id,
                );
              },
            ),
          );
        },
        onEmpty: EmptyDataWidget(
          onReloadData: _reloadData,
        ),
        onError: (error) => Center(child: Text('Có lỗi xảy ra: $error')),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, List<Location> offices,
      checkinController controller) {
    Future.delayed(Duration.zero, () {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 200.h,
                child: ListView.builder(
                  itemCount: offices.length,
                  itemBuilder: (context, index) {
                    Location office = offices[index];
                    return ListTile(
                      title: Text(office.name),
                      onTap: () {
                        setState(() {
                          controller.toggleSelectedOffice(office.name);
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      );
    });
  }
}
