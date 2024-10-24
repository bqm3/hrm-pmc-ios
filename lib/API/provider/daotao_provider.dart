import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/url_helper.dart';

abstract class IDaoTaoProvider {
  Future<dynamic> getDaoTao(
      {required String ma,required String thang,required String nam});
}

class DaoTaoProviderAPI implements IDaoTaoProvider {
  final AuthService authService;

  DaoTaoProviderAPI(this.authService);
  @override
  Future<dynamic> getDaoTao(
      {required String ma,required String thang,required String nam}) async {
    final maFromPrefs = await authService.ma;

    final urlEndPoint =
        "${URLHelper.NS_DaoTao}?Ma=$maFromPrefs&Thang=$thang&Nam=$nam";
    return await HttpUtil().get(urlEndPoint);
  }
}
