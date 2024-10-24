class ThongBao {
  List<Data>? data;
  int? pageSize;
  int? pageIndex;
  int? totalRecords;
  int? totalPages;

  ThongBao(
      {this.data,
      this.pageSize,
      this.pageIndex,
      this.totalRecords,
      this.totalPages});

  ThongBao.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null
        ? null
        : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    pageSize = json["pageSize"];
    pageIndex = json["pageIndex"];
    totalRecords = json["totalRecords"];
    totalPages = json["totalPages"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    _data["pageSize"] = pageSize;
    _data["pageIndex"] = pageIndex;
    _data["totalRecords"] = totalRecords;
    _data["totalPages"] = totalPages;
    return _data;
  }
}

class Data {
  int? idToken;
  int? idThongBao;
  String? tieuDe;
  String? noiDung;
  bool? daXem;
  String? date1;

  Data(
      {this.idToken,
      this.idThongBao,
      this.tieuDe,
      this.noiDung,
      this.daXem,
      this.date1});

  Data.fromJson(Map<String, dynamic> json) {
    idToken = json["idToken"];
    idThongBao = json["idThongBao"];
    tieuDe = json["tieuDe"];
    noiDung = json["noiDung"];
    daXem = json["daXem"];
    date1 = json["date1"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["idToken"] = idToken;
    _data["idThongBao"] = idThongBao;
    _data["tieuDe"] = tieuDe;
    _data["noiDung"] = noiDung;
    _data["daXem"] = daXem;
    _data["date1"] = date1;
    return _data;
  }
}
