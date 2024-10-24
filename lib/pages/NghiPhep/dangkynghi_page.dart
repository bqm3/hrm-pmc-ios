import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/model/calamviec2_model.dart';
import 'package:salesoft_hrm/pages/NghiPhep/nghicoluong_page.dart';
import 'package:salesoft_hrm/pages/NghiPhep/dk_nghikhongluong_page.dart';
import 'package:salesoft_hrm/pages/NghiPhep/dknghiphep_page.dart';
import 'package:salesoft_hrm/widgets/component/back_button_widget.dart';
import 'package:salesoft_hrm/widgets/component/title_appbar_widget.dart';

class dkNghiPage extends StatelessWidget {
  final TextEditingController tuNgayController = TextEditingController();
  final TextEditingController denNgayController = TextEditingController();
  final TextEditingController oldShiftController = TextEditingController();
  late final CaLamViec3? selectedOldShift;
  late final List<CaLamViec3> oldShiftOptions;

  dkNghiPage({
    Key? key,
    this.selectedOldShift,
    this.oldShiftOptions = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButtonWidget(),
          backgroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
          title: const Row(
            children: [
              Expanded(
                  flex: 9, child: TitleAppBarWidget(title: "Đăng ký nghỉ")),
            ],
          ),
          bottom: const TabBar(
            indicatorColor: AppColors.blueVNPT,
            labelColor: AppColors.blueVNPT,
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(text: 'Nghỉ Phép'),
              Tab(text: 'Nghỉ Không Lương'),
              Tab(text: 'Nghỉ Có Lương'),
            ],
          ),
        ),
        body: Container(
          color: Colors.white,
          child: TabBarView(
            children: [
              ManyDayDialog(
                tuNgayController: tuNgayController,
                denNgayController: denNgayController,
                oldShiftController: oldShiftController,
                selectedOldShift: selectedOldShift,
                oldShiftOptions: oldShiftOptions,
              ),
              ManyDayDialog2(
                  tuNgayController: tuNgayController,
                  denNgayController: denNgayController,
                  oldShiftController: oldShiftController,
                  selectedOldShift: selectedOldShift,
                  oldShiftOptions: oldShiftOptions),
              ManyDayDialog3(
                  tuNgayController: tuNgayController,
                  denNgayController: denNgayController,
                  oldShiftController: oldShiftController,
                  selectedOldShift: selectedOldShift,
                  oldShiftOptions: oldShiftOptions)
            ],
          ),
        ),
      ),
    );
  }
}
