class CaLamViec2 {
  final String ma;
  final String ten;
  final double heSo;
  final String gioVao;
  final String gioRa;
  final String ngay;

  CaLamViec2({
    required this.ma,
    required this.ten,
    required this.heSo,
    required this.gioVao,
    required this.gioRa,
    required this.ngay,
  });

  factory CaLamViec2.fromJson(Map<String, dynamic> json) {
    return CaLamViec2(
      ma: json['ma'],
      ten: json['ten'],
      heSo: json['heSo'].toDouble(),
      gioVao: json['gioVao'],
      gioRa: json['gioRa'],
      ngay: json['ngay'],
    );
  }
}

class CaLamViec3 {
  final String ma;
  final String ten;
  final String gioVao;
  final String gioRa;
  final String ngay;
  final double soLuong;

  CaLamViec3({
    required this.ma,
    required this.ten,
    required this.gioVao,
    required this.gioRa,
    required this.ngay,
    required this.soLuong,
  });

  factory CaLamViec3.fromJson(Map<String, dynamic> json) {
    return CaLamViec3(
      ma: json['ma'],
      ten: json['ten'],
      gioVao: json['gioVao'],
      gioRa: json['gioRa'],
      ngay: json['ngay'],
      soLuong: json['soLuong'],
    );
  }
}

class CaLamViec4 {
  String? ma;
  String? ten;
  String? ngay;

  CaLamViec4({this.ma, this.ten, this.ngay});

  CaLamViec4.fromJson(Map<String, dynamic> json) {
    ma = json["ma"];
    ten = json["ten"];
    ngay = json["ngay"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["ma"] = ma;
    _data["ten"] = ten;
    _data["ngay"] = ngay;
    return _data;
  }
}
