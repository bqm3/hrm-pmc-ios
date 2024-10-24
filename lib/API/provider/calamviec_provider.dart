import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/url_helper.dart';

abstract class ICaLamProvider {
  Future<dynamic> getCaLam();
}

class CaLamProviderAPI implements ICaLamProvider {
  final AuthService authService;

  CaLamProviderAPI(this.authService);

  @override
  Future<dynamic> getCaLam() async {
    final maFromPrefs = await authService.ma;

    final urlEndPoint = "${URLHelper.DM_CaLam}?Ma=$maFromPrefs";

    return await HttpUtil().get(urlEndPoint);
  }
}
