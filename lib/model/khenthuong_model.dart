class Khenthuong {
  List<Data>? data;
  int? pageSize;
  int? pageIndex;
  int? totalRecords;
  int? totalPages;

  Khenthuong(
      {this.data,
      this.pageSize,
      this.pageIndex,
      this.totalRecords,
      this.totalPages});

  Khenthuong.fromJson(Map<String, dynamic> json) {
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
  String? soQd;
  String? ngayQd;
  String? ngayHieuLuc;
  String? hinhThuc;
  String? danhHieu;
  String? noiDung;
  String? nguoiKy;
  String? capQd;
  String? ghiChu;
  double? soTien;

  Data(
      {this.id,
      this.nhanSu,
      this.soQd,
      this.ngayQd,
      this.ngayHieuLuc,
      this.hinhThuc,
      this.danhHieu,
      this.noiDung,
      this.nguoiKy,
      this.capQd,
      this.ghiChu,
      this.soTien});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    nhanSu = json["nhanSu"];
    soQd = json["soQd"];
    ngayQd = json["ngayQd"];
    ngayHieuLuc = json["ngayHieuLuc"];
    hinhThuc = json["hinhThuc"];
    danhHieu = json["danhHieu"];
    noiDung = json["noiDung"];
    nguoiKy = json["nguoiKy"];
    capQd = json["capQd"];
    ghiChu = json["ghiChu"];
    soTien = json["soTien"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["nhanSu"] = nhanSu;
    _data["soQd"] = soQd;
    _data["ngayQd"] = ngayQd;
    _data["ngayHieuLuc"] = ngayHieuLuc;
    _data["hinhThuc"] = hinhThuc;
    _data["danhHieu"] = danhHieu;
    _data["noiDung"] = noiDung;
    _data["nguoiKy"] = nguoiKy;
    _data["capQd"] = capQd;
    _data["ghiChu"] = ghiChu;
    _data["soTien"] = soTien;
    return _data;
  }
}
