import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/QuanHe/loaiquanhe_item.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoaiQuanHeRepository {
  Future<List<LoaiQuanHe>> fetchQuanHeList() async {
    final response = await http.get(
      Uri.parse('https://apihrm.pmcweb.vn/api/DanhMuc/GetList?Table=DM_QuanHe'),
      headers: {'accept': '*/*'},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => LoaiQuanHe.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load quan he');
    }
  }
}

class LoaiQuanHeController extends GetxController {
  final LoaiQuanHeRepository repository;
  var quanHeList = <LoaiQuanHe>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  LoaiQuanHeController(this.repository);

  @override
  void onInit() {
    fetchQuanHeList();
    super.onInit();
  }

  Future<void> fetchQuanHeList() async {
    try {
      isLoading(true);
      final list = await repository.fetchQuanHeList();
      quanHeList.assignAll(list);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
}

class LoaiQuanHeDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoaiQuanHeController controller =
        Get.put(LoaiQuanHeController(LoaiQuanHeRepository()));

    return Obx(() {
      if (controller.isLoading.value) {
        return const CircularProgressIndicator();
      }
      if (controller.errorMessage.isNotEmpty) {
        return Text('Lỗi: ${controller.errorMessage}');
      }

      return DropdownButton<String>(
        hint: const Text('Chọn quan hệ'),
        items: controller.quanHeList.map((LoaiQuanHe quanHe) {
          return DropdownMenuItem<String>(
            value: quanHe.ma,
            child: Text(quanHe.ten),
          );
        }).toList(),
        onChanged: (String? newValue) {
          // Xử lý sự kiện khi người dùng chọn một quan hệ
        },
      );
    });
  }
}
