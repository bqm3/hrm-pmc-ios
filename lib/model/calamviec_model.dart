class CaLamViec {
  String? ma;
  String? ten;
  String? gioVao;
  String? gioRa;
  String? ngay;

  CaLamViec({this.ma, this.ten, this.gioVao, this.gioRa, this.ngay});

  CaLamViec.fromJson(Map<String, dynamic> json) {
    ma = json["ma"];
    ten = json["ten"];
    gioVao = json["gioVao"];
    gioRa = json["gioRa"];
    ngay = json["ngay"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["ma"] = ma;
    _data["ten"] = ten;
    _data["gioVao"] = gioVao;
    _data["gioRa"] = gioRa;
    _data["ngay"] = ngay;
    return _data;
  }
}

class CaLamList {
  final List<CaLamViec> caLamList;

  CaLamList({required this.caLamList});

  factory CaLamList.fromJson(List<dynamic> json) {
    return CaLamList(
      caLamList: json.map((item) => CaLamViec.fromJson(item)).toList(),
    );
  }
}
