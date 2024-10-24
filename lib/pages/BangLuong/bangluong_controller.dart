import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/API/provider/bangluong_provider.dart';
import 'package:salesoft_hrm/API/repository/bangluong_repository.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/model/bangluong_model.dart';

class BangLuongController extends GetxController
    with StateMixin<List<BangLuong>> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  // Sử dụng biến quan sát
  var contentDisplay = <BangLuong>[].obs;
  var originalContentDisplay = <BangLuong>[].obs;
  int pageIndex = 1;
  int pageSize = 10;
  late String ma;
  late String thang;
  late String nam;

  final BangLuongRepository _bangLuongRepository =
      BangLuongRepository(provider: BangLuongProviderAPI(AuthService()));

  @override
  void onInit() {
    super.onInit();
    DateTime now = DateTime.now();
    thang = now.month.toString().padLeft(2, '0');
    nam = now.year.toString();
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
    if (ma.isEmpty) {
      change(null, status: RxStatus.error('Mã người dùng chưa được khởi tạo'));
      return;
    }

    if (!isLoadMore) {
      pageIndex = 1;
      contentDisplay.clear();
      refreshController.resetNoData();
      change(null, status: RxStatus.loading());
    }

    try {
      final result = await _bangLuongRepository.getBangLuong(
        thang: thang,
        nam: nam,
        ma: ma,
      );

      print('Kết quả API: $result');

      if (result != null && result.isNotEmpty) {
        contentDisplay.assignAll(result);
        refreshController.loadComplete();
        pageIndex += 1;
        change(contentDisplay, status: RxStatus.success());
      } else {
        if (isLoadMore) {
          refreshController.loadNoData();
        } else {
          change(null, status: RxStatus.empty());
        }
      }
    } catch (error) {
      print('Lỗi khi gọi API: $error');
      change(null, status: RxStatus.error('Có lỗi xảy ra khi tải dữ liệu'));
    }
  }
}
