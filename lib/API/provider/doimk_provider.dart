import 'package:http/http.dart' as http;
import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/url_helper.dart';

abstract class DMDoiMK {
  Future<http.Response> doiMK({
    required String currentPass,
    required String newPass,
  });
}

class NSDoiMK implements DMDoiMK {
  final AuthService authService;

  NSDoiMK(this.authService);

  @override
  Future<http.Response> doiMK({
    required String currentPass,
    required String newPass,
  }) async {
    final maFromPrefs = await authService.ma;
    final urlEndPoint =
        "${URLHelper.DM_DOIMK}?Ma=$maFromPrefs&CurrentPass=$currentPass&NewPass=$newPass";

    return await HttpUtil().put2(urlEndPoint);
  }
}
