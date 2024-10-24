import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/API/provider/lichdaotao_provider.dart';
import 'package:salesoft_hrm/API/repository/lichdaotao_repository.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/model/lichdaotao_model.dart';

class LichDaoTaoController extends GetxController with StateMixin<LichDaoTao> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  LichDaoTao? contentDisplay;
  LichDaoTao? originalContentDisplay;
  int pageIndex = 1;
  int pageSize = 10;
  late String ma;
  var filterTinhTrang = ''.obs;
  final LichDaoTaoRepository _lichDaoTaoRepository =
      LichDaoTaoRepository(provider: LichDaoTaoProviderAPI(AuthService()));

  @override
  void onInit() {
    super.onInit();
    fetchMaAndListContent();
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

    final result = await _lichDaoTaoRepository.getLichDaoTao(
      pageSize: pageSize,
      pageIndex: pageIndex,
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
        contentDisplay = LichDaoTao(
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
    print('Giá trị filterTinhTrang: ${filterTinhTrang.value}');
    fetchListContent();
  }
}
