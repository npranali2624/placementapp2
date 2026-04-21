// company_model.dart
import 'package:flutter/material.dart';

class CompanyModel {
  final String name;
  final String initial;
  final Color color;
  final Color bgColor;
  final String email;
  final String location;
  final String strength;
  final int openings;
  final String type;

  const CompanyModel({
    required this.name,
    required this.initial,
    required this.color,
    required this.bgColor,
    required this.email,
    required this.location,
    required this.strength,
    required this.openings,
    required this.type,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      name: json['name'] ?? '',
      initial: json['initial'] ?? '',
      color: Color(json['color'] ?? 0xFF2563EB),
      bgColor: Color(json['bgColor'] ?? 0xFFEFF6FF),
      email: json['email'] ?? '',
      location: json['location'] ?? '',
      strength: json['strength'] ?? '',
      openings: json['openings'] ?? 0,
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'initial': initial,
      'color': color.value,
      'bgColor': bgColor.value,
      'email': email,
      'location': location,
      'strength': strength,
      'openings': openings,
      'type': type,
    };
  }
}