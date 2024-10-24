class Danhba {
  List<Data>? data;
  int? pageSize;
  int? pageIndex;
  int? totalRecords;
  int? totalPages;

  Danhba(
      {this.data,
      this.pageSize,
      this.pageIndex,
      this.totalRecords,
      this.totalPages});

  Danhba.fromJson(Map<String, dynamic> json) {
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
  String? hoDem;
  String? ten;
  String? kh;
  String? ngaySinh;
  String? gioiTinh;
  dynamic soHd;
  dynamic ngayKyHd;
  dynamic dcll;
  String? dienThoai;
  String? email;
  dynamic chucVu;
  dynamic phongBan;
  dynamic toCongTac;

  Data(
      {this.id,
      this.ma,
      this.hoDem,
      this.ten,
      this.kh,
      this.ngaySinh,
      this.gioiTinh,
      this.soHd,
      this.ngayKyHd,
      this.dcll,
      this.dienThoai,
      this.email,
      this.chucVu,
      this.phongBan,
      this.toCongTac});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    ma = json["ma"];
    hoDem = json["hoDem"];
    ten = json["ten"];
    kh = json["kh"];
    ngaySinh = json["ngaySinh"];
    gioiTinh = json["gioiTinh"];
    soHd = json["soHd"];
    ngayKyHd = json["ngayKyHd"];
    dcll = json["dcll"];
    dienThoai = json["dienThoai"];
    email = json["email"];
    chucVu = json["chucVu"];
    phongBan = json["phongBan"];
    toCongTac = json["toCongTac"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["ma"] = ma;
    _data["hoDem"] = hoDem;
    _data["ten"] = ten;
    _data["kh"] = kh;
    _data["ngaySinh"] = ngaySinh;
    _data["gioiTinh"] = gioiTinh;
    _data["soHd"] = soHd;
    _data["ngayKyHd"] = ngayKyHd;
    _data["dcll"] = dcll;
    _data["dienThoai"] = dienThoai;
    _data["email"] = email;
    _data["chucVu"] = chucVu;
    _data["phongBan"] = phongBan;
    _data["toCongTac"] = toCongTac;
    return _data;
  }
}
