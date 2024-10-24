import 'dart:convert';

class ErrorModel {
  String? content;

  ErrorModel({
    this.content,
  });

  Map<String, dynamic> toMap() {
    return {
      'Error': content,
    };
  }

  factory ErrorModel.fromMap(Map<String, dynamic> map) {
    return ErrorModel(
      content: map['Error'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorModel.fromJson(String source) =>
      ErrorModel.fromMap(json.decode(source));
}
