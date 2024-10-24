import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/url_helper.dart';

abstract class ILuongDtProvider {
  Future<dynamic> getLuongDt(
      {required String ma, required int pageSize, required int pageIndex});
}

class LuongDtProviderAPI implements ILuongDtProvider {
  LuongDtProviderAPI();
  @override
  Future<dynamic> getLuongDt(
      {required String ma,
      required int pageSize,
      required int pageIndex}) async {
    final urlEndPoint =
        "${URLHelper.NS_qlLuong}?PageSize=$pageSize&PageIndex=$pageIndex&Ma=$ma";
    return await HttpUtil().get(urlEndPoint);
  }
}
