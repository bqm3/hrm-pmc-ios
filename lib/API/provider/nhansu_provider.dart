import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/url_helper.dart';
import 'package:salesoft_hrm/model/NSInfo_model.dart';

abstract class INhanSuInfoProvider {
  Future<NsInfo?> getNhanSuInfo({required String ma});
}

class NhanSuInfoProviderAPI implements INhanSuInfoProvider {
  final AuthService authService;

  NhanSuInfoProviderAPI(this.authService);

  @override
  Future<NsInfo?> getNhanSuInfo({required String ma}) async {
    final maFromPrefs = await authService.ma;
    if (maFromPrefs != null) {
      final urlEndPoint = "${URLHelper.NS_Information}?Ma=$maFromPrefs";
      try {
        final response = await HttpUtil().get(urlEndPoint);
        if (response != null && response is Map<String, dynamic>) {
          return NsInfo.fromJson(response);
        } else {
          print('Invalid response format: $response');
          return null;
        }
      } catch (error) {
        print('Error fetching Nhan Su info: $error');
        return null;
      }
    } else {
      print('User not logged in');
      return null;
    }
  }
}
