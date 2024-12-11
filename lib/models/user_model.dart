class UserModel {
  String id;
  String email;
  String role; // admin or team member

  UserModel({required this.id, required this.email, required this.role});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'role': role,
    };
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      role: json['role'],
    );
  }
}
