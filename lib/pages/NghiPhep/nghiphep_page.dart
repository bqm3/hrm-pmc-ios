import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/API/provider/nghiphep_detail_provider.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/model/list_nghiphep_model.dart';
import 'package:salesoft_hrm/pages/NghiPhep/dialog_loai_dknghi.dart';
import 'package:salesoft_hrm/pages/NghiPhep/nghiphep_controller.dart';
import 'package:salesoft_hrm/pages/NghiPhep/nghiphep_item.dart';
import 'package:salesoft_hrm/widgets/component/back_button_widget.dart';
import 'package:salesoft_hrm/widgets/component/title_appbar_widget.dart';
import 'package:salesoft_hrm/model/loainghi_model.dart';
import 'package:salesoft_hrm/widgets/empty_data_widget.dart';
import 'package:http/http.dart' as http;

class NghiPhepPage extends StatefulWidget {
  const NghiPhepPage({super.key});

  @override
  _NghiPhepPageState createState() => _NghiPhepPageState();
}

class _NghiPhepPageState extends State<NghiPhepPage> {
  final controller = Get.put(NghiPhepController());
  List<ListNghiPhep> listNghiPhep = [];
  List<LoaiNghi> listLoaiNghi = [];
  final detailProvider = NghiPhepDetailProviderAPI();
  int? selectedNghiPhepId;

  // Gọi API để lấy chi tiết nghỉ phép

  int? selectedFilterTinhTrang;
  String? _selectedMonth;
  String? _selectedYear;
  List<String> _months = [];
  List<String> _years = [];
  String? _selectedLoaiNghi;
  String? _selectedTinhTrang;
  void _reloadData() {
    controller.fetchListContent();
  }

  void _clearFilters() {
    setState(() {
      _selectedTinhTrang = null;
      _selectedLoaiNghi = null;
    });
    _search();
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
    controller.tinhTrang = _selectedTinhTrang ?? '';
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
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        title: Row(
          children: [
            const Expanded(
                flex: 9, child: TitleAppBarWidget(title: "Đăng ký nghỉ")),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return LoaiDKNghiDialog();
                    },
                  ).then((_) {
                    _clearFilters();
                  });
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
        margin: EdgeInsets.only(top: 5.0.h),
        child: Column(
          children: [
            const SizedBox(height: 5),
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
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 5),
                        const FaIcon(FontAwesomeIcons.calendarDays,
                            color: Colors.blue, size: 18),
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
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 20, 16, 16),
                          width: 0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: EdgeInsets.only(right: 16.w, left: 5.w),
                    alignment: Alignment.center,
                    child: DropdownButton<String>(
                      value:
                          Get.find<NghiPhepController>().tinhTrang?.isEmpty ??
                                  true
                              ? Get.find<NghiPhepController>().tinhTrang = '10'
                              : Get.find<NghiPhepController>().tinhTrang,
                      underline: Container(),
                      hint: const Center(child: Text('Toàn bộ')),
                      items: const [
                        DropdownMenuItem(value: '10', child: Text('Toàn bộ')),
                        DropdownMenuItem(value: '0', child: Text('Chờ duyệt')),
                        DropdownMenuItem(value: '1', child: Text('Đã duyệt')),
                        DropdownMenuItem(
                            value: '2', child: Text('Không duyệt')),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedTinhTrang = value;
                          });
                          Get.find<NghiPhepController>().setTinhTrang(value);
                          _search();
                        }
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                  // child: DropdownButton<String>(
                  //   value: _selectedLoaiNghi,
                  //   hint: const Text('Chọn Loại Nghỉ'),
                  //   items: [
                  //     DropdownMenuItem<String>(
                  //       value: 'Nghỉ phép',
                  //       child: Text('Nghỉ phép'),
                  //     ),
                  //     DropdownMenuItem<String>(
                  //       value: 'Nghỉ không lương',
                  //       child: Text('Nghỉ không lương'),
                  //     ),
                  //     DropdownMenuItem<String>(
                  //       value: 'Nghỉ có lương',
                  //       child: Text('Nghỉ có lương'),
                  //     ),
                  //   ],
                  //   onChanged: (String? newValue) {
                  //     setState(() {
                  //       _selectedLoaiNghi = newValue;
                  //     });

                  //     if (newValue == 'Nghỉ không lương') {
                  //       callApiWithParent('0');
                  //     } else if (newValue == 'Nghỉ có lương') {
                  //       callApiWithParent('1');
                  //     }
                  //   },
                  // ),
                ),
              ],
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
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedNghiPhepId = item?.id;
                            });

                            final detailProvider = NghiPhepDetailProviderAPI();
                            detailProvider
                                .getNghiPhepDetail(
                              id: selectedNghiPhepId!,
                              thang: controller.thang,
                              nam: controller.nam,
                            )
                                .then((detail) {
                              print('Chi tiết nghỉ phép: $detail');
                            }).catchError((error) {
                              print('Có lỗi xảy ra khi lấy chi tiết: $error');
                            });
                          },
                          child: ListNghiPhepItemView(
                            loaiNghi: item?.ten ?? '',
                            tinhTrang: item?.tinhTrang,
                            soLuong: item?.soLuong?.toString() ?? '',
                            tuNgay: item?.tuNgay?.toString() ?? '',
                            denNgay: item?.denNgay?.toString() ?? '',
                            id: item?.id,
                          ),
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
      ),
    );
  }

  void showMonthYearBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        int selectedYear = DateTime.now().year;
        int selectedMonth = DateTime.now().month;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Chọn Tháng và Năm',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButton<int>(
                        value: selectedMonth,
                        items: List.generate(12, (index) {
                          return DropdownMenuItem(
                            value: index + 1,
                            child: Text(DateFormat.MMMM()
                                .format(DateTime(0, index + 1))),
                          );
                        }),
                        onChanged: (value) {
                          setState(() {
                            selectedMonth = value!;
                          });
                        },
                      ),
                      SizedBox(width: 20),
                      DropdownButton<int>(
                        value: selectedYear,
                        items: List.generate(100, (index) {
                          return DropdownMenuItem(
                            value: 2024 - index,
                            child: Text((2024 - index).toString()),
                          );
                        }),
                        onChanged: (value) {
                          setState(() {
                            selectedYear = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, {
                        'month': selectedMonth,
                        'year': selectedYear,
                      });
                    },
                    child: const Text('Xong'),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((value) {
      if (value != null) {
        int selectedMonth = value['month'];
        int selectedYear = value['year'];
        print('Selected month: $selectedMonth, Selected year: $selectedYear');
      }
    });
  }

  void callApiWithParent(String parent) async {
    print('Calling API with Parent: $parent');

    try {
      final response = await http.get(
        Uri.parse(
            'https://apihrm.pmcweb.vn/api/DanhMuc/GetList?Table=DM_CaLamViec&Parent=$parent'),
        headers: {'accept': '*/*'},
      );

      print('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Response data: $data');
        setState(() {
          listLoaiNghi =
              (data as List).map((item) => LoaiNghi.fromJson(item)).toList();
        });

        if (listLoaiNghi.isEmpty) {
          print('No LoaiNghi found.');
        } else {
          for (var item in listLoaiNghi) {
            String? maValue = item.ma;
            controller.fetchListContentWithLoaiNghi(maValue!);
          }
        }
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
