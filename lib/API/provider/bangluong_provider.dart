import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/url_helper.dart';

abstract class IBangLuongProvider {
  Future<dynamic> getBangLuong({required String thang,required String nam,required String ma});
}

class BangLuongProviderAPI implements IBangLuongProvider {
  final AuthService authService;

  BangLuongProviderAPI(this.authService);
  @override
  Future<dynamic> getBangLuong({required String thang,required String nam,required String ma}) async {
    final maFromPrefs = await authService.ma;

    final urlEndPoint =
        "${URLHelper.NS_BangLuong}?Thang=$thang&Nam=$nam&Ma=$maFromPrefs";
    return await HttpUtil().get(urlEndPoint);
  }
}
