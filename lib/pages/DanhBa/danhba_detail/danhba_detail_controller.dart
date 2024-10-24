import 'package:get/get.dart';
import 'package:salesoft_hrm/API/provider/danhba_dt/danhba_detail_provider.dart';
import 'package:salesoft_hrm/API/repository/danhba_dt/danhba_dt_repository.dart';

class DtController extends GetxController {
  final NSInfoDtRepository _dtRepository =
      NSInfoDtRepository(provider: NhanSuInfoDtProviderAPI());

  var hoDem = ''.obs;
  var ten = ''.obs;
  var gioiTinh = ''.obs;
  var kh = ''.obs;
  var chucVu = ''.obs;
  var phongBan = ''.obs;
  var donVi=''.obs;
  var ngaySinh = ''.obs;
  var soHd = ''.obs;
  var ngayKyHd = ''.obs;
  var dcll = ''.obs;
  var dienThoai = ''.obs;
  var email = ''.obs;
  var toCongTac = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchUserInfo(String ma) async {
    try {
      final nsInfo = await _dtRepository.getNhanSuInfoDt(ma: ma);
      hoDem.value = nsInfo.hoDem ?? '';
      ten.value = nsInfo.ten ?? '';
      gioiTinh.value = nsInfo.gioiTinh ?? '';
      kh.value = nsInfo.kh ?? '';
      chucVu.value = nsInfo.chucVu ?? '';
      phongBan.value = nsInfo.phongBan ?? '';
      ngaySinh.value = nsInfo.ngaySinh ?? '';
      soHd.value = nsInfo.soHd ?? '';
      ngayKyHd.value = nsInfo.ngayKyHd ?? '';
      dcll.value = nsInfo.dcll ?? '';
      dienThoai.value = nsInfo.dienThoai ?? '';
      email.value = nsInfo.email ?? '';
      toCongTac.value = nsInfo.toCongTac ?? '';
      donVi.value=nsInfo.donVi??'';
    } catch (e) {
      print('Error fetching user info: $e');
    }
  }
}
