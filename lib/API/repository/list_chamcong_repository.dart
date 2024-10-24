
import 'package:salesoft_hrm/API/provider/list_chamcong_provider.dart';
import 'package:salesoft_hrm/model/list_chamcong_model.dart';

abstract class IListChamCongRepository {
  Future<ListChamCongResponse> getListChamCong();
}

class ListChamCongRepository implements IListChamCongRepository {
  final IListChamCongProvider provider;
  ListChamCongRepository({required this.provider});

  @override
  Future<ListChamCongResponse> getListChamCong() async {
    try {
      final response = await provider.getListChamCong();
      
      if (response is List<dynamic>) {
        return ListChamCongResponse.fromJson(response);
      } else {
        return ListChamCongResponse(items: []);
      }
    } catch (e) {
      print('Error during API call: $e');
      return ListChamCongResponse(items: []);
    }
  }
}


