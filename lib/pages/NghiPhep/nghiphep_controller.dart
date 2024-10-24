import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/API/provider/list_nghiphep_provider.dart';
import 'package:salesoft_hrm/API/repository/list_nghiphep_respository.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/model/list_nghiphep_model.dart';

class NghiPhepController extends GetxController with StateMixin<ListNghiPhep> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  var contentDisplay = Rx<ListNghiPhep?>(null);
  ListNghiPhep? originalContentDisplay;
  int pageIndex = 1;
  int pageSize = 30;
  late String ma;
  String thang = '';
  String nam = '';
  String tinhTrang = '';
  String loaiNghi = '';

  final ListNghiPhepRepository _listNghiPhepRepository =
      ListNghiPhepRepository(provider: ListNghiPhepProviderAPI(AuthService()));

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
      contentDisplay.value = null;
      refreshController.resetNoData();
    }

    final result = await _listNghiPhepRepository.getListNghiPhep(
      ma: ma,
      thang: thang,
      nam: nam,
      pageIndex: pageIndex,
      pageSize: pageSize,
      tinhTrang: tinhTrang,
      loaiNghi: loaiNghi,
    );

    print('Kết quả API: $result');

    if (result != null) {
      if (isLoadMore) {
        contentDisplay.value?.data?.addAll(result.data ?? []);
      } else {
        contentDisplay.value = result;
        originalContentDisplay = result;
      }

      refreshController.loadComplete();
      pageIndex += 1;

      if (contentDisplay.value!.data!.isEmpty) {
        change(contentDisplay.value, status: RxStatus.empty());
      } else {
        change(contentDisplay.value, status: RxStatus.success());
      }
    } else {
      if (isLoadMore) {
        refreshController.loadNoData();
      } else {
        change(null, status: RxStatus.empty());
      }
    }
  }

  Future<void> fetchAllListContent(String? maValue) async {
    if (maValue != null) {
      loaiNghi = maValue;
      pageIndex = 1; // Đặt lại pageIndex khi gọi hàm mới
    } else {
      refreshController
          .resetNoData(); // Đặt lại trạng thái nếu không phải là load more
    }

    final result = await _listNghiPhepRepository.getListNghiPhep(
      ma: ma,
      thang: thang,
      nam: nam,
      pageIndex: pageIndex,
      pageSize: pageSize,
      tinhTrang: tinhTrang,
      loaiNghi: loaiNghi,
    );

    print('Kết quả API cho loại nghỉ $loaiNghi: $result');

    if (result != null) {
      if (contentDisplay == null) {
        contentDisplay.value = result; 
        originalContentDisplay = result; 
      } else {
        contentDisplay.value?.data
            ?.addAll(result.data ?? []); 
      }

      if (contentDisplay.value!.data!.isEmpty) {
        change(contentDisplay.value, status: RxStatus.empty());
      } else {
        change(contentDisplay.value, status: RxStatus.success());
      }

      refreshController.loadComplete(); 
      pageIndex += 1; 
    } else {
      change(null, status: RxStatus.empty());
    }
  }

  void setTinhTrang(String newTinhTrang) {
    tinhTrang = newTinhTrang;
    fetchListContent();
  }

  void fetchListContentWithLoaiNghi(String maValue) {
    loaiNghi = maValue;
    fetchAllListContent(maValue);
  }
}
