import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/API/provider/congtac_provider.dart';
import 'package:salesoft_hrm/API/provider/ns_congtactr_provider.dart';
import 'package:salesoft_hrm/API/repository/congtac_repository.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/repository/ns_congtactr_repository.dart';
import 'package:salesoft_hrm/model/NSCongtac_model.dart';
import 'package:salesoft_hrm/model/ns_congtactr.dart';

class CongTacTrController extends GetxController with StateMixin<NsCongtactr> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  NsCongtactr? contentDisplay;
  NsCongtactr? originalContentDisplay;
  int pageIndex = 1;
  int pageSize = 1;
  late String ma;

  final CongTacTrRepository _congTacTrRepository =
      CongTacTrRepository(provider: CongTacTrProviderAPI(AuthService()));

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

    final result = await _congTacTrRepository.getCongTacTr(
      pageSize: pageSize,
      pageIndex: pageIndex,
      ma: ma,
    );

    print('Kết quả API: $result');

    if (result is NsCongtactr) {
      if (isLoadMore) {
        contentDisplay?.data?.addAll(result.data ?? []);
      } else {
        contentDisplay = result;
        originalContentDisplay = result;
      }

      refreshController.loadComplete();
      pageIndex += 1;

      if (contentDisplay!.data!.isEmpty) {
        change(contentDisplay, status: RxStatus.empty());
      } else {
        change(contentDisplay, status: RxStatus.success());
      }
    } else if (result == 'Không có thông tin') {
      change(null, status: RxStatus.empty());
    } else {
      refreshController.loadNoData();
      change(null, status: RxStatus.error(result as String?));
    }
  }
}

class CongTacController extends GetxController with StateMixin<NsCongtac> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  NsCongtac? contentDisplay;
  NsCongtac? originalContentDisplay;
  int pageIndex = 1;
  int pageSize = 1;
  late String ma;

  final CongTacRepository _congTacTrRepository =
      CongTacRepository(provider: CongTacProviderAPI(AuthService()));

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

    final result = await _congTacTrRepository.getCongTac(
      pageSize: pageSize,
      pageIndex: pageIndex,
      ma: ma,
    );

    print('Kết quả API: $result');

    if (result is NsCongtac) {
      if (isLoadMore) {
        contentDisplay?.data?.addAll(result.data ?? []);
      } else {
        contentDisplay = result;
        originalContentDisplay = result;
      }

      refreshController.loadComplete();
      pageIndex += 1;

      if (contentDisplay!.data!.isEmpty) {
        change(contentDisplay, status: RxStatus.empty());
      } else {
        change(contentDisplay, status: RxStatus.success());
      }
    } else if (result == 'Không có thông tin') {
      change(null, status: RxStatus.empty());
    } else {
      refreshController.loadNoData();
      change(null, status: RxStatus.error(result as String?));
    }
  }
}
