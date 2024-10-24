class Qtluong {
  List<Data>? data;
  int? pageSize;
  int? pageIndex;
  int? totalRecords;
  int? totalPages;

  Qtluong(
      {this.data,
      this.pageSize,
      this.pageIndex,
      this.totalRecords,
      this.totalPages});

  Qtluong.fromJson(Map<String, dynamic> json) {
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
  String? loaiQd;
  String? nhanSu;
  String? tuNgay;
  String? denNgay;
  String? ngachCc;
  double? bacCc;
  double? hsl;
  double? luongCoBan;
  String? noiDung;
  String? soHd;
  String? hdld;
  String? phuLucHopDong;
  double? pcTrachNhiem;
  double? pcLuong;
  double? pcKhac;
  bool? bhxh;
  int? lanKy;
  String? ghiChu;

  Data(
      {this.id,
      this.soQd,
      this.ngayQd,
      this.loaiQd,
      this.nhanSu,
      this.tuNgay,
      this.denNgay,
      this.ngachCc,
      this.bacCc,
      this.hsl,
      this.luongCoBan,
      this.noiDung,
      this.soHd,
      this.hdld,
      this.phuLucHopDong,
      this.pcTrachNhiem,
      this.pcLuong,
      this.pcKhac,
      this.bhxh,
      this.lanKy,
      this.ghiChu});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    soQd = json["soQd"];
    ngayQd = json["ngayQd"];
    loaiQd = json["loaiQd"];
    nhanSu = json["nhanSu"];
    tuNgay = json["tuNgay"];
    denNgay = json["denNgay"];
    ngachCc = json["ngachCc"];
    bacCc = json["bacCc"];
    hsl = json["hsl"];
    luongCoBan = json["luongCoBan"];
    noiDung = json["noiDung"];
    soHd = json["soHd"];
    hdld = json["hdld"];
    phuLucHopDong = json["phuLucHopDong"];
    pcTrachNhiem = json["pcTrachNhiem"];
    pcLuong = json["pcLuong"];
    pcKhac = json["pcKhac"];
    bhxh = json["bhxh"];
    lanKy = json["lanKy"];
    ghiChu = json["ghiChu"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["soQd"] = soQd;
    _data["ngayQd"] = ngayQd;
    _data["loaiQd"] = loaiQd;
    _data["nhanSu"] = nhanSu;
    _data["tuNgay"] = tuNgay;
    _data["denNgay"] = denNgay;
    _data["ngachCc"] = ngachCc;
    _data["bacCc"] = bacCc;
    _data["hsl"] = hsl;
    _data["luongCoBan"] = luongCoBan;
    _data["noiDung"] = noiDung;
    _data["soHd"] = soHd;
    _data["hdld"] = hdld;
    _data["phuLucHopDong"] = phuLucHopDong;
    _data["pcTrachNhiem"] = pcTrachNhiem;
    _data["pcLuong"] = pcLuong;
    _data["pcKhac"] = pcKhac;
    _data["bhxh"] = bhxh;
    _data["lanKy"] = lanKy;
    _data["ghiChu"] = ghiChu;
    return _data;
  }
}
