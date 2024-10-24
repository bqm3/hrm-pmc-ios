import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/QTLuong/Qtluong_item.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/QTLuong/detail/Qtluong_hoso_detail_item.dart';
import 'package:salesoft_hrm/resources/app_resource.dart';
import 'package:salesoft_hrm/widgets/component/back_button_widget.dart';
import 'package:salesoft_hrm/widgets/component/title_appbar_widget.dart';
import 'package:salesoft_hrm/widgets/filter_widget.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/QTLuong/Qtluong_controller.dart';
import 'package:intl/intl.dart';

class LuongPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final QtLuongController controller = Get.put(QtLuongController());

    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonWidget(),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        title: const TitleAppBarWidget(title: "Quá trình lương"),
      ),
      body: Container(
        padding: EdgeInsets.only(
          left: AppConstant.getScreenSizeWidth(context) * 0.05,
          right: AppConstant.getScreenSizeWidth(context) * 0.05,
          top: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _HeaderFilterTimeWidget(),
            Expanded(
              child: controller.obx(
                (state) => state != null &&
                        state.data != null &&
                        state.data!.isNotEmpty
                    ? ListView.builder(
                        itemCount: state.data!.length,
                        itemBuilder: (context, index) {
                          final item = state.data![index];
                          return GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    child: SingleChildScrollView(
                                      child: QtluongItemView2(
                                        soQd: item.soQd,
                                        ngayQd: item.ngayQd,
                                        loaiQd: item.loaiQd,
                                        nhanSu: item.nhanSu,
                                        tuNgay: item.tuNgay,
                                        denNgay: item.denNgay,
                                        ngachCc: item.ngachCc,
                                        bacCc: item.bacCc,
                                        hsl: item.hsl,
                                        luongCoBan: item.luongCoBan,
                                        noiDung: item.noiDung,
                                        soHd: item.soHd,
                                        hdld: item.hdld,
                                        phuLucHopDong: item.phuLucHopDong,
                                        pcTrachNhiem: item.pcTrachNhiem,
                                        pcLuong: item.pcLuong,
                                        pcKhac: item.pcKhac,
                                        lanKy: item.lanKy,
                                        ghiChu: item.ghiChu,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: QtluongItemView(
                              soQd: item.soQd,
                              ngayQd: item.ngayQd,
                              loaiQd: item.loaiQd,
                              nhanSu: item.nhanSu,
                              tuNgay: item.tuNgay,
                              denNgay: item.denNgay,
                              ngachCc: item.ngachCc,
                              bacCc: item.bacCc,
                              hsl: item.hsl,
                              luongCoBan: item.luongCoBan,
                              noiDung: item.noiDung,
                              soHd: item.soHd,
                              hdld: item.hdld,
                              phuLucHopDong: item.phuLucHopDong,
                              pcTrachNhiem: item.pcTrachNhiem,
                              pcLuong: item.pcLuong,
                              pcKhac: item.pcKhac,
                              lanKy: item.lanKy,
                              ghiChu: item.ghiChu,
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text('Không có thông tin'),
                      ),
                onLoading: const Center(child: CircularProgressIndicator()),
                onError: (error) => Center(child: Text('Lỗi: $error')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderFilterTimeWidget extends StatelessWidget {
  const _HeaderFilterTimeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final QtLuongController controller = Get.find();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Obx(() {
            return FilterWidget(
              textColor: Colors.black,
              title: "Chọn ngày",
              value:
                  "${DateFormat('dd/MM/yyyy').format(controller.tuNgay.value)} - ${DateFormat('dd/MM/yyyy').format(controller.denNgay.value)}",
              imageAssetName: AppResource.icCalendar,
              onPress: () async {
                DateTimeRange? picked = await showDateRangePicker(
                  context: context,
                  initialDateRange: DateTimeRange(
                    start: controller.tuNgay.value,
                    end: controller.denNgay.value,
                  ),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );

                if (picked != null) {
                  controller.setTimePeriod(picked.start, picked.end);
                }
              },
            );
          }),
        ),
        SizedBox(width: AppConstant.getScreenSizeWidth(context) * 0.05),
      ],
    );
  }
}
