class Quanhe {
  List<Data>? data;
  int? pageSize;
  int? pageIndex;
  int? totalRecords;
  int? totalPages;

  Quanhe(
      {this.data,
      this.pageSize,
      this.pageIndex,
      this.totalRecords,
      this.totalPages});

  Quanhe.fromJson(Map<String, dynamic> json) {
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
  String? quanHe;
  String? hoTen;
  String? ngaySinh;
  String? diaChi;
  dynamic ngheNghiep;
  bool? truGiaCanh;
  String? maSoThue;
  String? soCmt;
  dynamic ngayCmt;
  String? noiCmt;
  String? ghiChu;

  Data(
      {this.id,
      this.nhanSu,
      this.quanHe,
      this.hoTen,
      this.ngaySinh,
      this.diaChi,
      this.ngheNghiep,
      this.truGiaCanh,
      this.maSoThue,
      this.soCmt,
      this.ngayCmt,
      this.noiCmt,
      this.ghiChu});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    nhanSu = json["nhanSu"];
    quanHe = json["quanHe"];
    hoTen = json["hoTen"];
    ngaySinh = json["ngaySinh"];
    diaChi = json["diaChi"];
    ngheNghiep = json["ngheNghiep"];
    truGiaCanh = json["truGiaCanh"];
    maSoThue = json["maSoThue"];
    soCmt = json["soCmt"];
    ngayCmt = json["ngayCmt"];
    noiCmt = json["noiCmt"];
    ghiChu = json["ghiChu"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["nhanSu"] = nhanSu;
    _data["quanHe"] = quanHe;
    _data["hoTen"] = hoTen;
    _data["ngaySinh"] = ngaySinh;
    _data["diaChi"] = diaChi;
    _data["ngheNghiep"] = ngheNghiep;
    _data["truGiaCanh"] = truGiaCanh;
    _data["maSoThue"] = maSoThue;
    _data["soCmt"] = soCmt;
    _data["ngayCmt"] = ngayCmt;
    _data["noiCmt"] = noiCmt;
    _data["ghiChu"] = ghiChu;
    return _data;
  }
}
