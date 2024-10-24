import 'Dart:convert';


class AppInfoModel {
  String? appVersion;
  String? company;
  String? address;
  String? phone;
  String? email;
  String? hotline;
  String? website;
  String? taxCode;
  String? youtube;
  String? facebook;
  String? zaloOA;
  String? accNumber1;
  String? bankName1;
  String? accName1;
  String? accNumber2;
  String? bankName2;
  String? accName2;

  AppInfoModel({
    this.appVersion,
    this.company,
    this.address,
    this.phone,
    this.email,
    this.hotline,
    this.website,
    this.taxCode,
    this.youtube,
    this.facebook,
    this.zaloOA,
    this.accNumber1,
    this.bankName1,
    this.accName1,
    this.accNumber2,
    this.bankName2,
    this.accName2,
  });

  Map<String, dynamic> toMap() {
    return {
      'AppVersion': appVersion,
      'Company': company,
      'Address': address,
      'Phone': phone,
      'Email': email,
      'Hotline': hotline,
      'Website': website,
      'TaxCode': taxCode,
      'Youtube': youtube,
      'Facebook': facebook,
      'ZaloOA': zaloOA,
      'AccNumber1': accNumber1,
      'BankName1': bankName1,
      'AccName1': accName1,
      'AccNumber2': accNumber2,
      'BankName2': bankName2,
      'AccName2': accName2,
    };
  }

  factory AppInfoModel.fromMap(Map<String, dynamic> map) {
    return AppInfoModel(
      appVersion: map['AppVersion'],
      company: map['Company'],
      address: map['Address'],
      phone: map['Phone'],
      email: map['Email'],
      hotline: map['Hotline'],
      website: map['Website'],
      taxCode: map['TaxCode'],
      youtube: map['Youtube'],
      facebook: map['Facebook'],
      zaloOA: map['ZaloOA'],
      accNumber1: map['AccNumber1'],
      bankName1: map['BankName1'],
      accName1: map['AccName1'],
      accNumber2: map['AccNumber2'],
      bankName2: map['BankName2'],
      accName2: map['AccName2'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppInfoModel.fromJson(String source) =>
      AppInfoModel.fromMap(json.decode(source));
}
