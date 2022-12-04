// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String role;
  final String id;
  final String token;

  User({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.id,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'role': role,
      'id': id,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'] as String,
      password: map['password'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      role: map['role'] as String,
      id: map['_id'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
