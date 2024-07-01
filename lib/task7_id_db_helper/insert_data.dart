import 'dart:convert';

class insert_data {
  String? name;
  String? Company;
  String? id;
  String? Technology;
  String? dob;
  String? allDetails;

  insert_data({
    required this.name,
    required this.Company,
    required this.id,
    required this.Technology,
    required this.dob,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'Company': Company,
      'Technology': Technology,
      'dob': dob,
    };
  }

  factory insert_data.fromJson(Map<String, dynamic> json) {
    return insert_data(
      name: json['name'],
      Company: json['Company'],
      id: json['id'],
      Technology: json['Technology'],
      dob: json['dob'],
    );
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}
