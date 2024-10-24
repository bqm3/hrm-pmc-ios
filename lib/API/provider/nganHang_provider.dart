  import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/url_helper.dart';

abstract class INganHangProvider {
  Future<dynamic> getNganHang(
      {required String table});
}

class NganHangProviderAPI implements INganHangProvider {

  NganHangProviderAPI();

  @override
  Future<dynamic> getNganHang(
      {required String table,}) async {

    const urlEndPoint =
        "${URLHelper.DM_LoaiNghi}?Table=DM_NganHang";

    return await HttpUtil().get(urlEndPoint);
  }
}
