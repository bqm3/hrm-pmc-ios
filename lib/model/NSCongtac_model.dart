class NsCongtac {
  List<Data>? data;
  int? pageSize;
  int? pageIndex;
  int? totalRecords;
  int? totalPages;

  NsCongtac(
      {this.data,
      this.pageSize,
      this.pageIndex,
      this.totalRecords,
      this.totalPages});

  NsCongtac.fromJson(Map<String, dynamic> json) {
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
  String? soQd;
  String? ngayQd;
  String? nhanSu;
  String? tuNgay;
  String? denNgay;
  String? congTy;
  String? donVi;
  String? phongBan;
  String? toCongTac;
  String? chucVu;
  String? kiemNhiem;
  String? loaiQd;
  String? ghiChu;
  String? thoiGian;
  double? mucLuong;
  String? chuyenNganh;

  Data(
      {this.id,
      this.soQd,
      this.ngayQd,
      this.nhanSu,
      this.tuNgay,
      this.denNgay,
      this.congTy,
      this.donVi,
      this.phongBan,
      this.toCongTac,
      this.chucVu,
      this.kiemNhiem,
      this.loaiQd,
      this.ghiChu,
      this.thoiGian,
      this.mucLuong,
      this.chuyenNganh});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    soQd = json["soQd"];
    ngayQd = json["ngayQd"];
    nhanSu = json["nhanSu"];
    tuNgay = json["tuNgay"];
    denNgay = json["denNgay"];
    congTy = json["congTy"];
    donVi = json["donVi"];
    phongBan = json["phongBan"];
    toCongTac = json["toCongTac"];
    chucVu = json["chucVu"];
    kiemNhiem = json["kiemNhiem"];
    loaiQd = json["loaiQd"];
    ghiChu = json["ghiChu"];
    thoiGian = json["thoiGian"];
    mucLuong = json["mucLuong"];
    chuyenNganh = json["chuyenNganh"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["soQd"] = soQd;
    _data["ngayQd"] = ngayQd;
    _data["nhanSu"] = nhanSu;
    _data["tuNgay"] = tuNgay;
    _data["denNgay"] = denNgay;
    _data["congTy"] = congTy;
    _data["donVi"] = donVi;
    _data["phongBan"] = phongBan;
    _data["toCongTac"] = toCongTac;
    _data["chucVu"] = chucVu;
    _data["kiemNhiem"] = kiemNhiem;
    _data["loaiQd"] = loaiQd;
    _data["ghiChu"] = ghiChu;
    _data["thoiGian"] = thoiGian;
    _data["mucLuong"] = mucLuong;
    _data["chuyenNganh"] = chuyenNganh;
    return _data;
  }
}
