import 'package:salesoft_hrm/API/provider/nhansu_provider.dart';
import 'package:salesoft_hrm/model/NSInfo_model.dart';

abstract class INSInfoRepository {
  Future<NsInfo> getNhanSuInfo({
    required String ma,
  });
}
class NSInfoRepository implements INSInfoRepository {
  final INhanSuInfoProvider provider;

  NSInfoRepository({
    required this.provider,
  });

  @override
  Future<NsInfo> getNhanSuInfo({required String ma}) async {
    try {
      final response = await provider.getNhanSuInfo(ma: ma);
      if (response != null) {
        return response;
      } else {
        throw Exception('No data received from API');
      }
    } catch (error) {
      print('Error during API call: $error');
      throw Exception('Error during API call: $error');
    }
  }
}
