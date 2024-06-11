import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.role,
      this.createdAt});
  final int? id;
  final String? name;
  final String? email;
  final String? password;
  final String? role;
  final String? createdAt;
  User copyWith(
      {int? id,
      String? name,
      String? email,
      String? password,
      String? role,
      String? createdAt}) {
    return User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        role: role ?? this.role,
        createdAt: createdAt ?? this.createdAt);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['name'] = name;
    map['email'] = email;
    map['password'] = password;
    map['role'] = role;
    map['createdAt'] = createdAt;
    return map;
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
      createdAt: json['createdAt']);

  @override
  String toString() {
    return 'User{id=$id, name=$name, email=$email, password=$password, role=$role, createdAt=$createdAt}';
  }

  @override
  List<Object?> get props => [id, name, email, password, role, createdAt];
}
