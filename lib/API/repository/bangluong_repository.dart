import 'package:salesoft_hrm/API/provider/bangluong_provider.dart';
import 'package:salesoft_hrm/model/bangluong_model.dart';

abstract class IBangLuongRepository {
  Future<List<BangLuong>?> getBangLuong({
    required String thang,
    required String nam,
    required String ma,
  });
}

class BangLuongRepository implements IBangLuongRepository {
  final IBangLuongProvider provider;
  BangLuongRepository({
    required this.provider,
  });
  @override
  Future<List<BangLuong>?> getBangLuong(
      {required String thang, required String nam, required String ma}) async {
    try {
      final response =
          await provider.getBangLuong(thang: thang, nam: nam, ma: ma);
      if (response != null) {
        if (response is List) {
          return response.map((item) => BangLuong.fromJson(item)).toList();
        } else {
          throw Exception('Invalid response format');
        }
      }
    } catch (onError) {
      print('Error during API call: $onError');
      return null;
    }
    return null;
  }
}
