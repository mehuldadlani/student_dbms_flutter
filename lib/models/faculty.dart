class FacultyModel {
  final int id;
  final String name;
  final String email;
  final String departmentName;
  final String phone;

  FacultyModel({
    required this.id,
    required this.name,
    required this.email,
    required this.departmentName,
    required this.phone,
  });

  factory FacultyModel.fromJson(Map<String, dynamic> json) {
    return FacultyModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      departmentName: json['department_name'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'department_name': departmentName,
      'phone': phone,
    };
  }

  @override
  String toString() {
    return 'FacultyModel(id: $id, name: $name, email: $email, departmentName: $departmentName, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FacultyModel &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.departmentName == departmentName &&
        other.phone == phone;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        departmentName.hashCode ^
        phone.hashCode;
  }
}
