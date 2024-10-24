import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/pages/DanhBa/danhba_detail/QTCongTac/congtac_detail_controller.dart';
import 'package:salesoft_hrm/pages/DanhBa/danhba_detail/QTCongTac/congtac_detail_item.dart';
import 'package:salesoft_hrm/widgets/component/back_button_widget.dart';
import 'package:salesoft_hrm/widgets/component/title_appbar_widget.dart';

class CongTacDtPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CongTacTrDtController controller = Get.put(CongTacTrDtController());
    final CongtacDtController controller2 = Get.put(CongtacDtController());

    return Scaffold(
      appBar: AppBar(
        leading: BackButtonWidget(),
        backgroundColor: AppColors.blueVNPT,
        centerTitle: false,
        elevation: 0,
        title: const TitleAppBarWidget(title: "Quá trình công tác"),
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
                  return CongTacDtItemView(
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
              height: AppConstant.getScreenSizeWidth(context) * 0.03,
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
                  return CongTacTrDtItemView(
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
    );
  }
}
