class LoaiNghiResponse {
  final List<LoaiNghi> data;

  LoaiNghiResponse({required this.data});

  factory LoaiNghiResponse.fromJson(List<dynamic> json) {
    List<LoaiNghi> loaiNghiList = json
        .map((item) => LoaiNghi.fromJson(item as Map<String, dynamic>))
        .toList();
    return LoaiNghiResponse(data: loaiNghiList);
  }
}


class LoaiNghi {
  String? ma;
  String? ten;

  LoaiNghi({this.ma, this.ten});

  factory LoaiNghi.fromJson(Map<String, dynamic> json) {
    return LoaiNghi(
      ma: json['ma'],
      ten: json['ten'],
    );
  }
}
