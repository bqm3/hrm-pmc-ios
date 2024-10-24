class LichDaoTao {
  List<Data>? data;
  int? pageSize;
  int? pageIndex;
  int? totalRecords;
  int? totalPages;

  LichDaoTao(
      {this.data,
      this.pageSize,
      this.pageIndex,
      this.totalRecords,
      this.totalPages});

  LichDaoTao.fromJson(Map<String, dynamic> json) {
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
  String? ngay;
  String? maNs;
  String? nhanSu;
  int? tinhTrang;
  String? tenTinhTrang;
  String? ten;
  String? lopDt;
  String? tenLopDt;
  String? tenDv;
  String? tenPb;
  dynamic tenNoiDung;
  int? idxd;

  Data(
      {this.id,
      this.ngay,
      this.maNs,
      this.nhanSu,
      this.tinhTrang,
      this.tenTinhTrang,
      this.ten,
      this.lopDt,
      this.tenLopDt,
      this.tenDv,
      this.tenPb,
      this.tenNoiDung,
      this.idxd});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    ngay = json["ngay"];
    maNs = json["maNS"];
    nhanSu = json["nhanSu"];
    tinhTrang = json["tinhTrang"];
    tenTinhTrang = json["tenTinhTrang"];
    ten = json["ten"];
    lopDt = json["lopDT"];
    tenLopDt = json["tenLopDT"];
    tenDv = json["tenDV"];
    tenPb = json["tenPB"];
    tenNoiDung = json["tenNoiDung"];
    idxd = json["idxd"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["ngay"] = ngay;
    _data["maNS"] = maNs;
    _data["nhanSu"] = nhanSu;
    _data["tinhTrang"] = tinhTrang;
    _data["tenTinhTrang"] = tenTinhTrang;
    _data["ten"] = ten;
    _data["lopDT"] = lopDt;
    _data["tenLopDT"] = tenLopDt;
    _data["tenDV"] = tenDv;
    _data["tenPB"] = tenPb;
    _data["tenNoiDung"] = tenNoiDung;
    _data["idxd"] = idxd;
    return _data;
  }
}
