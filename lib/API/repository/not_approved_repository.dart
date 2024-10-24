
import 'package:salesoft_hrm/API/provider/not_approved_provider.dart';
import 'package:salesoft_hrm/model/not_approved_model.dart';

abstract class IApprovedRepository {
  Future<Approved> getNotApproved({
    required String ma,
  });
}
class ApprovedRepository implements IApprovedRepository {
  final IApprovedProvider provider;

  ApprovedRepository({
    required this.provider,
  });

  @override
  Future<Approved> getNotApproved({required String ma}) async {
    try {
      final response = await provider.getApproved(ma: ma);
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
