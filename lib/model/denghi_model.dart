class DeNghi {
  List<Data>? data;
  int? pageSize;
  int? pageIndex;
  int? totalRecords;
  int? totalPages;

  DeNghi(
      {this.data,
      this.pageSize,
      this.pageIndex,
      this.totalRecords,
      this.totalPages});

  DeNghi.fromJson(Map<String, dynamic> json) {
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
  String? noiDung;
  double? soTien;
  String? thoiGian;
  String? lyDo;
  String? tenTinhTrang;
  String? tenNs;
  String? tenDv;
  String? tenPb;
  String? ten;
  int? tinhTrang;

  Data(
      {this.id,
      this.ngay,
      this.noiDung,
      this.soTien,
      this.thoiGian,
      this.lyDo,
      this.tenTinhTrang,
      this.tenNs,
      this.tenDv,
      this.tenPb,
      this.ten,
      this.tinhTrang});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    ngay = json["ngay"];
    noiDung = json["noiDung"];
    soTien = json["soTien"];
    thoiGian = json["thoiGian"];
    lyDo = json["lyDo"];
    tenTinhTrang = json["tenTinhTrang"];
    tenNs = json["tenNS"];
    tenDv = json["tenDV"];
    tenPb = json["tenPB"];
    ten = json["ten"];
    tinhTrang = json["tinhTrang"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["ngay"] = ngay;
    _data["noiDung"] = noiDung;
    _data["soTien"] = soTien;
    _data["thoiGian"] = thoiGian;
    _data["lyDo"] = lyDo;
    _data["tenTinhTrang"] = tenTinhTrang;
    _data["tenNS"] = tenNs;
    _data["tenDV"] = tenDv;
    _data["tenPB"] = tenPb;
    _data["ten"] = ten;
    _data["tinhTrang"] = tinhTrang;
    return _data;
  }
}
