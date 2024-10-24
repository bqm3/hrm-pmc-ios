import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/API/provider/daotao_provider.dart';
import 'package:salesoft_hrm/API/repository/daotao_repository.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/model/daotao_model.dart';
import 'package:salesoft_hrm/widgets/dialog_thanhcong.dart';
import 'package:salesoft_hrm/widgets/dialog_thatbai.dart';

class DaoTaoController extends GetxController with StateMixin<DaoTao> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  DaoTao? contentDisplay;
  DaoTao? originalContentDisplay;
  int pageIndex = 1;
  int pageSize = 10;
  late String ma;
  String thang = '';
  String nam = '';
  var filterTinhTrang = ''.obs;
  final DaoTaoRepository _daoTaoRepository =
      DaoTaoRepository(provider: DaoTaoProviderAPI(AuthService()));

  @override
  void onInit() {
    super.onInit();
    fetchMaAndListContent();
  }

  Future<void> registerTrainingClass(String ma, String lopDT) async {
    final url =
        'https://apihrm.pmcweb.vn/api/DaoTao/Create?Ma=$ma&LopDT=$lopDT';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': '*/*',
        },
      );

      if (response.statusCode == 200) {
        Get.dialog(
          thongBaoDialog(text: 'Đăng ký lớp đào tạo thành công'),
        );
        fetchListContent();
      } else if (response.statusCode == 400) {
        final responseBody = json.decode(response.body);

        Get.dialog(
          thongBaoDialog2(
              text:
                  responseBody['message'] ?? "Thông tin nhập vào không hợp lệ"),
        );
      } else if (response.statusCode == 500) {
        Get.dialog(
          thongBaoDialog2(text: 'Lỗi kết nối đến server'),
        );
      } else {
        Get.dialog(
          thongBaoDialog2(text: 'Lỗi kết nối đến server'),
        );
      }
    } catch (e) {
      Get.dialog(
        thongBaoDialog2(text: 'Lỗi kết nối đến server'),
      );
    }
  }

  Future<void> fetchMaAndListContent() async {
    final authService = Get.find<AuthService>();
    ma = (await authService.ma) ?? '';
    if (ma.isNotEmpty) {
      fetchListContent();
    } else {
      change(null, status: RxStatus.error('Không lấy được mã người dùng'));
    }
  }

  void fetchListContent({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      pageIndex = 1;
      contentDisplay = null;
      refreshController.resetNoData();
    }

    final result = await _daoTaoRepository.getDaoTao(
      thang: thang,
      nam: nam,
      ma: ma,
    );

    print('Kết quả API: $result');

    if (result != null) {
      if (isLoadMore) {
        contentDisplay?.data?.addAll(result.data ?? []);
      } else {
        contentDisplay = result;
        originalContentDisplay = result;
      }
      if (filterTinhTrang.value.isNotEmpty) {
        contentDisplay = DaoTao(
          data: result.data
              ?.where(
                  (item) => item.tinhTrang.toString() == filterTinhTrang.value)
              .toList(),
          pageSize: result.pageSize,
          pageIndex: result.pageIndex,
          totalRecords: result.totalRecords,
          totalPages: result.totalPages,
        );
      } else {
        contentDisplay = result;
      }

      refreshController.loadComplete();
      pageIndex += 1;

      if (contentDisplay!.data!.isEmpty) {
        change(contentDisplay, status: RxStatus.empty());
      } else {
        change(contentDisplay, status: RxStatus.success());
      }
    } else {
      if (isLoadMore) {
        refreshController.loadNoData();
      } else {
        change(null, status: RxStatus.empty());
      }
    }
  }

  void onFilterChanged(String newValue) {
    filterTinhTrang.value = newValue;
    print('Giá trị filterTinhTrang: ${filterTinhTrang.value}'); // In ra giá trị
    fetchListContent();
  }
}
