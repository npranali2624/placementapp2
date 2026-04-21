// work_location_model.dart
class WorkLocationModel {
  final String address;
  final String contactPersonName;
  final String contactNumber;
  final String mail;

  const WorkLocationModel({
    required this.address,
    required this.contactPersonName,
    required this.contactNumber,
    required this.mail,
  });

  factory WorkLocationModel.fromJson(Map<String, dynamic> json) {
    return WorkLocationModel(
      address: json['address'] ?? '',
      contactPersonName: json['contactpersonname'] ?? '',
      contactNumber: json['contactNumber'] ?? '',
      mail: json['mail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'contactpersonname': contactPersonName,
      'contactNumber': contactNumber,
      'mail': mail,
    };
  }
}