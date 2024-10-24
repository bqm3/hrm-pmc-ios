import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> getCurrentMinutes() async {
  try {
    final response = await http.get(
      Uri.parse('https://apihrm.pmcweb.vn/api/RegSystem/GetDateTimeNow'),
      headers: {'accept': '*/*'},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      String dateTimeString = data['dateTime'];
      DateTime now = DateTime.parse(dateTimeString);

      int currentMinutes = now.hour * 60 + now.minute;

      print('Current Minutes: $currentMinutes');
    } else {
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    print('Exception: $e');
  }
}
