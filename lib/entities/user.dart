import 'dart:convert';

class User {
  final String? id;
  final String? name;
  final String? login;
  final String? password;
  final String? role;
  final bool? active;
  final DateTime? created_at;
  final DateTime? updated_at;

  User({
    this.id,
    this.name,
    this.login,
    this.password,
    this.role,
    this.active,
    this.created_at,
    this.updated_at
  });

  User copyWith({
    String? id,
    String? name,
    String? login,
    String? password,
    String? role,
    bool? active,
    DateTime? created_at,
    DateTime? updated_at,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      login: login ?? this.login,
      password: password ?? this.password,
      role: role ?? this.role,
      active: active ?? this.active,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'login': login,
      'password': password,
      'role': role,
      'active': active,
      'created_at': created_at?.toIso8601String(),
      'updated_at': updated_at?.toIso8601String(),
    };
  }

  Map<String, dynamic> toMapSave() {
    return {
      'name': name,
      'login': login,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      login: map['login'],
      password: map['password'],
      role: map['role'],
      active: map['active'],
      created_at: map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updated_at: map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }

  String toJsonSave() => json.encode(toMapSave());
  
  String toJson() => json.encode(toMap());
  
  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
