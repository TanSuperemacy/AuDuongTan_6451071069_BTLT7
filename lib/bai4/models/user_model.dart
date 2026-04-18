// bai4/models/user_model.dart

class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String website;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.website,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as int? ?? 0,
        name: json['name'] as String? ?? '',
        email: json['email'] as String? ?? '',
        phone: json['phone'] as String? ?? '',
        website: json['website'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'website': website,
      };

  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? website,
  }) =>
      UserModel(
        id: id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        website: website ?? this.website,
      );
}
