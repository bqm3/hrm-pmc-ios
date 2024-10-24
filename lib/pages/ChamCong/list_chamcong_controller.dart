import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/API/repository/list_chamcong_repository.dart';
import 'package:salesoft_hrm/model/list_chamcong_model.dart';

class ListChamCongController extends GetxController
    with StateMixin<ListChamCongResponse> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  ListChamCongResponse? contentDisplay;
  ListChamCongResponse? originalContentDisplay;
  int pageIndex = 1;
  int pageSize = 1;

  final IListChamCongRepository _repository = Get.find();

  List<ListChamCong>? get chamCongList => contentDisplay?.items;

  @override
  void onInit() {
    super.onInit();
    fetchListContent();
  }

  void removeChamCong(int id) {
    if (contentDisplay != null) {
      contentDisplay!.items.removeWhere((item) => item.id == id);
      if (contentDisplay!.items.isEmpty) {
        change(contentDisplay, status: RxStatus.empty());
      } else {
        change(contentDisplay, status: RxStatus.success());
      }
    }
  }

  void fetchListContent({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      pageIndex = 1;
      contentDisplay = null;
      refreshController.resetNoData();
    }

    final result = await _repository.getListChamCong();

    print('Kết quả API: $result');

    if (result != null) {
      if (isLoadMore) {
        contentDisplay?.items.addAll(result.items);
      } else {
        contentDisplay = result;
        originalContentDisplay = result;
      }

      refreshController.loadComplete();
      pageIndex += 1;
      if (contentDisplay!.items.isEmpty) {
        change(contentDisplay, status: RxStatus.empty());
      } else {
        change(contentDisplay, status: RxStatus.success());
      }
    } else {
      refreshController.loadNoData();
    }
  }
}
