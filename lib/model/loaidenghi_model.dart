class LoaiDeNghi {
  final String ma;
  final String ten;

  LoaiDeNghi({required this.ma, required this.ten});

  factory LoaiDeNghi.fromJson(Map<String, dynamic> json) {
    return LoaiDeNghi(
      ma: json['ma'],
      ten: json['ten'],
    );
  }
}
