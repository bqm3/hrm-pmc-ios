import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/API/provider/danhba_dt/Qtluong_detail_provider.dart';
import 'package:salesoft_hrm/API/provider/danhba_dt/congtac_detail_provider.dart';
import 'package:salesoft_hrm/API/provider/danhba_dt/congtactr_detail_provider.dart';
import 'package:salesoft_hrm/API/repository/danhba_dt/Qtluong_dt_repository.dart';
import 'package:salesoft_hrm/API/repository/danhba_dt/congtac_detail_repository.dart';
import 'package:salesoft_hrm/API/repository/danhba_dt/congtactr_detail_repository.dart';
import 'package:salesoft_hrm/model/NSCongtac_model.dart';
import 'package:salesoft_hrm/model/ns_congtactr.dart';

class CongtacDtController extends GetxController with StateMixin<NsCongtac> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  NsCongtac? contentDisplay;
  NsCongtac? originalContentDisplay;
  int pageIndex = 1;
  int pageSize = 10;
  late String ma = '';

  final CongTacDtRepository _congtacRepository =
      CongTacDtRepository(provider: CongTacDtProviderAPI());

  @override
  void onInit() {
    super.onInit();
    fetchMaAndListContent();
  }

  Future<void> fetchMaAndListContent() async {
    final args = Get.arguments as Map<String, dynamic>;
    ma = args['ma'] as String;

    fetchListContent();
  }

  void fetchListContent({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      pageIndex = 1;
      contentDisplay = null;
      refreshController.resetNoData();
    }

    final result = await _congtacRepository.getCongTacDt(
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
}

class CongTacTrDtController extends GetxController
    with StateMixin<NsCongtactr> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  NsCongtactr? contentDisplay;
  NsCongtactr? originalContentDisplay;
  int pageIndex = 1;
  int pageSize = 10;
  late String ma = '';

  final CongTacTrDtRepository _congtactrRepository =
      CongTacTrDtRepository(provider: CongTacTrDtProviderAPI());

  @override
  void onInit() {
    super.onInit();
    fetchMaAndListContent();
  }

  Future<void> fetchMaAndListContent() async {
    final args = Get.arguments as Map<String, dynamic>;
    ma = args['ma'] as String;

    fetchListContent();
  }

  void fetchListContent({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      pageIndex = 1;
      contentDisplay = null;
      refreshController.resetNoData();
    }

    final result = await _congtactrRepository.getCongTacTrDt(
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
}
