import 'package:salesoft_hrm/API/provider/nghiphep_detail_provider.dart';
import 'package:salesoft_hrm/model/nghiphepchitiet_model.dart';

abstract class INghiPhepDetailRepository {
  Future<List<NghiPhepDetail>?> getNghiPhepDetail({
    required int id,
    required String thang,
    required String nam,
  });
}

class NghiPhepDetailRepository implements INghiPhepDetailRepository {
  final INghiPhepDetailProvider provider;
  NghiPhepDetailRepository({
    required this.provider,
  });
  @override
  Future<List<NghiPhepDetail>?> getNghiPhepDetail(
      {required int id, required String thang, required String nam}) async {
    try {
      final response =
          await provider.getNghiPhepDetail(id: id, thang: thang, nam: nam);
      if (response != null) {
        if (response is List) {
          return response.map((item) => NghiPhepDetail.fromJson(item)).toList();
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
