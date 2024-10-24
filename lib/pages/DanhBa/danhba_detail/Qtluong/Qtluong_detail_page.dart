import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/pages/DanhBa/danhba_detail/Qtluong/Qtluong_detail_controller.dart';
import 'package:salesoft_hrm/pages/DanhBa/danhba_detail/Qtluong/Qtluong_detail_item.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/QTLuong/Qtluong_controller.dart';
import 'package:salesoft_hrm/resources/app_resource.dart';
import 'package:salesoft_hrm/widgets/component/back_button_widget.dart';
import 'package:salesoft_hrm/widgets/component/title_appbar_widget.dart';
import 'package:salesoft_hrm/widgets/filter_widget.dart';

class LuongDtPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final QtluongDtController controller = Get.put(QtluongDtController());


    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonWidget(),
        backgroundColor: AppColors.blueVNPT,
        centerTitle: false,
        elevation: 0,
        title: const TitleAppBarWidget(title: "Quá trình lương"),
      ),
      body: Container(
        padding: EdgeInsets.only(
            left: AppConstant.getScreenSizeWidth(context) * 0.05),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: controller.obx(
                (state) => ListView.builder(
                  itemCount: state?.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    final item = state!.data![index];
                    return QtluongDtItemView(                    
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
                      );
                  },
                ),
                onLoading: const Center(child: CircularProgressIndicator()),
                onEmpty: const Center(child: Text('Không có thông tin')),
                onError: (error) => Center(child: Text('Lỗi: $error')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
