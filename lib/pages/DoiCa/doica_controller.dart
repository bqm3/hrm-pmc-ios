import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/API/repository/doica_repository.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/model/calamviec2_model.dart';
import 'package:salesoft_hrm/model/doica_model.dart';
import 'package:salesoft_hrm/widgets/dialog_thatbai.dart';

class DoiCaController extends GetxController with StateMixin<DoiCaResponse> {
  var newShiftOptions = <CaLamViec2>[].obs;

  final authService = Get.find<AuthService>();
  String ma = '';
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  DoiCaResponse? contentDisplay;
  DoiCaResponse? originalContentDisplay;
  int pageIndex = 1;
  int pageSize = 30;
  String thang = '';
  String tinhtrang = '10';
  String nam = '';

  final IDoiCaRepository _repository = Get.find();

  List<DoiCa>? get chamCongList => contentDisplay?.items;

  @override
  void onInit() {
    super.onInit();
    _loadMa();
  }

  Future<void> _loadMa() async {
    ma = await authService.ma ?? '';
    fetchNewShiftOptions();
    fetchListContent();
  }

  void updateTinhTrang(String newTinhTrang) {
    if (tinhtrang != newTinhTrang) {
      tinhtrang = newTinhTrang;

      fetchListContent();
    }
  }

  Future<List<CaLamViec4>> fetchShiftList(String ma, String ngay) async {
    print('Calling fetchShiftList with ma: $ma, ngay: $ngay');

    final response = await http.get(
      Uri.parse(
          'https://apihrm.pmcweb.vn/api/CaLamViec/GetCaLamViecByNgay?Ngay=$ngay&Ma=$ma'),
      headers: {'accept': 'application/json'},
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);

      if (jsonResponse is Map) {
        print('Response is a Map');

        Map<String, dynamic> responseMap = jsonResponse as Map<String, dynamic>;

        return [CaLamViec4.fromJson(responseMap)];
      }
    }

    return [];
  }

  Future<void> fetchNewShiftOptions() async {
    final response = await http.get(
      Uri.parse(
          'https://apihrm.pmcweb.vn/api/CaLamViec/GetList?pageIndex=1&pageSize=20'),
      headers: {'accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> items = data['data'];
      newShiftOptions.value =
          items.map((item) => CaLamViec2.fromJson(item)).toList();
    } else {}
  }

  void fetchListContent({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      pageIndex = 1;
      contentDisplay = null;
      refreshController.resetNoData();
    }

    final result = await _repository.getDoiCa(
      pageSize: pageSize,
      pageIndex: pageIndex,
      thang: thang,
      nam: nam,
      tinhtrang: tinhtrang,
    );

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
