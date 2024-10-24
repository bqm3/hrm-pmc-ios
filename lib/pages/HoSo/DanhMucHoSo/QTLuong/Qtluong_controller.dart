import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/API/provider/Qlluong_provider.dart';
import 'package:salesoft_hrm/API/repository/Qlluong_repository.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/model/Qtluong_model.dart';
import 'package:intl/intl.dart';

class QtLuongController extends GetxController with StateMixin<Qtluong> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  Qtluong? contentDisplay;
  Qtluong? originalContentDisplay;
  int pageIndex = 1;
  int pageSize = 10;
  late String ma;

  final LuongRepository _LuongRepository =
      LuongRepository(provider: LuongProviderAPI(AuthService()));

  var tuNgay = DateTime.now().obs;
  var denNgay = DateTime.now().obs;

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

  void fetchListContent(
      {bool isLoadMore = false, DateTime? fromDate, DateTime? toDate}) async {
    if (!isLoadMore) {
      pageIndex = 1;
      contentDisplay = null;
      refreshController.resetNoData();
    }

    final result = await _LuongRepository.getLuong(
      pageSize: pageSize,
      pageIndex: pageIndex,
      ma: ma,
      fromDate:
          fromDate != null ? DateFormat('yyyy-MM-dd').format(fromDate) : '',
      toDate: toDate != null ? DateFormat('yyyy-MM-dd').format(toDate) : '',
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

  void setTimePeriod(DateTime start, DateTime end) {
    tuNgay.value = start;
    denNgay.value = end;
    fetchListContent(fromDate: start, toDate: end);
  }
}
