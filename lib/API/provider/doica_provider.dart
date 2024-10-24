import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/url_helper.dart';

abstract class IDoiCaProvider {
  Future<dynamic> getDoiCa(
      {required String thang,
      required String nam,
      required String tinhtrang,
      required int pageSize,
      required int pageIndex});
}

class DoiCaProviderAPI implements IDoiCaProvider {
  final AuthService authService;

  DoiCaProviderAPI(this.authService);

  @override
  Future<dynamic> getDoiCa(
      {required String thang,
      required String nam,
      String tinhtrang = '10',
      required int pageSize,
      required int pageIndex}) async {
    final maFromPrefs = await authService.ma;
    print('TinhTrang: $tinhtrang');
    final urlEndPoint =
        "${URLHelper.NS_DoiCa}?PageIndex=$pageIndex&PageSize=$pageSize&Ma=$maFromPrefs&Thang=$thang&Nam=$nam&TinhTrang=$tinhtrang";

    return await HttpUtil().get(urlEndPoint);
  }
}
