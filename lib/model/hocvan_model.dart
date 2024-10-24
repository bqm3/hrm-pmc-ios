class hocvan {
  List<Data>? data;
  int? pageSize;
  int? pageIndex;
  int? totalRecords;
  int? totalPages;

  hocvan(
      {this.data,
      this.pageSize,
      this.pageIndex,
      this.totalRecords,
      this.totalPages});

  hocvan.fromJson(Map<String, dynamic> json) {
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
  String? nhanSu;
  String? hocVan;
  String? hocVi;
  String? truongDt;
  String? loaiBang;
  String? chuyenNganh;
  String? quocGia;
  int? namTn;

  Data({
    this.id,
    this.nhanSu,
    this.hocVan,
    this.hocVi,
    this.truongDt,
    this.loaiBang,
    this.chuyenNganh,
    this.quocGia,
    this.namTn,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    nhanSu = json["nhanSu"];
    hocVan = json["hocVan"];
    hocVi = json["hocVi"];
    truongDt = json["truongDt"];
    loaiBang = json["loaiBang"];
    chuyenNganh = json["chuyenNganh"];
    quocGia = json["quocGia"];
    namTn = json["namTn"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["nhanSu"] = nhanSu;
    _data["hocVan"] = hocVan;
    _data["hocVi"] = hocVi;
    _data["truongDt"] = truongDt;
    _data["loaiBang"] = loaiBang;
    _data["chuyenNganh"] = chuyenNganh;
    _data["quocGia"] = quocGia;
    _data["namTn"] = namTn;
    return _data;
  }
}
