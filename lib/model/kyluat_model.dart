class Kyluat {
  List<Data>? data;
  int? pageSize;
  int? pageIndex;
  int? totalRecords;
  int? totalPages;

  Kyluat(
      {this.data,
      this.pageSize,
      this.pageIndex,
      this.totalRecords,
      this.totalPages});

  Kyluat.fromJson(Map<String, dynamic> json) {
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
  String? capQd;
  String? noiDung;
  String? nguoiKy;
  String? ghiChu;
  int? thoiGian;
  double? soTien;

  Data(
      {this.id,
      this.nhanSu,
      this.soQd,
      this.ngayQd,
      this.ngayHieuLuc,
      this.hinhThuc,
      this.capQd,
      this.noiDung,
      this.nguoiKy,
      this.ghiChu,
      this.thoiGian,
      this.soTien});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    nhanSu = json["nhanSu"];
    soQd = json["soQd"];
    ngayQd = json["ngayQd"];
    ngayHieuLuc = json["ngayHieuLuc"];
    hinhThuc = json["hinhThuc"];
    capQd = json["capQd"];
    noiDung = json["noiDung"];
    nguoiKy = json["nguoiKy"];
    ghiChu = json["ghiChu"];
    thoiGian = json["thoiGian"];
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
    _data["capQd"] = capQd;
    _data["noiDung"] = noiDung;
    _data["nguoiKy"] = nguoiKy;
    _data["ghiChu"] = ghiChu;
    _data["thoiGian"] = thoiGian;
    _data["soTien"] = soTien;
    return _data;
  }
}
