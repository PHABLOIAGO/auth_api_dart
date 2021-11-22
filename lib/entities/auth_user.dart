import 'dart:convert';

class AuthUser {
  final String x_Hasura_user_id;
  final String x_hasura_role;
  final bool x_hasura_is_owner;
  // final String iat;

  AuthUser({required this.x_Hasura_user_id, required this.x_hasura_role, required this.x_hasura_is_owner});

  Map<String, dynamic> toMap() {
    return {
      'x-hasura-user-id': x_Hasura_user_id,
      'x-hasura-role': x_hasura_role,
      'x-hasura-is-owner': x_hasura_is_owner.toString(),
      // 'iat': iat,
    };
  }

  factory AuthUser.fromMap(Map<String, dynamic> map) {
    return AuthUser(
      x_Hasura_user_id: map['x-hasura-user-id'],
      x_hasura_role: map['x-hasura-role'],
      x_hasura_is_owner: map['x-hasura-is-owner'].toLowerCase() == 'true',
      // iat: map['iat'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthUser.fromJson(String source) => AuthUser.fromMap(json.decode(source));

  AuthUser copyWith({
    String? x_Hasura_user_id,
    String? x_hasura_role,
    bool? x_hasura_is_owner,
    // String? iat,
  }) {
    return AuthUser(
      x_Hasura_user_id: x_Hasura_user_id ?? this.x_Hasura_user_id,
      x_hasura_role: x_hasura_role ?? this.x_hasura_role,
      x_hasura_is_owner: x_hasura_is_owner ?? this.x_hasura_is_owner,
      // iat: iat ?? this.iat,
    );
  }
}
