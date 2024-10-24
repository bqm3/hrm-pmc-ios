import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/url_helper.dart';

abstract class IDanhBaProvider {
  Future<dynamic> getDanhBa({required int pageSize, required int pageIndex});
}

class DanhBaProviderAPI implements IDanhBaProvider {
  @override
  Future<dynamic> getDanhBa(
      {required int pageSize, required int pageIndex}) async {
    final urlEndPoint =
        "${URLHelper.Nhan_Su}?PageSize=$pageSize&PageIndex=$pageIndex";
    return await HttpUtil().get(urlEndPoint);
  }
}
