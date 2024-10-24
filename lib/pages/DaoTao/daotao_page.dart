import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/API/provider/loaidaotao_provider.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/model/daotao_model.dart';
import 'package:salesoft_hrm/pages/DaoTao/daotao_controller.dart';
import 'package:salesoft_hrm/pages/DaoTao/daotao_item.dart';
import 'package:salesoft_hrm/pages/DaoTao/lichdaotao_controller.dart';
import 'package:salesoft_hrm/pages/DaoTao/lichdaotao_item.dart';
import 'package:salesoft_hrm/widgets/component/back_button_widget.dart';
import 'package:salesoft_hrm/widgets/component/title_appbar_widget.dart';
import 'package:salesoft_hrm/widgets/dialog_thanhcong.dart';
import 'package:salesoft_hrm/widgets/dialog_thatbai.dart';
import 'package:salesoft_hrm/widgets/empty_data_widget.dart';

class DaoTaoPage extends StatefulWidget {
  const DaoTaoPage({super.key});

  @override
  _DaoTaoPageState createState() => _DaoTaoPageState();
}

class _DaoTaoPageState extends State<DaoTaoPage>
    with SingleTickerProviderStateMixin {
  final controller = Get.put(DaoTaoController());
  late TabController _tabController;
  final controller2 = Get.put(LichDaoTaoController());

  String? _selectedMonth;
  String? _selectedYear;
  List<String> _months = [];
  List<String> _years = [];
  void _reloadData() {
    controller.fetchListContent();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _initializeMonthsAndYears();
    _setCurrentMonthAndYear();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _initializeMonthsAndYears() {
    _months = List.generate(12, (index) {
      final month = DateTime(0, index + 1).toLocal();
      return '${month.month.toString().padLeft(2, '0')}';
    });
    _years = List.generate(11, (index) => (2020 + index).toString());
  }

  void _setCurrentMonthAndYear() {
    final now = DateTime.now();
    _selectedMonth = now.month.toString().padLeft(2, '0');
    _selectedYear = now.year.toString();
    _search();
  }

  void _search() {
    controller.thang = _selectedMonth ?? '';
    controller.nam = _selectedYear ?? '';
    controller.fetchListContent();
  }

  void _previousMonth() {
    setState(() {
      final currentMonth = int.parse(_selectedMonth!);
      final currentYear = int.parse(_selectedYear!);

      if (currentMonth == 1) {
        _selectedMonth = '12';
        _selectedYear = (currentYear - 1).toString();
      } else {
        _selectedMonth = (currentMonth - 1).toString().padLeft(2, '0');
      }
      _search();
    });
  }

  void _nextMonth() {
    setState(() {
      final currentMonth = int.parse(_selectedMonth!);
      final currentYear = int.parse(_selectedYear!);

      if (currentMonth == 12) {
        _selectedMonth = '01';
        _selectedYear = (currentYear + 1).toString();
      } else {
        _selectedMonth = (currentMonth + 1).toString().padLeft(2, '0');
      }
      _search();
    });
  }

  void _showMonthYearPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 190.h,
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: CupertinoPicker(
                        itemExtent: 32,
                        scrollController: FixedExtentScrollController(
                          initialItem: _months.indexOf(_selectedMonth!),
                        ),
                        onSelectedItemChanged: (index) {
                          setState(() {
                            _selectedMonth = _months[index];
                          });
                        },
                        children: _months.map((month) {
                          return Center(
                            child: Text(
                              month,
                              style: TextStyle(fontSize: 20.sp),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Expanded(
                      child: CupertinoPicker(
                        itemExtent: 32,
                        scrollController: FixedExtentScrollController(
                          initialItem: _years.indexOf(_selectedYear!),
                        ),
                        onSelectedItemChanged: (index) {
                          setState(() {
                            _selectedYear = _years[index];
                          });
                        },
                        children: _years.map((year) {
                          return Center(
                            child: Text(
                              year,
                              style: TextStyle(fontSize: 20.sp),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              CupertinoButton(
                child: const Text('Xác nhận'),
                onPressed: () {
                  Navigator.pop(context);
                  _search();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCustomDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonWidget(),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        title: Row(
          children: [
            const Expanded(flex: 9, child: TitleAppBarWidget(title: "Đào tạo")),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: _showCustomDialog,
                child: const FaIcon(FontAwesomeIcons.circlePlus,
                    color: AppColors.blueVNPT),
              ),
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Lớp đào tạo'),
            Tab(text: 'Lịch học'),
          ],
          indicatorColor: AppColors.blueVNPT,
          labelColor: Colors.black,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTabContent1(),
          _buildTabContent2(),
        ],
      ),
    );
  }

  Widget _buildTabContent1() {
    return Container(
        color: Colors.white,
        child: Column(
          children: [
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
                  flex: 20,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: _previousMonth,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: _showMonthYearPicker,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$_selectedMonth-$_selectedYear',
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 5),
                        FaIcon(FontAwesomeIcons.calendarDays,
                            color: Colors.blue, size: 16.sp),
                      ]),
                ),
                const Spacer(),
                Expanded(
                  flex: 20,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: _nextMonth,
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 15,
                  child: PopupMenuButton<String>(
                    icon: Icon(Icons.filter_list),
                    onSelected: (String value) {
                      controller.onFilterChanged(value);
                      controller.fetchListContent();
                    },
                    itemBuilder: (BuildContext context) {
                      return <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: '',
                          child: Text('Toàn bộ'),
                        ),
                        const PopupMenuItem<String>(
                          value: '0',
                          child: Text('Chưa hoàn thành'),
                        ),
                        const PopupMenuItem<String>(
                          value: '1',
                          child: Text('Đã hoàn thành'),
                        ),
                        const PopupMenuItem<String>(
                          value: '2',
                          child: Text('Không hoàn thành'),
                        ),
                      ];
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Container(
              color: Colors.grey[200],
              height: 13.h,
              child: const Divider(
                color: Colors.transparent,
              ),
            ),
            Expanded(
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
                      itemCount: contentDisplay?.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        final item = contentDisplay?.data?[index];
                        return DaoTaoItemView(
                          lopDt: item?.lopDt ?? '',
                          ngay: item?.ngay ?? '',
                          tinhTrang: item?.tinhTrang,
                          thoiGian: item?.thoiGian ?? '',
                          moTa: item?.moTa,
                          taiLieu: item?.taiLieu,
                          mact: item?.mact ?? '',
                          tenct: item?.tenct ?? '',
                          madv: item?.madv ?? '',
                          tendv: item?.tendv ?? '',
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
        ));
  }

  Widget _buildTabContent2() {
    return Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 5.h),
            Expanded(
              child: controller2.obx(
                (contentDisplay) {
                  return SmartRefresher(
                    controller: controller2.refreshController,
                    enablePullDown: true,
                    enablePullUp: false,
                    onRefresh: () async {
                      controller2.fetchListContent();
                      controller2.refreshController.refreshCompleted();
                    },
                    onLoading: () async {
                      controller2.fetchListContent(isLoadMore: true);
                      controller2.refreshController.loadComplete();
                    },
                    child: ListView.builder(
                      itemCount: contentDisplay?.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        final item = contentDisplay?.data?[index];
                        return LichDaoTaoItemView(
                          // lopDt: item?.lopDt ?? '',
                          // ngay: item?.ngay ?? '',
                          ten: item?.tenLopDt ?? '',
                          tinhTrang: item?.tinhTrang,
                          ngay: item?.ngay ?? '',
                          id: item?.id,
                          tenpb: item?.tenPb ?? '',
                          tendv: item?.tenDv ?? '',
                          tennd: item?.tenNoiDung ?? '',
                          // thoiGian: item?.thoiGian ?? '',
                          // moTa: item?.moTa,
                          // taiLieu: item?.taiLieu,
                          // mact: item?.mact ?? '',
                          // tenct: item?.tenct ?? '',
                          // madv: item?.madv ?? '',
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
        ));
  }
}

class CustomDialog extends StatefulWidget {
  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  LoaiDaoTao? _selectedClass;
  List<LoaiDaoTao> _classList = [];

  @override
  void initState() {
    super.initState();
    _fetchClassList();
  }

  Future<void> _fetchClassList() async {
    var response = await LoaiDaoTaoProvider().getList();
    setState(() {
      _classList = response.data ?? [];
      if (_classList.isNotEmpty) {
        _selectedClass = _classList.first;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chọn lớp đào tạo',
              style: TextStyle(
                fontFamily: 'Arimo',
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6.h),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 1.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.5),
                borderRadius: BorderRadius.circular(10.0.r),
                color: Colors.white,
              ),
              child: DropdownButton<LoaiDaoTao>(
                value: _selectedClass,
                isExpanded: true,
                underline: Container(),
                onChanged: (LoaiDaoTao? newValue) {
                  setState(() {
                    _selectedClass = newValue;
                  });
                },
                items: _classList
                    .map<DropdownMenuItem<LoaiDaoTao>>((LoaiDaoTao value) {
                  return DropdownMenuItem<LoaiDaoTao>(
                    value: value,
                    child: Text(value.ten ?? ''),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 0.7),
                      borderRadius: BorderRadius.circular(10.0.r),
                    ),
                    child: CupertinoButton(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0.r),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Quay lại',
                        style: TextStyle(
                          fontFamily: 'Arimo',
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 4,
                  child: CupertinoButton(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    color: AppColors.blueVNPT,
                    borderRadius: BorderRadius.circular(10.0),
                    onPressed: () async {
                      if (_selectedClass != null) {
                        String ma = await AuthService().ma ?? '';
                        final lopDT = _selectedClass!.ma;

                        Future<void> message = Get.find<DaoTaoController>()
                            .registerTrainingClass(ma, lopDT!);

                        if (message != null) {
                          Get.dialog(
                            thongBaoDialog(text: message as String),
                          );
                        }
                      } else {
                        Get.dialog(
                          thongBaoDialog2(text: 'Vui lòng chọn lớp đào tạo'),
                        );
                      }
                      Get.find<DaoTaoController>().fetchListContent();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Xác nhận',
                      style: TextStyle(
                        fontFamily: 'Arimo',
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
