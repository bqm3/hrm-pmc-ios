class ListNghiPhep {
  List<Data>? data;
  int? pageSize;
  int? pageIndex;
  int? totalRecords;
  int? totalPages;

  ListNghiPhep(
      {this.data,
      this.pageSize,
      this.pageIndex,
      this.totalRecords,
      this.totalPages});

  ListNghiPhep.fromJson(Map<String, dynamic> json) {
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
  String? ngayDk;
  dynamic ngaySinhCon;
  String? tuNgay;
  String? denNgay;
  double? soLuong;
  dynamic lyDo;
  int? tinhTrang;
  String? tenns;
  String? ten;
  String? tenTinhTrang;

  Data(
      {this.id,
      this.ngayDk,
      this.ngaySinhCon,
      this.tuNgay,
      this.denNgay,
      this.soLuong,
      this.lyDo,
      this.tinhTrang,
      this.tenns,
      this.ten,
      this.tenTinhTrang});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    ngayDk = json["ngayDK"];
    ngaySinhCon = json["ngaySinhCon"];
    tuNgay = json["tuNgay"];
    denNgay = json["denNgay"];
    soLuong = json["soLuong"];
    lyDo = json["lyDo"];
    tinhTrang = json["tinhTrang"];
    tenns = json["tenns"];
    ten = json["ten"];
    tenTinhTrang = json["tenTinhTrang"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["ngayDK"] = ngayDk;
    _data["ngaySinhCon"] = ngaySinhCon;
    _data["tuNgay"] = tuNgay;
    _data["denNgay"] = denNgay;
    _data["soLuong"] = soLuong;
    _data["lyDo"] = lyDo;
    _data["tinhTrang"] = tinhTrang;
    _data["tenns"] = tenns;
    _data["ten"] = ten;
    _data["tenTinhTrang"] = tenTinhTrang;
    return _data;
  }
}
