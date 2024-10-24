class LoaiDaoTao {
  List<Data>? data;
  int? pageSize;
  int? pageIndex;
  int? totalRecords;
  int? totalPages;

  LoaiDaoTao(
      {this.data,
      this.pageSize,
      this.pageIndex,
      this.totalRecords,
      this.totalPages});

  LoaiDaoTao.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? ma;
  String? ten;
  String? donVi;
  String? phongBan;
  String? toCongTac;
  String? chucVu;
  String? tendv;
  dynamic tencv;
  String? tenpb;
  dynamic tentct;
  String? tuNgay;
  String? denNgay;
  int? tinhTrang;
  int? sotv;

  Data(
      {this.id,
      this.ma,
      this.ten,
      this.donVi,
      this.phongBan,
      this.toCongTac,
      this.chucVu,
      this.tendv,
      this.tencv,
      this.tenpb,
      this.tentct,
      this.tuNgay,
      this.denNgay,
      this.tinhTrang,
      this.sotv});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    ma = json["ma"];
    ten = json["ten"];
    donVi = json["donVi"];
    phongBan = json["phongBan"];
    toCongTac = json["toCongTac"];
    chucVu = json["chucVu"];
    tendv = json["tendv"];
    tencv = json["tencv"];
    tenpb = json["tenpb"];
    tentct = json["tentct"];
    tuNgay = json["tuNgay"];
    denNgay = json["denNgay"];
    tinhTrang = json["tinhTrang"];
    sotv = json["sotv"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["ma"] = ma;
    _data["ten"] = ten;
    _data["donVi"] = donVi;
    _data["phongBan"] = phongBan;
    _data["toCongTac"] = toCongTac;
    _data["chucVu"] = chucVu;
    _data["tendv"] = tendv;
    _data["tencv"] = tencv;
    _data["tenpb"] = tenpb;
    _data["tentct"] = tentct;
    _data["tuNgay"] = tuNgay;
    _data["denNgay"] = denNgay;
    _data["tinhTrang"] = tinhTrang;
    _data["sotv"] = sotv;
    return _data;
  }
}
