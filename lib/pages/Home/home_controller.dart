import 'package:get/get.dart';
import 'package:salesoft_hrm/API/provider/NS_Update_provider.dart';
import 'package:salesoft_hrm/API/provider/nhansu_provider.dart';
import 'package:salesoft_hrm/API/repository/NS_Infomation.dart';
import 'package:salesoft_hrm/API/repository/NS_Update_repository.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';

class HomeController extends GetxController {
  final NSInfoRepository _nsInfoRepository =
      NSInfoRepository(provider: NhanSuInfoProviderAPI(AuthService()));
  final NSUpdateInfoRepository _nsUpdateInfoRepository =
      NSUpdateInfoRepository(provider: NSUpdateAPI(AuthService()));

  var hoDem = ''.obs;
  var ten = ''.obs;
  var gioiTinh = ''.obs;
  var kh = ''.obs;
  var chucVu = ''.obs;
  var donVi = ''.obs;
  var phongBan = ''.obs;
  var ngaySinh = ''.obs;
  var soHd = ''.obs;
  var ngayKyHd = ''.obs;
  var dcll = ''.obs;
  var dienThoai = ''.obs;
  var email = ''.obs;
  var toCongTac = ''.obs;
  var cmt = ''.obs;
  var ngayCmt = ''.obs;
  var noiCmt = ''.obs;
  var taiKhoan = ''.obs;
  var nganHang = ''.obs;
  var ma = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    try {
      final maValue = await AuthService().ma;
      if (maValue != null && maValue.isNotEmpty) {
        ma.value = maValue;
        final nsInfo = await _nsInfoRepository.getNhanSuInfo(ma: maValue);
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
        donVi.value = nsInfo.donVi ?? '';
        email.value = nsInfo.email ?? '';
        toCongTac.value = nsInfo.toCongTac ?? '';
        cmt.value = nsInfo.cmt ?? '';
        ngayCmt.value = nsInfo.ngayCmt ?? '';
        noiCmt.value = nsInfo.noiCmt ?? '';
        taiKhoan.value = nsInfo.taiKhoan ?? '';
        nganHang.value = nsInfo.nganHang ?? '';
      }
    } catch (e) {
      print('Error fetching user info: $e');
    }
  }

  Future<void> updateUserInfo(String cot, String duLieu) async {
    try {
      final response = await _nsUpdateInfoRepository.NSUpdateAPI(
        cot: cot,
        duLieu: duLieu,
      );

      print('Update response: ${response.toString()}');
    } catch (e) {
      print('Error updating user info: $e');
    }
  }

  void resetUserInfo() {
    hoDem.value = '';
    ten.value = '';
    gioiTinh.value = '';
    kh.value = '';
    chucVu.value = '';
    donVi.value = '';
    phongBan.value = '';
    ngaySinh.value = '';
    soHd.value = '';
    ngayKyHd.value = '';
    dcll.value = '';
    dienThoai.value = '';
    email.value = '';
    toCongTac.value = '';
    cmt.value = '';
    ngayCmt.value = '';
    noiCmt.value = '';
    taiKhoan.value = '';
    nganHang.value = '';
  }

  String getChucVu() {
    return chucVu.value;
  }
}
