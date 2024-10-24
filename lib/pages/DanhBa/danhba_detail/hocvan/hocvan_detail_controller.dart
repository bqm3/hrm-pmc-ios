import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/API/provider/danhba_dt/hocvan_detail_provider.dart';
import 'package:salesoft_hrm/API/repository/danhba_dt/hocvan_dt_repository.dart';
import 'package:salesoft_hrm/model/hocvan_model.dart';

class hocvanDetailController extends GetxController with StateMixin<hocvan> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  hocvan? contentDisplay;
  hocvan? originalContentDisplay;
  int pageIndex = 1;
  int pageSize = 10;
  late String ma = '';

  final HocVanDtRepository _hocvanRepository =
      HocVanDtRepository(provider: HocVanDtProviderAPI());

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

    final result = await _hocvanRepository.getHocVanDt(
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
