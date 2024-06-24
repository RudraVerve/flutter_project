import 'dart:convert';

class DataInsertHelper {
  String? name;
  String? email;
  String? pass;
  String? address;
  String? phone;
  String? facebook;
  String? insta;
  String? twit;
  bool isMale;

  DataInsertHelper({
    required this.name,
    required this.email,
    required this.pass,
    required this.address,
    required this.phone,
    required this.facebook,
    required this.insta,
    required this.twit,
    required this.isMale,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': pass,
      'address': address,
      'mobile': phone,
      'facebook': facebook,
      'insta': insta,
      'twitter': twit,
      'isMale': isMale,
    };
  }

  factory DataInsertHelper.fromJson(Map<String, dynamic> json) {
    return DataInsertHelper(
      name: json['name'],
      email: json['email'],
      pass: json['password'],
      address: json['address'],
      phone: json['mobile'],
      facebook: json['facebook'] ?? '',
      insta: json['insta'] ?? '',
      twit: json['twitter'] ?? '',
      isMale: json['isMale'] ?? true,
    );
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}
