import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/url_helper.dart';

abstract class ILichDaoTaoProvider {
  Future<dynamic> getLichDaoTao(
      {required String ma, required int pageSize, required int pageIndex});
}

class LichDaoTaoProviderAPI implements ILichDaoTaoProvider {
  final AuthService authService;

  LichDaoTaoProviderAPI(this.authService);
  @override
  Future<dynamic> getLichDaoTao(
      {required String ma,
      required int pageSize,
      required int pageIndex}) async {
    final maFromPrefs = await authService.ma;

    final urlEndPoint =
        "${URLHelper.NS_ListDaoTao}?PageIndex=$pageIndex&Pagéize=$pageSize&Ma=$maFromPrefs";
    return await HttpUtil().get(urlEndPoint);
  }
}
