
class DiaDiem {
    String? ma;
    String? ten;
    String? kinhDo;
    String? viDo;
    int? khoangCach;

    DiaDiem({this.ma, this.ten, this.kinhDo, this.viDo, this.khoangCach});

    DiaDiem.fromJson(Map<String, dynamic> json) {
        ma = json["ma"];
        ten = json["ten"];
        kinhDo = json["kinhDo"];
        viDo = json["viDo"];
        khoangCach = json["khoangCach"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["ma"] = ma;
        _data["ten"] = ten;
        _data["kinhDo"] = kinhDo;
        _data["viDo"] = viDo;
        _data["khoangCach"] = khoangCach;
        return _data;
    }
}
class DiaDiemList {
  final List<DiaDiem> diaDiemList;

  DiaDiemList({required this.diaDiemList});

  factory DiaDiemList.fromJson(List<dynamic> json) {
    List<DiaDiem> diaDiemList = json.map((item) => DiaDiem.fromJson(item)).toList();
    return DiaDiemList(diaDiemList: diaDiemList);
  }
}