import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/KhenThuong&KyLuat/khenthuong_controller.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/KhenThuong&KyLuat/khenthuong_item.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/KhenThuong&KyLuat/kyluat_controller.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/KhenThuong&KyLuat/kyluat_item.dart';
import 'package:salesoft_hrm/widgets/component/back_button_widget.dart';
import 'package:salesoft_hrm/widgets/component/title_appbar_widget.dart';

class KTKLPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final KhenThuongController controller = Get.put(KhenThuongController());
    final KyLuatController controller2 = Get.put(KyLuatController());

    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonWidget(),
        backgroundColor: Colors.white,
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
                  return KhenThuongItemView(
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
              height: AppConstant.getScreenSizeWidth(context) * 0.03,
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
                  return KyLuatItemView(
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
