
class Approved {
    int? id;
    String? nhanSu;
    String? ngaySinh;
    String? noiSinh;
    String? gioiTinh;
    String? dctt;
    String? dcll;
    String? dienThoai;
    String? email;
    String? cmt;
    String? ngayCmt;
    String? noiCmt;
    String? nganHang;
    String? taiKhoan;
    int? tinhTrang;
    dynamic user1;
    dynamic date1;
    dynamic user2;
    dynamic date2;

    Approved({this.id, this.nhanSu, this.ngaySinh, this.noiSinh, this.gioiTinh, this.dctt, this.dcll, this.dienThoai, this.email, this.cmt, this.ngayCmt, this.noiCmt, this.nganHang, this.taiKhoan, this.tinhTrang, this.user1, this.date1, this.user2, this.date2});

    Approved.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        nhanSu = json["nhanSu"];
        ngaySinh = json["ngaySinh"];
        noiSinh = json["noiSinh"];
        gioiTinh = json["gioiTinh"];
        dctt = json["dctt"];
        dcll = json["dcll"];
        dienThoai = json["dienThoai"];
        email = json["email"];
        cmt = json["cmt"];
        ngayCmt = json["ngayCmt"];
        noiCmt = json["noiCmt"];
        nganHang = json["nganHang"];
        taiKhoan = json["taiKhoan"];
        tinhTrang = json["tinhTrang"];
        user1 = json["user1"];
        date1 = json["date1"];
        user2 = json["user2"];
        date2 = json["date2"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["nhanSu"] = nhanSu;
        _data["ngaySinh"] = ngaySinh;
        _data["noiSinh"] = noiSinh;
        _data["gioiTinh"] = gioiTinh;
        _data["dctt"] = dctt;
        _data["dcll"] = dcll;
        _data["dienThoai"] = dienThoai;
        _data["email"] = email;
        _data["cmt"] = cmt;
        _data["ngayCmt"] = ngayCmt;
        _data["noiCmt"] = noiCmt;
        _data["nganHang"] = nganHang;
        _data["taiKhoan"] = taiKhoan;
        _data["tinhTrang"] = tinhTrang;
        _data["user1"] = user1;
        _data["date1"] = date1;
        _data["user2"] = user2;
        _data["date2"] = date2;
        return _data;
    }
}