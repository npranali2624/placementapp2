class StudentModel {
  final String fullName;
  final String email;
  final String phone;
  final String course;
  final String branch;
  final String year;
  final String cgpa;
  final String skills;
  final String collegeName;
  final String yearOfPassing;

  const StudentModel({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.course,
    required this.branch,
    required this.year,
    required this.cgpa,
    required this.skills,
    required this.collegeName,
    required this.yearOfPassing,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      course: json['course'] ?? '',
      branch: json['branch'] ?? '',
      year: json['year'] ?? '',
      cgpa: json['cgpa'] ?? '',
      skills: json['skills'] ?? '',
      collegeName: json['collegeName'] ?? '',
      yearOfPassing: json['yearOfPassing'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'course': course,
      'branch': branch,
      'year': year,
      'cgpa': cgpa,
      'skills': skills,
      'collegeName': collegeName,
      'yearOfPassing': yearOfPassing,
    };
  }
}