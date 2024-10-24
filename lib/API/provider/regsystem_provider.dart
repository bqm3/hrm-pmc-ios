import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/url_helper.dart';

abstract class IRegsystemProvider {
  Future<dynamic> getRegsystem({required String code});
}

class RegsystemProviderAPI implements IRegsystemProvider {
  RegsystemProviderAPI();
  @override
  Future<dynamic> getRegsystem({required String code}) async {
    final urlEndPoint = "${URLHelper.DM_Regsystem}?Code=$code";
    return await HttpUtil().get(urlEndPoint);
  }
}
