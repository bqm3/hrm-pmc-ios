class LoaiQuanHe {
  final String ma;
  final String ten;

  LoaiQuanHe({required this.ma, required this.ten});

  factory LoaiQuanHe.fromJson(Map<String, dynamic> json) {
    return LoaiQuanHe(
      ma: json['ma'],
      ten: json['ten'],
    );
  }
}
