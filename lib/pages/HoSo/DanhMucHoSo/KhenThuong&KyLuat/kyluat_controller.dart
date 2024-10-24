import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/API/provider/khenthuong_provider.dart';
import 'package:salesoft_hrm/API/repository/khenthuong_repository.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/model/kyluat_model.dart';

class KyLuatController extends GetxController with StateMixin<Kyluat> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  Kyluat? contentDisplay;
  Kyluat? originalContentDisplay;
  int pageIndex = 1;
  int pageSize = 1;
  late String ma;

  final KyLuatRepository _kyluatRepository =
      KyLuatRepository(provider: KyLuatProviderAPI(AuthService()));

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

    final result = await _kyluatRepository.getKyLuat(
      pageSize: pageSize,
      pageIndex: pageIndex,
      ma: ma,
    );

    print('Kết quả API: $result');

    if (result is Kyluat) {
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
