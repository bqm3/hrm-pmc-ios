class NsCongtactr {
  List<Data>? data;
  int? pageSize;
  int? pageIndex;
  int? totalRecords;
  int? totalPages;

  NsCongtactr(
      {this.data,
      this.pageSize,
      this.pageIndex,
      this.totalRecords,
      this.totalPages});

  NsCongtactr.fromJson(Map<String, dynamic> json) {
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
  String? nhansu;
  String? tuNgay;
  String? denNgay;
  String? donVi;
  String? phongban;
  String? chucVu;
  String? kiemNhiem;
  String? ghiChu;
  String? thoiGian;
  double? mucLuong;

  Data(
      {this.id,
      this.nhansu,
      this.tuNgay,
      this.denNgay,
      this.donVi,
      this.phongban,
      this.chucVu,
      this.kiemNhiem,
      this.ghiChu,
      this.thoiGian,
      this.mucLuong});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    nhansu = json["nhansu"];
    tuNgay = json["tuNgay"];
    denNgay = json["denNgay"];
    donVi = json["donVi"];
    phongban = json["phongban"];
    chucVu = json["chucVu"];
    kiemNhiem = json["kiemNhiem"];
    ghiChu = json["ghiChu"];
    thoiGian = json["thoiGian"];
    mucLuong = json["mucLuong"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["nhansu"] = nhansu;
    _data["tuNgay"] = tuNgay;
    _data["denNgay"] = denNgay;
    _data["donVi"] = donVi;
    _data["phongban"] = phongban;
    _data["chucVu"] = chucVu;
    _data["kiemNhiem"] = kiemNhiem;
    _data["ghiChu"] = ghiChu;
    _data["thoiGian"] = thoiGian;
    _data["mucLuong"] = mucLuong;
    return _data;
  }
}
