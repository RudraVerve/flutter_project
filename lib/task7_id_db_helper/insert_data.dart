import 'dart:convert';

class insert_data {
  String? name;
  String? colage;
  String? roll;
  String? domen;
  String? dob;
  String? allDetails;

  insert_data({
    required this.name,
    required this.colage,
    required this.roll,
    required this.domen,
    required this.dob,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'colage': colage,
      'domen': domen,
      'dob': dob,
    };
  }

  factory insert_data.fromJson(Map<String, dynamic> json) {
    return insert_data(
      name: json['name'],
      colage: json['colage'],
      roll: json['roll'],
      domen: json['domen'],
      dob: json['dob'],
    );
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}
