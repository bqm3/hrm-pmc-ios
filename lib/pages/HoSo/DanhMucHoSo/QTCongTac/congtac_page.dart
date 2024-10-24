import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/QTCongTac/congtac_controller.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/QTCongTac/congtac_item.dart';
import 'package:salesoft_hrm/widgets/component/back_button_widget.dart';
import 'package:salesoft_hrm/widgets/component/title_appbar_widget.dart';

class CongTacPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CongTacTrController controller = Get.put(CongTacTrController());
    final CongTacController controller2 = Get.put(CongTacController());

    return Scaffold(
      appBar: AppBar(
        leading: BackButtonWidget(),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        title: const TitleAppBarWidget(title: "Quá trình công tác"),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                'Hiện tại',
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
                    return CongTacItemView(
                      nhanSu: item.nhanSu,
                      soQd: item.soQd,
                      ngayQd: item.ngayQd,
                      donVi: item.donVi,
                      tuNgay: item.tuNgay,
                      denNgay: item.denNgay,
                      congTy: item.congTy,
                      phongBan: item.phongBan,
                      toCongTac: item.toCongTac,
                      loaiQd: item.loaiQd,
                      chucVu: item.chucVu,
                      kiemNhiem: item.kiemNhiem,
                      thoiGian: item.thoiGian,
                      mucLuong: item.mucLuong,
                      chuyenNganh: item.chuyenNganh,
                      ghiChu: item.ghiChu,
                    );
                  },
                ),
                onLoading: Center(child: CircularProgressIndicator()),
                onEmpty: Center(child: Text('Không có thông tin')),
                onError: (error) => Center(child: Text('Không có thông tin')),
              ),
              SizedBox(
                height: AppConstant.getScreenSizeWidth(context) * 0.01,
              ),
              const Text(
                'Trước đây',
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
                    return CongTacTrItemView(
                      nhansu: item.nhansu,
                      donVi: item.donVi,
                      tuNgay: item.tuNgay,
                      denNgay: item.denNgay,
                      phongban: item.phongban,
                      chucVu: item.chucVu,
                      kiemNhiem: item.kiemNhiem,
                      thoiGian: item.thoiGian,
                      mucLuong: item.mucLuong,
                      ghiChu: item.ghiChu,
                    );
                  },
                ),
                onLoading: Center(child: CircularProgressIndicator()),
                onEmpty: Center(child: Text('Không có thông tin')),
                onError: (error) => Center(child: Text('Không có thông tin')),
              ),
              SizedBox(
                height: AppConstant.getScreenSizeWidth(context) * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
