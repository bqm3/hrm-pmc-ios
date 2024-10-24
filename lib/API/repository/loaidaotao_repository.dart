
// import 'package:salesoft_hrm/API/provider/loaidaotao_provider.dart';
// import 'package:salesoft_hrm/model/daotao_model.dart';

// abstract class ILoaiDaoTaoRepository {
//   Future<LoaiDaoTaoResponse?> getLoaiDaoTao({
//     required String chucVu,
//   });
// }

// class LoaiDaoTaoRepository implements ILoaiDaoTaoRepository {
//   final ILoaiDaoTaoProvider provider;

//   LoaiDaoTaoRepository({required this.provider});

//   @override
//   Future<LoaiDaoTaoResponse?> getLoaiDaoTao({required String chucVu}) async {
//     try {
//       final response = await provider.getLoaiDaoTao(chucVu: chucVu);
//       if (response != null) {
//         final loaiDaoTaoResponse = LoaiDaoTaoResponse.fromJson(response);
//         return loaiDaoTaoResponse;
//       }
//     } catch (onError) {
//       print('Error during API call: $onError');
//       return null;
//     }
//     return null;
//   }
// }

