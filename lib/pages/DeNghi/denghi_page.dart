import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/pages/DeNghi/denghi_controller.dart';
import 'package:salesoft_hrm/pages/DeNghi/denghi_item.dart';
import 'package:salesoft_hrm/pages/DeNghi/dialog_denghi_page.dart';
import 'package:salesoft_hrm/widgets/component/back_button_widget.dart';
import 'package:salesoft_hrm/widgets/component/title_appbar_widget.dart';
import 'package:salesoft_hrm/widgets/empty_data_widget.dart';

class DeNghiPage extends StatefulWidget {
  const DeNghiPage({super.key});

  @override
  _DeNghiPageState createState() => _DeNghiPageState();
}

class _DeNghiPageState extends State<DeNghiPage> {
  final controller = Get.put(DeNghiController());
  final TextEditingController _dateController = TextEditingController();
  String? _selectedMonth;
  String? _selectedYear;
  List<String> _months = [];
  List<String> _years = [];
  void _reloadData() {
    controller.fetchListContent();
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initializeMonthsAndYears();
    _setCurrentMonthAndYear();
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
    if (_selectedMonth != null && _selectedYear != null) {
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
    } else {
      print('Tháng hoặc năm chưa được chọn');
    }
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
            const Expanded(flex: 9, child: TitleAppBarWidget(title: "Đề nghị")),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DeNghiDialog(
                        dateController: _dateController,
                      );
                    },
                  );
                },
                child: const FaIcon(FontAwesomeIcons.circlePlus,
                    color: AppColors.blueVNPT),
              ),
            ),
          ],
        ),
      ),
      body: Container(
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
                          child: Text('Chờ duyệt'),
                        ),
                        const PopupMenuItem<String>(
                          value: '1',
                          child: Text('Đã duyệt'),
                        ),
                        const PopupMenuItem<String>(
                          value: '2',
                          child: Text('Không duyệt'),
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
              height: 15.h,
              child: const Divider(
                color: Colors.transparent,
              ),
            ),
            SizedBox(height: 10.h),
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
                        return DeNghiItemView(
                          noiDung: item?.noiDung ?? '',
                          ngay: item?.ngay ?? '',
                          tinhTrang: item?.tinhTrang,
                          thoiGian: item?.thoiGian ?? '',
                          soTien: item?.soTien,
                          lyDo: item?.lyDo,
                          tenTinhTrang: item?.tenTinhTrang ?? '',
                          tenNs: item?.tenNs ?? '',
                          tenDv: item?.tenDv ?? '',
                          tenPb: item?.tenPb ?? '',
                          id: item?.id,
                          ten: item?.ten ?? '',
                          onDismissed: (id) {},
                          onReload: () {
                            controller.fetchListContent();
                          },
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
            )
          ],
        ),
      ),
    );
  }
}
