import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReasonDialog extends StatelessWidget {
  final TextEditingController reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
        controller: reasonController,
        decoration: InputDecoration(
          hintText: 'Nhập lý do chấm vào muộn',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Hủy'),
        ),
        TextButton(
          onPressed: () {
            String reason = reasonController.text;
            Get.back(result: reason);
          },
          child: Text('Xác nhận'),
        ),
      ],
    );
  }
}
// class ReasonDialog2 extends StatelessWidget {
//   final TextEditingController reasonController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       content: TextField(
//         controller: reasonController,
//         decoration: InputDecoration(
//           hintText: 'Nhập lý do chấm ra sớm',
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Get.back(); 
//           },
//           child: Text('Hủy'),
//         ),
//         TextButton(
//           onPressed: () {
//             String reason = reasonController.text;
//             Get.back(result: reason); 
//           },
//           child: Text('Xác nhận'),
//         ),
//       ],
//     );
//   }
// }
