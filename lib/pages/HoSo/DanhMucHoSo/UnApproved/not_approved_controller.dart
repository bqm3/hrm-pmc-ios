import 'package:get/get.dart';
import 'package:salesoft_hrm/API/provider/not_approved_provider.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/repository/not_approved_repository.dart';

class ApprovedController extends GetxController {
  final ApprovedRepository _approvedRepository =
      ApprovedRepository(provider: ApprovedProviderAPI(AuthService()));
  final ApprovedRepository _notapprovedRepository =ApprovedRepository(provider:  ApprovedProviderAPI(AuthService()));

  var hoTen = ''.obs;
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
  var ngayCmt=''.obs;
  var noiCmt=''.obs;
  var taiKhoan=''.obs;
  var nganHang=''.obs;
  var noiSinh=''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    try {
      final ma = await AuthService().ma;
      if (ma != null) {
        final nsInfo = await _approvedRepository.getNotApproved(ma: ma);
        hoTen.value = nsInfo.nhanSu ?? '';
        gioiTinh.value = nsInfo.gioiTinh ?? '';
        noiSinh.value=nsInfo.noiSinh ?? '';
        ngaySinh.value = nsInfo.ngaySinh ?? '';
        dcll.value = nsInfo.dcll ?? '';
        dienThoai.value = nsInfo.dienThoai ?? '';
        email.value = nsInfo.email ?? '';
        cmt.value=nsInfo.cmt ?? '';
        ngayCmt.value=nsInfo.ngayCmt ?? '';
        noiCmt.value=nsInfo.noiCmt ?? '';
        taiKhoan.value=nsInfo.taiKhoan ?? '';
        nganHang.value=nsInfo.nganHang ?? '';
      }
    } catch (e) {
      print('Error fetching user info: $e');
    }
  }
}