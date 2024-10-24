import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:salesoft_hrm/pages/XetDuyet/daduyet_controller.dart';
import 'package:salesoft_hrm/pages/XetDuyet/xetduyet_controller.dart';
import 'package:salesoft_hrm/widgets/dialog_thanhcong.dart';
import 'package:salesoft_hrm/widgets/dialog_thatbai.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

Future<void> confirmDuyet(int id) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? ma = pref.getString('ma');

  if (ma != null) {
    final url =
        'https://apihrm.pmcweb.vn/api/XetDuyet/XacNhanDuyet?Id=$id&Ma=$ma';
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'accept': '*/*',
      },
    );

    final responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      print(responseData['message']);
      Get.find<XetDuyetController>().fetchListContent();
      Get.find<DaDuyetController>().fetchListContent();

      Get.dialog(
        thongBaoDialog(
          text: responseData['message'] ?? 'Xét duyệt thành công.',
        ),
      );
    } else if (response.statusCode == 400) {
      Get.dialog(
        thongBaoDialog2(
          text: responseData['message'] ?? 'Xét duyệt không thành công.',
        ),
      );
      print('Error: ${response.statusCode}');
    } else {
      Get.dialog(
        thongBaoDialog(
          text: 'Lỗi kết nối đến server',
        ),
      );
      print('Error: ${response.statusCode}');
    }
  } else {
    Get.dialog(
      thongBaoDialog(
        text: 'Không tìm thấy mã trong SharedPreferences',
      ),
    );
    print('Không tìm thấy mã trong SharedPreferences');
  }
}

Future<void> confirmKhongDuyet(int id, String noiDung) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? ma = pref.getString('ma');

  if (ma != null) {
    final url =
        'https://apihrm.pmcweb.vn/api/XetDuyet/XacNhanHuyDuyet?Id=$id&Ma=$ma&NoiDung=$noiDung';
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'accept': '*/*',
      },
    );

    final responseData = json.decode(response.body);

    // In giá trị id, ma và noiDung
    print('ID: $id');
    print('Mã: $ma');
    print('Nội dung từ chối: $noiDung');

    if (response.statusCode == 200) {
      print(responseData['message']);
      Get.find<XetDuyetController>().fetchListContent();
      Get.find<DaDuyetController>().fetchListContent();

      Get.dialog(
        thongBaoDialog(
          text: responseData['message'] ?? 'Từ chối xét duyệt thành công.',
        ),
      );
    } else if (response.statusCode == 400) {
      Get.dialog(
        thongBaoDialog2(
          text:
              responseData['message'] ?? 'Từ chối xét duyệt không thành công.',
        ),
      );
      print('Error: ${response.statusCode}');
    } else {
      Get.dialog(
        thongBaoDialog(
          text: 'Lỗi kết nối đến server',
        ),
      );
      print('Error: ${response.statusCode}');
    }
  } else {
    Get.dialog(
      thongBaoDialog(
        text: 'Không tìm thấy mã trong SharedPreferences',
      ),
    );
    print('Không tìm thấy mã trong SharedPreferences');
  }
}
