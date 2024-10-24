import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/model/calamviec2_model.dart';
import 'package:salesoft_hrm/pages/DoiCa/doica_controller.dart';
import 'package:salesoft_hrm/pages/DoiCa/doica_item.dart';
import 'package:salesoft_hrm/widgets/component/back_button_widget.dart';
import 'package:salesoft_hrm/widgets/component/title_appbar_widget.dart';
import 'package:salesoft_hrm/widgets/dialog_thanhcong.dart';
import 'package:salesoft_hrm/widgets/dialog_thatbai.dart';
import 'package:salesoft_hrm/widgets/empty_data_widget.dart';
import 'package:intl/intl.dart';

class DoiCaPage extends StatefulWidget {
  const DoiCaPage({super.key});

  @override
  _DoiCaPageState createState() => _DoiCaPageState();
}

class _DoiCaPageState extends State<DoiCaPage> {
  TextEditingController dateController = TextEditingController();
  TextEditingController oldShiftController = TextEditingController();
  TextEditingController newShiftController = TextEditingController();
  final controller = Get.put(DoiCaController());
  String? _selectedMonth;
  String? _selectedYear;
  List<String> _months = [];
  List<String> _years = [];
  String? _selectedTinhTrang;
  void _reloadData() {
    controller.fetchListContent();
  }

  Future<void> _showFormDialog() async {
    List<CaLamViec2> newShiftOptions = controller.newShiftOptions.toList();
    String? ma = await AuthService().ma;
    List<CaLamViec4> oldShiftOptions2 =
        await controller.fetchShiftList(ma!, dateController.text);

    CaLamViec2? selectedNewShift =
        newShiftOptions.isNotEmpty ? newShiftOptions.first : null;
    CaLamViec4? selectedOldShift2 =
        oldShiftOptions2.isNotEmpty ? oldShiftOptions2.first : null;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          dateController: dateController,
          oldShiftController: oldShiftController,
          selectedNewShift: selectedNewShift,
          oldShiftOptions2: oldShiftOptions2,
          newShiftOptions: newShiftOptions,
          selectedOldShift2: selectedOldShift2,
          ma: ma,
        );
      },
    );
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
            const Expanded(flex: 9, child: TitleAppBarWidget(title: "Đổi ca")),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  _showFormDialog();
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
                      setState(() {
                        _selectedTinhTrang = value;
                      });
                      controller.tinhtrang = value;
                      controller.fetchListContent();
                    },
                    itemBuilder: (BuildContext context) {
                      return <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: '10',
                          child: Text('Toàn bộ'),
                        ),
                        const PopupMenuItem<String>(
                          value: '0',
                          child: Text('Mới tạo'),
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
                  controller.tinhtrang = _selectedTinhTrang ?? '';

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
                        return DoiCaItemView(
                          caCu: item?.caCu ?? '',
                          caMoi: item?.caMoi ?? '',
                          thoiGian: item?.ngay ?? '',
                          tenCaCu: item?.tenCaCu ?? '',
                          tenCaMoi: item?.tenCaMoi ?? '',
                          tinhtrang: item?.tinhTrang,
                          id: item?.id,
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

class CustomDialog extends StatefulWidget {
  final TextEditingController dateController;
  final TextEditingController oldShiftController;
  final String ma;
  final CaLamViec2? selectedNewShift;
  final CaLamViec4? selectedOldShift2;
  final List<CaLamViec2> newShiftOptions;
  final List<CaLamViec4> oldShiftOptions2;

  CustomDialog({
    required this.dateController,
    required this.oldShiftController,
    required this.ma,
    required this.selectedNewShift,
    required this.newShiftOptions,
    required this.selectedOldShift2,
    required this.oldShiftOptions2,
  });

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  final controller = Get.put(DoiCaController());
  late CaLamViec2? selectedNewShift;
  late CaLamViec4? selectedOldShift2;
  bool isValidDate = true;

  @override
  void initState() {
    super.initState();
    selectedNewShift = widget.selectedNewShift;
    selectedOldShift2 = widget.selectedOldShift2;
  }

  Future<void> _fetchShiftOptions(String date) async {
    List<CaLamViec4> fetchedShifts =
        await controller.fetchShiftList(widget.ma, date);

    setState(() {
      widget.oldShiftOptions2.clear();
      widget.oldShiftOptions2.addAll(fetchedShifts);
      selectedOldShift2 = fetchedShifts.isNotEmpty ? fetchedShifts.first : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: SingleChildScrollView(
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
              SizedBox(height: 8.h),
              Text(
                'Ngày đăng ký',
                style: TextStyle(
                  fontFamily: 'Arimo',
                  fontSize: 12.h,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6.h),
              GestureDetector(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                        data: ThemeData.light(),
                        child: child!,
                      );
                    },
                  );

                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy/MM/dd').format(pickedDate);
                    widget.dateController.text = formattedDate;
                    DateTime selectedDate = pickedDate;

                    setState(() {
                      isValidDate = widget.dateController.text.isNotEmpty;
                    });

                    await _fetchShiftOptions(formattedDate);
                  } else {
                    setState(() {
                      isValidDate = false;
                    });
                  }
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0.h, vertical: 1.0.h),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isValidDate ? Colors.grey : Colors.red,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 9,
                        child: TextField(
                          controller: widget.dateController,
                          style: const TextStyle(
                            fontFamily: 'Arimo',
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                          enabled: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.grey[600],
                              fontFamily: 'Arimo',
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: FaIcon(FontAwesomeIcons.calendar),
                      ),
                    ],
                  ),
                ),
              ),
              if (!isValidDate)
                Padding(
                  padding: EdgeInsets.only(top: 6.h),
                  child: Text(
                    'Vui lòng chọn ngày đổi ca.',
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'Arimo',
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              SizedBox(height: 12.h),
              Text(
                'Ca cũ',
                style: TextStyle(
                  fontFamily: 'Arimo',
                  fontSize: 12.h,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 1.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.5),
                  borderRadius: BorderRadius.circular(10.0.r),
                  color: Colors.white,
                ),
                child: DropdownButton<CaLamViec4>(
                  value: selectedOldShift2,
                  isExpanded: true,
                  underline: Container(),
                  onChanged: (CaLamViec4? newValue) {
                    setState(() {
                      selectedOldShift2 = newValue;
                      widget.oldShiftController.text = newValue?.ten ?? '';
                    });
                  },
                  items: widget.oldShiftOptions2
                      .map<DropdownMenuItem<CaLamViec4>>((CaLamViec4 value) {
                    return DropdownMenuItem<CaLamViec4>(
                      value: value,
                      child: Text(value.ten ?? ''),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'Ca mới',
                style: TextStyle(
                  fontFamily: 'Arimo',
                  fontSize: 12.h,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6.h),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 1.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.5),
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: DropdownButton<CaLamViec2>(
                  value: selectedNewShift,
                  isExpanded: true,
                  underline: Container(),
                  onChanged: (CaLamViec2? newValue) {
                    setState(() {
                      selectedNewShift = newValue!;
                    });
                  },
                  items: widget.newShiftOptions
                      .map<DropdownMenuItem<CaLamViec2>>((CaLamViec2 value) {
                    return DropdownMenuItem<CaLamViec2>(
                      value: value,
                      child: Text(value.ten),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      color: AppColors.blueVNPT,
                      borderRadius: BorderRadius.circular(10.0),
                      onPressed: () async {
                        if (widget.dateController.text.isEmpty) {
                          setState(() {
                            isValidDate = false;
                          });
                          return;
                        }

                        String ma = await AuthService().ma ?? '';
                        String ngay = widget.dateController.text;
                        String caCu = selectedOldShift2?.ma ?? '';
                        String caMoi = selectedNewShift?.ma ?? '';
                        await postDoiCa(ma, ngay, caCu, caMoi);
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
      ),
    );
  }
}

Future<void> postDoiCa(
    String ma, String ngay, String caCu, String caMoi) async {
  final controller = Get.put(DoiCaController());

  try {
    final response = await http.post(
      Uri.parse(
          'https://apihrm.pmcweb.vn/api/DoiCa?Ma=$ma&Ngay=$ngay&CaCu=$caCu&CaMoi=$caMoi'),
      headers: <String, String>{
        'accept': '*/*',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'Ma': ma,
        'Ngay': ngay,
        'CaCu': caCu,
        'CaMoi': caMoi,
      }),
    );

    if (response.statusCode == 200) {
      controller.fetchListContent();
      jsonDecode(response.body);
      Navigator.of(Get.context!).pop();
      Get.dialog(
        thongBaoDialog(text: 'Đăng ký đổi ca thành công'),
      );
    } else {
      var responseBody = jsonDecode(response.body);
      String errorMessage =
          responseBody['message'] ?? 'Có lỗi xảy ra khi kết nối đến server';
      Get.dialog(
        thongBaoDialog2(text: errorMessage),
      );
    }
  } catch (error) {
    print('Lỗi khi gọi API: $error');
    Get.dialog(
      thongBaoDialog2(text: 'Lỗi khi kết nối đến server'),
    );
  }
}
