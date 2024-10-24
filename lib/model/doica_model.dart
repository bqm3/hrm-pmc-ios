class DoiCa {
  int? id;
  String? nhanSu;
  String? hoDem;
  String? ten;
  String? donVi;
  String? phongBan;
  String? ngay;
  String? caCu;
  String? tenCaCu;
  String? caMoi;
  String? tenCaMoi;
  int? tinhTrang;

  DoiCa(
      {this.id,
      this.nhanSu,
      this.hoDem,
      this.ten,
      this.donVi,
      this.phongBan,
      this.ngay,
      this.caCu,
      this.tenCaCu,
      this.caMoi,
      this.tenCaMoi,
      this.tinhTrang});

  DoiCa.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    nhanSu = json["nhanSu"];
    hoDem = json["hoDem"];
    ten = json["ten"];
    donVi = json["donVi"];
    phongBan = json["phongBan"];
    ngay = json["ngay"];
    caCu = json["caCu"];
    tenCaCu = json["tenCaCu"];
    caMoi = json["caMoi"];
    tenCaMoi = json["tenCaMoi"];
    tinhTrang = json["tinhTrang"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["nhanSu"] = nhanSu;
    _data["hoDem"] = hoDem;
    _data["ten"] = ten;
    _data["donVi"] = donVi;
    _data["phongBan"] = phongBan;
    _data["ngay"] = ngay;
    _data["caCu"] = caCu;
    _data["tenCaCu"] = tenCaCu;
    _data["caMoi"] = caMoi;
    _data["tenCaMoi"] = tenCaMoi;
    _data["tinhTrang"] = tinhTrang;
    return _data;
  }
}

class DoiCaResponse {
  final List<DoiCa> items;

  DoiCaResponse({required this.items});

  factory DoiCaResponse.fromJson(List<dynamic> json) {
    return DoiCaResponse(
      items: json
          .map((item) => DoiCa.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
