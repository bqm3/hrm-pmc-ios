import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/API/provider/xetduyet_provider.dart';
import 'package:salesoft_hrm/API/repository/xetduyet_repository.dart';
import 'package:salesoft_hrm/model/xetduyet_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class XetDuyetController extends GetxController
    with StateMixin<List<XetDuyet>> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  var contentDisplay = <XetDuyet>[].obs;
  var originalContentDisplay = <XetDuyet>[].obs;
  int pageIndex = 1;
  int pageSize = 10;
  String tinhTrang = '0';
  String? loai;
  late String ma;

  final XetDuyetRepository _xetDuyetRepository =
      XetDuyetRepository(provider: XetDuyetProviderAPI());

  @override
  void onInit() async {
    super.onInit();
    await fetchMaAndListContent();
  }

  Future<void> fetchMaAndListContent() async {
    final prefs = await SharedPreferences.getInstance();
    ma = prefs.getString('ma') ?? '';

    if (ma.isNotEmpty) {
      fetchListContent();
    } else {
      change(null, status: RxStatus.error('Không lấy được mã người dùng'));
    }
  }

  void fetchListContent({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      pageIndex = 1;
      contentDisplay.clear();
      refreshController.resetNoData();
    }

    final result = await _xetDuyetRepository.getXetDuyet(
        tinhTrang: tinhTrang, loai: loai ?? '');

    print('Kết quả API: $result');

    if (result != null && result.isNotEmpty) {
      Map<String, List<XetDuyet>> groupedContent = {};
      for (var item in result) {
        String dateKey = item.ngay ?? '';
        if (!groupedContent.containsKey(dateKey)) {
          groupedContent[dateKey] = [];
        }
        groupedContent[dateKey]!.add(item);
      }

      if (isLoadMore) {
        contentDisplay.addAll(result);
      } else {
        originalContentDisplay.assignAll(result);
        contentDisplay.assignAll(result);
      }

      refreshController.loadComplete();
      pageIndex += 1;

      if (contentDisplay.isEmpty) {
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
