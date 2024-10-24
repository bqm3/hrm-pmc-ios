import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/format_date.dart';
import 'package:salesoft_hrm/pages/BangLuong/bangluong_controller.dart';
import 'package:salesoft_hrm/widgets/component/back_button_widget.dart';
import 'package:salesoft_hrm/widgets/component/title_appbar_widget.dart';
import 'package:salesoft_hrm/widgets/empty_data_widget.dart';
import 'package:intl/intl.dart';

class BangLuongPage extends StatefulWidget {
  const BangLuongPage({super.key});

  @override
  _BangLuongPageState createState() => _BangLuongPageState();
}

class _BangLuongPageState extends State<BangLuongPage> {
  final controller = Get.put(BangLuongController());
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
    _initializeMonthsAndYears();
    _setCurrentMonthAndYear();
  }

  void _initializeMonthsAndYears() {
    _months = List.generate(12, (index) {
      final month = DateTime(0, index + 1).toLocal();
      return month.month.toString().padLeft(2, '0');
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
                              style: const TextStyle(fontSize: 20),
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
                              style: const TextStyle(fontSize: 20),
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
        backgroundColor: AppColors.blue50,
        centerTitle: false,
        elevation: 0,
        title: const TitleAppBarWidget(title: "Bảng Lương"),
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
            SizedBox(height: 3.h),
            Row(
              children: [
                Expanded(
                  flex: 25,
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
                  flex: 25,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: _nextMonth,
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),
            Container(
              color: Colors.grey[200],
              height: 12.h,
              child: const Divider(
                color: Colors.transparent,
              ),
            ),
            Expanded(
              child: controller.obx(
                (contentDisplay) {
                  return ListView.builder(
                    itemCount: controller.contentDisplay?.length ?? 0,
                    itemBuilder: (context, index) {
                      final bangLuong = controller.contentDisplay![index];
                      return Column(
                        children: [
                          SizedBox(height: 8.h),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CongDM(
                                      text1: 'Tổng công',
                                      text2: bangLuong.tongCong ?? '',
                                    ),
                                    BangLuongRow(
                                      text1: 'Tổng lương',
                                      text2: bangLuong.tongLuong ?? '',
                                    ),
                                    BangLuongRow(
                                      text1: 'BHXH',
                                      text2: bangLuong.tongBhNhanSu ?? '',
                                    ),
                                    BangLuongRow(
                                      text1: 'Phí công đoàn',
                                      text2: bangLuong.tienCongDoanNs ?? '',
                                    ),
                                    BangLuongRow(
                                      text1: 'Thuế thu nhập cá nhân',
                                      text2: bangLuong.thueThuNhap ?? '',
                                    ),
                                    BangLuongRow(
                                      text1: 'Điều chỉnh giảm',
                                      text2: bangLuong.dcGiam ?? '',
                                    ),
                                    BangLuongRow(
                                      text1: 'Điều chỉnh tăng',
                                      text2: bangLuong.dcTang ?? '',
                                    ),
                                    BangLuongRow(
                                      text1: 'Thưởng ',
                                      text2: bangLuong.tienNsld ?? '',
                                    ),
                                    const Divider(
                                      color: Color.fromARGB(255, 214, 214, 214),
                                      height: 1,
                                    ),
                                    BangLuongRow(
                                      text1: 'Thực lĩnh',
                                      text2: bangLuong.thucLinh ?? '',
                                    ),
                                  ])),
                          SizedBox(height: 3.h),
                          Container(
                            color: Colors.grey[200],
                            height: 13.h,
                            child: const Divider(
                              color: Colors.transparent,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Bảng lương mới',
                                      style: TextStyle(
                                        color: AppColors.blueVNPT,
                                        fontFamily: 'Arimo',
                                        fontSize: 18.sp,
                                        height: 1.4,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 3.h),
                                    const Divider(
                                      color: Color.fromARGB(255, 214, 214, 214),
                                      height: 1,
                                    ),
                                    SizedBox(height: 10.h),
                                    BangLuongRow(
                                      text1: 'Mức lương',
                                      text2: bangLuong.mucLuong2 ?? '',
                                    ),
                                    CongDM(
                                      text1: 'Ngày công',
                                      text2: bangLuong.ngayCong2 ?? '',
                                    ),
                                    BangLuongRow(
                                      text1: 'Lương ngày công',
                                      text2: bangLuong.luongNgay2 ?? '',
                                    ),
                                    BangLuongRow(
                                      text1: 'PC điện thoại',
                                      text2: bangLuong.pcDienThoai2 ?? '',
                                    ),
                                    BangLuongRow(
                                      text1: 'PC xăng xe',
                                      text2: bangLuong.pcXangXe2 ?? '',
                                    ),
                                    BangLuongRow(
                                      text1: 'PC ăn trưa',
                                      text2: bangLuong.pcAnCa2 ?? '',
                                    ),
                                  ])),
                          SizedBox(height: 3.h),
                          Container(
                            color: Colors.grey[200],
                            height: 13.h,
                            child: const Divider(
                              color: Colors.transparent,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Bảng lương cũ',
                                      style: TextStyle(
                                        color: AppColors.blueVNPT,
                                        fontSize: 18.sp,
                                        fontFamily: 'Arimo',
                                        height: 1.4,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 3.h),
                                    const Divider(
                                      color: Color.fromARGB(255, 214, 214, 214),
                                      height: 1,
                                    ),
                                    SizedBox(height: 10.h),
                                    BangLuongRow(
                                      text1: 'Mức lương',
                                      text2: bangLuong.mucLuong ?? '',
                                    ),
                                    BangLuongRow(
                                      text1: 'Ngày công',
                                      text2: bangLuong.ngayCong ?? '',
                                    ),
                                    BangLuongRow(
                                      text1: 'Lương ngày công',
                                      text2: bangLuong.luongNgay ?? '',
                                    ),
                                    BangLuongRow(
                                      text1: 'PC điện thoại',
                                      text2: bangLuong.pcDienThoai ?? '',
                                    ),
                                    BangLuongRow(
                                      text1: 'PC xăng xe',
                                      text2: bangLuong.pcXangXe ?? '',
                                    ),
                                    BangLuongRow(
                                      text1: 'PC ăn trưa',
                                      text2: bangLuong.pcAnCa ?? '',
                                    ),
                                  ])),
                          SizedBox(height: 3.h),
                          Container(
                            color: Colors.grey[200],
                            height: 13.h,
                            child: const Divider(
                              color: Colors.transparent,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Chi phí khác',
                                      style: TextStyle(
                                        color: AppColors.blueVNPT,
                                        fontSize: 18.sp,
                                        fontFamily: 'Arimo',
                                        height: 1.4,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 3.h),
                                    const Divider(
                                      color: Color.fromARGB(255, 214, 214, 214),
                                      height: 1,
                                    ),
                                    SizedBox(height: 10.h),
                                    BangLuongRow(
                                      text1: 'Đồng phục',
                                      text2: bangLuong.dongPhuc ?? '',
                                    ),
                                    BangLuongRow(
                                      text1: 'Nghỉ mát',
                                      text2: bangLuong.nghiMat ?? '',
                                    ),
                                    BangLuongRow(
                                      text1: 'Khám sức khoẻ',
                                      text2: bangLuong.khamSk ?? '',
                                    ),
                                    BangLuongRow(
                                      text1: 'Thưởng lễ',
                                      text2: bangLuong.thuongLe ?? '',
                                    ),
                                    BangLuongRow(
                                      text1: 'Thưởng tết dương lịch',
                                      text2: bangLuong.thuongTetDl ?? '',
                                    ),
                                    BangLuongRow(
                                      text1: 'Thưởng tết nguyên đán',
                                      text2: bangLuong.thuongTetNd ?? '',
                                    ),
                                    BangLuongRow(
                                      text1: 'Chi phí khác',
                                      text2: bangLuong.cpKhac ?? '',
                                    ),
                                  ])),
                        ],
                      );
                    },
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
      ),
    );
  }
}

class BangLuongRow extends StatelessWidget {
  final String text1;
  final String text2;

  const BangLuongRow({Key? key, required this.text1, required this.text2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var amount = double.tryParse(text2.replaceAll('₫', '').trim());

    Color textColor;
    bool isBold = false;

    if (text1 == 'Thực lĩnh') {
      textColor = Colors.blue;
      isBold = true;
    } else if (text1 == 'Tạm ứng') {
      textColor = Colors.red;
      isBold = true;
    } else if (text1 == 'Còn lại') {
      textColor = Colors.blue;
      isBold = true;
    } else if (text1 == 'Tổng lương') {
      textColor = const Color.fromARGB(255, 119, 119, 119);
      isBold = true;
    } else if (text1 == 'BHXH' ||
        text1 == 'Phí công đoàn' ||
        text1 == 'Thuế thu nhập cá nhân' ||
        text1 == 'Điều chỉnh giảm') {
      textColor = Colors.red;
      amount != null ? amount *= -1 : null;
    } else if (text1 == 'Điều chỉnh tăng' || text1 == 'Tiền thêm giờ') {
      textColor = Colors.green;
      amount != null ? amount *= 1 : null;
    } else {
      textColor = const Color.fromARGB(255, 119, 119, 119);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Text(
              text1,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
                fontFamily: 'Arimo',
                height: 1.4,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          const Spacer(),
          Expanded(
            flex: 4,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                formatCurrency(amount),
                style: TextStyle(
                  color: text1 == 'Thực lĩnh' ? Colors.blue : textColor,
                  fontSize: 14.sp,
                  fontFamily: 'Arimo',
                  height: 1.4,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CongDM extends StatelessWidget {
  final String text1;
  final String text2;

  const CongDM({Key? key, required this.text1, required this.text2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final amount = double.tryParse(text2.replaceAll('₫', '').trim());

    String formattedAmount =
        amount != null ? NumberFormat('0.0', 'en_US').format(amount) : '0.0';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Text(
              text1,
              style: TextStyle(
                fontFamily: 'Arimo',
                color: Colors.black,
                fontSize: 14.sp,
              ),
            ),
          ),
          const Spacer(),
          Expanded(
            flex: 4,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                formattedAmount,
                style: TextStyle(
                  color: const Color.fromARGB(255, 119, 119, 119),
                  fontSize: 14.sp,
                  fontFamily: 'Arimo',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
