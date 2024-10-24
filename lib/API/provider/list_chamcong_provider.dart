

import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/url_helper.dart';

abstract class IListChamCongProvider {
  Future<dynamic> getListChamCong();
}

class ListChamCongProviderAPI implements IListChamCongProvider {
  final AuthService authService;

  ListChamCongProviderAPI(this.authService);

  @override
  Future<dynamic> getListChamCong() async {
    final maFromPrefs = await authService.ma;
    final urlEndPoint = "${URLHelper.NS_ListChamCong}?Ma=$maFromPrefs";
    return await HttpUtil().get(urlEndPoint);
  }
}

