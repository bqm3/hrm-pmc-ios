
import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/url_helper.dart';

abstract class IDiaDiemProvider {
  Future<dynamic> getDiaDiem();
}

class DiaDiemProviderAPI implements IDiaDiemProvider {
  final AuthService authService;

  DiaDiemProviderAPI(this.authService);

  @override
  Future<dynamic> getDiaDiem() async {
    final maFromPrefs = await authService.ma;

    final urlEndPoint =
        "${URLHelper.DM_DiaDiem}?Ma=$maFromPrefs";

    return await HttpUtil().get(urlEndPoint);
  }
}
