class NghiPhepDetail {
  int? id;
  int? idNghiPhep;
  String? ngay;
  int? soLuong;
  String? loai;
  int? user1;
  String? date1;

  NghiPhepDetail(
      {this.id,
      this.idNghiPhep,
      this.ngay,
      this.soLuong,
      this.loai,
      this.user1,
      this.date1});

  NghiPhepDetail.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    idNghiPhep = json["idNghiPhep"];
    ngay = json["ngay"];
    soLuong = json["soLuong"];
    loai = json["loai"];
    user1 = json["user1"];
    date1 = json["date1"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["idNghiPhep"] = idNghiPhep;
    _data["ngay"] = ngay;
    _data["soLuong"] = soLuong;
    _data["loai"] = loai;
    _data["user1"] = user1;
    _data["date1"] = date1;
    return _data;
  }
}
