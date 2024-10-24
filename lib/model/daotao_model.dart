
class DaoTao {
    List<Data>? data;
    int? pageSize;
    int? pageIndex;
    int? totalRecords;
    int? totalPages;

    DaoTao({this.data, this.pageSize, this.pageIndex, this.totalRecords, this.totalPages});

    DaoTao.fromJson(Map<String, dynamic> json) {
        data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
        pageSize = json["pageSize"];
        pageIndex = json["pageIndex"];
        totalRecords = json["totalRecords"];
        totalPages = json["totalPages"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(data != null) {
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
    String? lopDt;
    String? ngay;
    String? thoiGian;
    String? moTa;
    String? taiLieu;
    int? tinhTrang;
    String? mact;
    String? tenct;
    String? madv;
    String? tendv;

    Data({this.id, this.lopDt, this.ngay, this.thoiGian, this.moTa, this.taiLieu, this.tinhTrang, this.mact, this.tenct, this.madv, this.tendv});

    Data.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        lopDt = json["lopDT"];
        ngay = json["ngay"];
        thoiGian = json["thoiGian"];
        moTa = json["moTa"];
        taiLieu = json["taiLieu"];
        tinhTrang = json["tinhTrang"];
        mact = json["mact"];
        tenct = json["tenct"];
        madv = json["madv"];
        tendv = json["tendv"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["lopDT"] = lopDt;
        _data["ngay"] = ngay;
        _data["thoiGian"] = thoiGian;
        _data["moTa"] = moTa;
        _data["taiLieu"] = taiLieu;
        _data["tinhTrang"] = tinhTrang;
        _data["mact"] = mact;
        _data["tenct"] = tenct;
        _data["madv"] = madv;
        _data["tendv"] = tendv;
        return _data;
    }
}

class LoaiDaoTao {
    String? ma;
    String? ten;
    bool? ok;

    LoaiDaoTao({this.ma, this.ten, this.ok});

    LoaiDaoTao.fromJson(Map<String, dynamic> json) {
        ma = json["ma"];
        ten = json["ten"];
        ok = json["ok"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["ma"] = ma;
        _data["ten"] = ten;
        _data["ok"] = ok;
        return _data;
    }
}
class LoaiDaoTaoResponse {
  final List<LoaiDaoTao> data;

  LoaiDaoTaoResponse({required this.data});

  factory LoaiDaoTaoResponse.fromJson(List<dynamic> json) {
    List<LoaiDaoTao> loaiDaoTaolist = json
        .map((item) => LoaiDaoTao.fromJson(item as Map<String, dynamic>))
        .toList();
    return LoaiDaoTaoResponse(data: loaiDaoTaolist);
  }
}
