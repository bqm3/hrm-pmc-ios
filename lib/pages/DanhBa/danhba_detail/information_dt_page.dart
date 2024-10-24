import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/common/format_date.dart';
import 'package:salesoft_hrm/pages/DanhBa/danhba_detail/danhba_detail_controller.dart';
import 'package:salesoft_hrm/pages/DanhBa/danhba_detail/hocvan/hocvan_detail_controller.dart';
import 'package:salesoft_hrm/pages/DanhBa/danhba_detail/hocvan/hocvan_detail_item.dart';
import 'package:salesoft_hrm/widgets/component/back_button_widget.dart';
import 'package:salesoft_hrm/widgets/component/title_appbar_widget.dart';
import 'package:salesoft_hrm/widgets/cot_hoso_widget.dart';

class InformationDtPage extends StatelessWidget {
  const InformationDtPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DtController homeController = Get.find<DtController>();
    final hocvanDetailController controller = Get.put(hocvanDetailController());

 
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonWidget(),
        backgroundColor: AppColors.blueVNPT,
        centerTitle: false,
        elevation: 0,
        title: const TitleAppBarWidget(title: "Sơ Yếu Lý Lịch"),
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
                'Thông tin cá nhân',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: AppConstant.getScreenSizeWidth(context) * 0.03,
              ),
              Container(
                width: AppConstant.getScreenSizeWidth(context) * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.01,
                    ),
                    RowHoSo(
                      text1: 'Họ tên',
                      text2:
                          '${homeController.hoDem.value} ${homeController.ten.value}',
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo(
                        text1: 'Ngày sinh',
                        text2: formatDate(homeController.ngaySinh.value)),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo(
                        text1: 'Giới tính',
                        text2: homeController.gioiTinh.value),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo(
                        text1: 'Địa chỉ ',
                        text2: homeController.dcll.value),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo(
                        text1: 'Điện thoại',
                        text2: homeController.dienThoai.value),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    
                    RowHoSo(text1: 'Email', text2: homeController.email.value),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppConstant.getScreenSizeWidth(context) * 0.03,
              ),
              Container(
                width: AppConstant.getScreenSizeWidth(context) * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.01,
                    ),
                    RowHoSo(
                      text1: 'Đơn vị',
                      text2:homeController.donVi.value,
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    
                    RowHoSo(
                        text1: 'Phòng ban',
                        text2: homeController.phongBan.value),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    
                    RowHoSo(
                        text1: 'Bộ phận ',
                        text2: homeController.toCongTac.value),
                        SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo(
                        text1: 'Chức vụ', text2: homeController.chucVu.value),
                    
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppConstant.getScreenSizeWidth(context) * 0.07,
              ),
              const Text(
                'Học vấn',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: AppConstant.getScreenSizeWidth(context) * 0.01,
              ),
              Container(
                child: controller.obx(
                  (state) => ListView.builder(
                    shrinkWrap: true,
                    itemCount: state?.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      final item = state!.data![index];
                      return HocVanDtItemView(
                        nhanSu: item.nhanSu,
                        hocVan: item.hocVan,
                        hocVi: item.hocVi,
                        truongDt: item.truongDt,
                        loaiBang: item.loaiBang,
                        chuyenNganh: item.chuyenNganh,
                        namTn: item.namTn,
                        quocGia: item.quocGia,
                      );
                    },
                  ),
          onLoading: const Center(child: CircularProgressIndicator()),
                  
                  onEmpty: const Center(
                    child: Text('Không có thông tin'),
                  ),
                  onError: (error) =>
                      const Center(child: Text('Không có thông tin')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
