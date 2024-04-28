class CourseModel {
  final String id;
  final String description;
  final int credit;
  final String name;
  final String departmentName;

  CourseModel({
    required this.id,
    required this.description,
    required this.credit,
    required this.name,
    required this.departmentName,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] ?? '',
      description: json['description'] ?? '',
      credit: json['credit'] ?? 0,
      name: json['name'] ?? '',
      departmentName: json['department_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'credit': credit,
      'name': name,
      'department_name': departmentName,
    };
  }

  @override
  String toString() {
    return 'CourseModel(id: $id, description: $description, credit: $credit, name: $name, departmentName: $departmentName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CourseModel &&
        other.id == id &&
        other.description == description &&
        other.credit == credit &&
        other.name == name &&
        other.departmentName == departmentName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        description.hashCode ^
        credit.hashCode ^
        name.hashCode ^
        departmentName.hashCode;
  }
}
