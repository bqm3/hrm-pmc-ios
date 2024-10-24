
class ListChamCong {
    int? id;
    String? nhanSu;
    String? token;
    String? caLamViec;
    String? diaDiem;
    String? thoiGian;
    bool? checkIn;
    String? lyDo;

    ListChamCong({this.id, this.nhanSu, this.token, this.caLamViec, this.diaDiem, this.thoiGian, this.checkIn, this.lyDo});

    ListChamCong.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        nhanSu = json["nhanSu"];
        token = json["token"];
        caLamViec = json["caLamViec"];
        diaDiem = json["diaDiem"];
        thoiGian = json["thoiGian"];
        checkIn = json["checkIn"];
        lyDo = json["lyDo"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["nhanSu"] = nhanSu;
        _data["token"] = token;
        _data["caLamViec"] = caLamViec;
        _data["diaDiem"] = diaDiem;
        _data["thoiGian"] = thoiGian;
        _data["checkIn"] = checkIn;
        _data["lyDo"] = lyDo;
        return _data;
    }
}
class ListChamCongResponse {
  final List<ListChamCong> items;

  ListChamCongResponse({required this.items});

  factory ListChamCongResponse.fromJson(List<dynamic> json) {
    return ListChamCongResponse(
      items: json
          .map((item) => ListChamCong.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

