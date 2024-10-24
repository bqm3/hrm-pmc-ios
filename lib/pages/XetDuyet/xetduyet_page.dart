import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/API/provider/danhmuc_provider.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/pages/XetDuyet/daduyet_controller.dart';
import 'package:salesoft_hrm/pages/XetDuyet/daduyet_item.dart';
import 'package:salesoft_hrm/pages/XetDuyet/xetduyet_controller.dart';
import 'package:salesoft_hrm/pages/XetDuyet/xetduyet_item.dart';
import 'package:salesoft_hrm/widgets/component/back_button_widget.dart';
import 'package:salesoft_hrm/widgets/component/title_appbar_widget.dart';
import 'package:salesoft_hrm/widgets/empty_data_widget.dart';

class XetDuyetPage extends StatefulWidget {
  const XetDuyetPage({super.key});

  @override
  State<XetDuyetPage> createState() => _XetDuyetPageState();
}

class _XetDuyetPageState extends State<XetDuyetPage> {
  final controller = Get.put(XetDuyetController());
  final controller2 = Get.put(DaDuyetController());
  String? selectedMa;
  List<dynamic> xetDuyetList = [];
  final RefreshController _refreshController1 = RefreshController();
  final RefreshController _refreshController2 = RefreshController();
  DateTime? selectedDate;
  DateTime? selectedDateHistory;

  void _reloadData() {
    controller.fetchListContent();
  }

  void _reloadData2() {
    controller2.fetchListContent();
  }

  @override
  void dispose() {
    _refreshController1.dispose();
    _refreshController2.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fetchXetDuyetData();
  }

  Future<void> _fetchXetDuyetData() async {
    try {
      final danhMucProviderAPI = DanhMucProviderAPI();

      final result = await danhMucProviderAPI.getDanhMuc(
        table: 'DM_XetDuyet',
        parent: '0',
        group: '',
      );

      setState(() {
        xetDuyetList = result ?? [];

        xetDuyetList.insert(0, {'ma': '', 'ten': 'Toàn bộ'});
      });
    } catch (error) {
      setState(() {});
      print('Lỗi khi lấy dữ liệu xét duyệt: $error');
    }
  }

  void _filterContentByDate() {
    if (selectedDate != null) {
      final filteredList = controller.originalContentDisplay.where((item) {
        final itemDate = DateTime.parse(item.ngay ?? '');
        return itemDate.year == selectedDate!.year &&
            itemDate.month == selectedDate!.month &&
            itemDate.day == selectedDate!.day;
      }).toList();

      controller.contentDisplay.assignAll(filteredList);
    } else {
      controller.contentDisplay.assignAll(controller.originalContentDisplay);
    }
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked == null) {
      setState(() {
        selectedDate = null;
        _filterContentByDate();
      });
    } else if (picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _filterContentByDate();
      });
    }
  }

  void _selectDateForHistory(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateHistory ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked == null) {
      setState(() {
        selectedDateHistory = null;
      });
    } else if (picked != selectedDateHistory) {
      setState(() {
        selectedDateHistory = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButtonWidget(),
          backgroundColor: AppColors.blue50,
          centerTitle: false,
          elevation: 0,
          title: const TitleAppBarWidget(title: "Xét duyệt"),
          bottom: const TabBar(
            indicatorColor: AppColors.blueVNPT,
            labelColor: AppColors.blueVNPT,
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(text: "Xét duyệt"),
              Tab(text: "Lịch sử duyệt"),
            ],
          ),
        ),
        body: Container(
          color: Colors.white,
          child: TabBarView(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.0.r, right: 10.0.r),
                  ),
                  Container(
                    color: Colors.grey[200],
                    height: 0,
                    child: const Divider(
                      color: Colors.transparent,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Expanded(
                        flex: 45,
                        child: GestureDetector(
                          onTap: () => _selectDate(context),
                          child: Container(
                            height: 30.h,
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 30.w,
                                ),
                                Text(
                                  selectedDate != null
                                      ? "Ngày: ${DateFormat('dd/MM/yyyy').format(selectedDate!)}"
                                      : "Chọn ngày",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: 50.w),
                                Icon(
                                  Icons.calendar_today,
                                  size: 16.sp,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        flex: 15,
                        child: PopupMenuButton<String>(
                          icon: const Icon(Icons.filter_list),
                          onSelected: (value) {
                            setState(() {
                              selectedMa = value;
                              controller.loai = value;
                              controller.fetchListContent();
                            });
                          },
                          itemBuilder: (context) {
                            return xetDuyetList
                                .map<PopupMenuEntry<String>>((item) {
                              return PopupMenuItem<String>(
                                value: item['ma'],
                                child: Text(item['ten']),
                              );
                            }).toList();
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.grey[200],
                    height: 3.h,
                    child: const Divider(
                      color: Colors.transparent,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Expanded(
                    child: controller.obx(
                      (contentDisplay) {
                        return SmartRefresher(
                          controller: _refreshController1,
                          enablePullDown: true,
                          enablePullUp: false,
                          onRefresh: () async {
                            controller.fetchListContent();
                            _refreshController1.refreshCompleted();
                          },
                          onLoading: () async {
                            controller.fetchListContent(isLoadMore: true);
                            _refreshController1.loadComplete();
                          },
                          child: ListView.builder(
                            itemCount: contentDisplay?.length ?? 0,
                            itemBuilder: (context, index) {
                              final item = contentDisplay?[index];
                              return XetDuyetItemView(
                                loai: item?.loai ?? '',
                                noiDung: item?.noiDung ?? '',
                                tinhTrang: item?.tinhTrang,
                                ngay: item?.ngay ?? '',
                                dieuKien: item?.dieuKien ?? '',
                                capDuyet: item?.capDuyet ?? '',
                                id: item?.id,
                              );
                            },
                          ),
                        );
                      },
                      onEmpty: EmptyDataWidget(
                        onReloadData: _reloadData,
                      ),
                      onError: (error) =>
                          Center(child: Text('Có lỗi xảy ra: $error')),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    color: Colors.grey[200],
                    height: 0,
                    child: const Divider(
                      color: Colors.transparent,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Expanded(
                    child: controller2.obx(
                      (contentApproved) {
                        return SmartRefresher(
                          controller: _refreshController2,
                          enablePullDown: true,
                          enablePullUp: false,
                          onRefresh: () async {
                            controller2.fetchListContent();
                            _refreshController2.refreshCompleted();
                          },
                          onLoading: () async {
                            controller2.fetchListContent(isLoadMore: true);
                            _refreshController2.loadComplete();
                          },
                          child: ListView.builder(
                            itemCount: contentApproved?.length ?? 0,
                            itemBuilder: (context, index) {
                              final item = contentApproved?[index];
                              return DaDuyetItemView(
                                loai: item?.loai ?? '',
                                noiDung: item?.noiDung ?? '',
                                tinhTrang: item?.tinhTrang,
                                ngay: item?.ngay ?? '',
                                dieuKien: item?.dieuKien ?? '',
                                capDuyet: item?.capDuyet ?? '',
                                nguoiDuyet: item?.nguoiDuyet ?? '',
                                id: item?.id,
                              );
                            },
                          ),
                        );
                      },
                      onEmpty: EmptyDataWidget(
                        onReloadData: _reloadData2,
                      ),
                      onError: (error) =>
                          Center(child: Text('Có lỗi xảy ra: $error')),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
