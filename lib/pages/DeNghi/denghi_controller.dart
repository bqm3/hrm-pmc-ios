import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/API/provider/denghi_provider.dart';
import 'package:salesoft_hrm/API/repository/denghi_repository.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/model/denghi_model.dart';

class DeNghiController extends GetxController with StateMixin<DeNghi> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  DeNghi? contentDisplay;
  DeNghi? originalContentDisplay;
  int pageIndex = 1;
  int pageSize = 30;
  late String ma;
  String thang = '';
  String nam = '';
  var filterTinhTrang = ''.obs; 
  String tinhTrang = ''; 

  final DeNghiRepository _listNghiPhepRepository =
      DeNghiRepository(provider: DeNghiProviderAPI(AuthService()));

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

    final result = await _listNghiPhepRepository.getDeNghi(
        pageSize: pageSize, pageIndex: pageIndex, thang: thang, nam: nam);

    if (result != null) {
      if (isLoadMore) {
        contentDisplay?.data?.addAll(result.data ?? []);
      } else {
        originalContentDisplay = result;

        if (filterTinhTrang.value.isNotEmpty) {
          contentDisplay = DeNghi(
            data: result.data
                ?.where((item) =>
                    item.tinhTrang.toString() == filterTinhTrang.value)
                .toList(),
            pageSize: result.pageSize,
            pageIndex: result.pageIndex,
            totalRecords: result.totalRecords,
            totalPages: result.totalPages,
          );
        } else {
          contentDisplay = result;
        }
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
