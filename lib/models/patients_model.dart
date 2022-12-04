// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// import 'package:flutter/material.dart';

class Patients {
  final String email;
  final String firstName;
  final String lastName;
  final String role;
  final String id;
  final int at;
  final String patientCase;

  Patients({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.id,
    required this.at,
    required this.patientCase,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'role': role,
      'id': id,
      'at': at,
      'patientCase': patientCase,
    };
  }

  factory Patients.fromMap(Map<String, dynamic> map) {
    return Patients(
      email: map['email'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      role: map['role'] as String,
      id: map['_id'] as String,
      at: map['at'] as int,
      patientCase: map['patientCase'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Patients.fromJson(String source) =>
      Patients.fromMap(json.decode(source) as Map<String, dynamic>);
}
