import 'package:flutter/material.dart';

///
/// File định nghĩa các màu
///
class AppColors {
  static const main = Color(0xfffec6716);
  static const greyBackground = Color(0xFFFBFBFB);

  static const blue = Color(0xFF0873AC);
  static const blue50 = Color.fromARGB(255, 249, 249, 249);
  static const blue100 = Color(0xFFE6EFF4);
  static const blue150 = Color(0xFFADE2FF);
  static const blue200 = Color(0xFF53B5E9);
  static const blue400 = Color(0xFF2696D2);
  static const blueVNPT = Color.fromRGBO(5, 76, 220, 1);
  static const blueVNPT2 = Color.fromRGBO(169, 192, 255, 1);

  static const turquoise = Color(0xFF0CA6A2);

  static const orange = Color(0xFFEC6716);
  static const terraCotta = Color(0xFFE2725B);

  static const red = Color(0xFFFB3636);
  static const approved = Color(0xFFe5293e);

  static const green = Color(0xFF4AB55B);
  static const greenQuotePrice = Color(0xFF81b364);
  static const job = Color(0xFF2161cb);
  static const pink = Color.fromARGB(255, 203, 32, 129);

  static const yellow = Color(0xFFE3AB06);
  static const yellow400 = Color(0xFFC8C32E);

  static const grey = Color(0xFF555555);
  static const grey50 = Color(0xFFC4C4C4);
  static const grey60 = Color(0xFFE9E9E9);
  static const grey300 = Color(0xFF999999);
  static const green300 = Color(0xff66c97f);
  static const grey400 = Color(0xFF828282);
  static const grey450 = Color(0xFF888888);
  static const grey700 = Color(0xFF333333);

  static const notifiColor1 = Color(0xffEC6716);
  static const notifiColor2 = Color(0xff05B9B3);
  static const notifiColor3 = Color(0xff6522EB);
  static const notifiColor4 = Color(0xffE3AB06);
  static const notifiColor5 = Color(0xff0873AC);
  static const notifiColor6 = Color(0xffEC6716);

  static const orHeadTitle = Color(0xff5e5e6a);
  static const orPrice = Color(0xff4c4b59);
  static const orMainTitle = Color(0xff130810);
  static const orTime = Color(0xff5364e6);
  static const orBgr = Color(0xffeeeff4);

  static const orPending = Color(0xfffebd19);
  static const orBgPending = Color(0xffffff9e9);
  static const orCompleted = Color(0xff3ad999);
  static const orBgCompleted = Color(0xffebfcf4);
  static const orCanceled = Color(0xff4d4b59);
  static const orBgCanceled = Color(0xffefefef);
  static const orNoQuaHan = Color(0xffef4548);
  static const orBgNoQuaHan = Color(0xffffeded);

  static const orItemDetailBg = Color(0xfff5f6fa);
  static const orItemDetailProduct = Color(0xff9da5b8);
  static const yellowList = Color(0xFFE79D00);
  static const Color border = Color(0xFFCBD5E1);

  //crm
  /*static const Color MOI = Color(0xFFFA6B00);
  static const Color DANG_CHAM_SOC = Color(0xFF006ED8);
  static const Color HOAN_THANH = Color(0xFF25BC05);
  static const Color DA_HUY = Color(0xFFE2D4D3);
  static const Color BAO_DO = Color(0xFFED40E0D);*/

  static getDebtColor(double value) {
    return value >= 0 ? AppColors.green : AppColors.red;
  }

  //dành cho chứng từ
  static getOrderStatusBgColor(String text) {
    text = text.toString().toUpperCase();
    if (text == "ĐẶT HÀNG" || text == "ĐANG CHỜ" || text == "CHƯA XUẤT") {
      return Colors.orangeAccent;
    } else if (text == "HOÀN THÀNH") {
      return AppColors.green;
    } else if (text == "NỢ QUÁ HẠN") {
      return AppColors.orNoQuaHan;
    } else {
      return AppColors.orCanceled;
    }
  }

  //dành cho phiếu xuất kho, xuất hàng (hóa đơn xuất)
  static getStatusBgColorHoaDonXuat(double tinhTrang) {
    if (tinhTrang == 0) {
      return AppColors.orange; //chưa duyệt
    } else if (tinhTrang == 1) {
      return AppColors.turquoise; //đã duyệt
    } else if (tinhTrang == 2) {
      return AppColors.green; //X/N kho
    } else {
      return AppColors.orCanceled;
    }
  }

  static Widget pleaseWait({double size = 16, Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            color: color ?? AppColors.red,
          )),
    );
  }

  static BorderSide borderStyle = const BorderSide(
    color: AppColors.blue150,
    width: 0.5,
  );

  static BoxDecoration itemBoxStyle = BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: AppColors.grey300.withOpacity(0.25),
        blurRadius: 8,
        offset: const Offset(4, 4),
      ),
    ],
  );
}
