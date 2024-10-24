import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/url_helper.dart';

abstract class IQuanHeProvider {
  Future<dynamic> getQuanHe(
      {required String ma, required int pageSize, required int pageIndex});
}

class QuanHeProviderAPI implements IQuanHeProvider {
  final AuthService authService;

  QuanHeProviderAPI(this.authService);
  @override
  Future<dynamic> getQuanHe(
      {required String ma,
      required int pageSize,
      required int pageIndex}) async {
    final maFromPrefs = await authService.ma;

    final urlEndPoint =
        "${URLHelper.NS_quanhe}?PageSize=$pageSize&PageIndex=$pageIndex&Ma=$maFromPrefs";
    return await HttpUtil().get(urlEndPoint);
  }
}
