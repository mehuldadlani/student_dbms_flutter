import 'dart:convert';

class CourseModel {
  final String id;
  final String studentRegNo;
  final String description;
  final int credit;
  final String name;
  final String departmentName;
  final String faculty;

  CourseModel({
    required this.id,
    required this.studentRegNo,
    required this.description,
    required this.credit,
    required this.name,
    required this.departmentName,
    required this.faculty,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] ?? '',
      studentRegNo: json['student_reg_no'] ?? '',
      description: json['description'] ?? '',
      credit: json['credit'] ?? 0,
      name: json['name'] ?? '',
      departmentName: json['department_name'] ?? '',
      faculty: json['faculty'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_reg_no': studentRegNo,
      'description': description,
      'credit': credit,
      'name': name,
      'department_name': departmentName,
      'faculty': faculty,
    };
  }

  @override
  String toString() {
    return 'CourseModel(id: $id, studentRegNo: $studentRegNo, description: $description, credit: $credit, name: $name, departmentName: $departmentName, faculty: $faculty)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CourseModel &&
        other.id == id &&
        other.studentRegNo == studentRegNo &&
        other.description == description &&
        other.credit == credit &&
        other.name == name &&
        other.departmentName == departmentName &&
        other.faculty == faculty;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        studentRegNo.hashCode ^
        description.hashCode ^
        credit.hashCode ^
        name.hashCode ^
        departmentName.hashCode ^
        faculty.hashCode;
  }
}
