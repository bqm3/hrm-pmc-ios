import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/pages/DanhBa/danhba_detail/KhenThuong&Kyluat/khenthuong_detail_controller.dart';
import 'package:salesoft_hrm/pages/DanhBa/danhba_detail/KhenThuong&Kyluat/khenthuong_detail_item.dart';
import 'package:salesoft_hrm/pages/DanhBa/danhba_detail/KhenThuong&Kyluat/kyluat_detail_controller.dart';
import 'package:salesoft_hrm/pages/DanhBa/danhba_detail/KhenThuong&Kyluat/kyluat_detail_item.dart';
import 'package:salesoft_hrm/widgets/component/back_button_widget.dart';
import 'package:salesoft_hrm/widgets/component/title_appbar_widget.dart';

class KTKLDTPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final KhenThuongDtController controller = Get.put(KhenThuongDtController());
    final KyLuatDtController controller2 = Get.put(KyLuatDtController());

    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonWidget(),
        backgroundColor: AppColors.blueVNPT,
        centerTitle: false,
        elevation: 0,
        title: const TitleAppBarWidget(title: "Khen thưởng & kỷ luật"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
            left: AppConstant.getScreenSizeWidth(context) * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppConstant.getScreenSizeWidth(context) * 0.03,
            ),
            const Text(
              'Khen thưởng',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: AppConstant.getScreenSizeWidth(context) * 0.01,
            ),
            controller.obx(
              (state) => ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: state?.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final item = state!.data![index];
                  return KhenThuongDtItemView(
                    nhanSu: item.nhanSu,
                    soQd: item.soQd,
                    ngayQd: item.ngayQd,
                    ngayHieuLuc: item.ngayHieuLuc,
                    hinhThuc: item.hinhThuc,
                    danhHieu: item.danhHieu,
                    noiDung: item.noiDung,
                    nguoiKy: item.nguoiKy,
                    capQd: item.capQd,
                    ghiChu: item.ghiChu,
                    soTien: item.soTien,
                  );
                },
              ),
              onLoading: const Center(child: CircularProgressIndicator()),
              onEmpty: const Center(
                child: Text('Không có thông tin'),
              ),
              onError: (error) => Center(child: Text('Không có thông tin')),
            ),
            SizedBox(
              height: AppConstant.getScreenSizeWidth(context) * 0.01,
            ),
            const Text(
              'Kỷ luật',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: AppConstant.getScreenSizeWidth(context) * 0.01,
            ),
            controller2.obx(
              (state) => ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: state?.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final item = state!.data![index];
                  return KyLuatDtItemView(
                    nhanSu: item.nhanSu,
                    soQd: item.soQd,
                    ngayQd: item.ngayQd,
                    ngayHieuLuc: item.ngayHieuLuc,
                    hinhThuc: item.hinhThuc,
                    thoiGian: item.thoiGian,
                    noiDung: item.noiDung,
                    nguoiKy: item.nguoiKy,
                    capQd: item.capQd,
                    ghiChu: item.ghiChu,
                    soTien: item.soTien,
                  );
                },
              ),
              onLoading: const Center(child: CircularProgressIndicator()),
              onEmpty: const Center(
                child: Text('Không có thông tin'),
              ),
              onError: (error) => Center(child: Text('Không có thông tin')),
            ),
            SizedBox(
              height: AppConstant.getScreenSizeWidth(context) * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}
