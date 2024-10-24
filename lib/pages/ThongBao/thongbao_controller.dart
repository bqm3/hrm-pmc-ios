import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/API/repository/thongbao_repository.dart';
import 'package:salesoft_hrm/model/thongbao_model.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';

class ThongBaoController extends GetxController with StateMixin<ThongBao?> {
  final IThongBaoRepository repository;
  final AuthService _authService;
  ThongBaoController(
      {required this.repository, required AuthService authService})
      : _authService = authService;

  final RefreshController refreshController = RefreshController();

  @override
  void onInit() {
    fetchListContent();
    super.onInit();
  }

  void fetchListContent() async {
    try {
      change(null, status: RxStatus.loading());
      final thongBao = await repository.getThongBao(pageSize: 10, pageIndex: 1);
      if (thongBao == null) {
        change(null, status: RxStatus.empty());
      } else {
        change(thongBao, status: RxStatus.success());
      }
    } catch (error) {
      change(null, status: RxStatus.error('Failed to fetch data'));
    }
  }

  Future<void> markAsRead(String tieuDe, String noiDung) async {
    String? ma = await _authService.ma;

    if (ma != null) {
      final response = await http.post(
        Uri.parse(
            'https://apihrm.pmcweb.vn/api/ThongBao/MarkRead?TieuDe=$tieuDe&NoiDung=$noiDung&Ma=$ma'),
        headers: {'accept': '*/*'},
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print(result['message']);
      } else {
        print('Error: ${response.statusCode}');
      }
    } else {
      print('Không tìm thấy mã nhân viên.');
    }
  }

  Future<void> markAsRead2() async {
    String? ma = await _authService.ma;

    if (ma != null) {
      final response = await http.post(
        Uri.parse('https://apihrm.pmcweb.vn/api/ThongBao/MarkReadAll?Ma=$ma'),
        headers: {'accept': '*/*'},
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print(result['message']);
      } else {
        print('Error: ${response.statusCode}');
      }
    } else {
      print('Không tìm thấy mã nhân viên.');
    }
  }
}
