class StudentCourseFacultyModel {
  final String studentRegNo;
  final String courseCode;
  final int facultyId;

  StudentCourseFacultyModel({
    required this.studentRegNo,
    required this.courseCode,
    required this.facultyId,
  });

  factory StudentCourseFacultyModel.fromJson(Map<String, dynamic> json) {
    return StudentCourseFacultyModel(
      studentRegNo: json['student_reg_no'] ?? '',
      courseCode:
          json['course_id'] ?? '', // Ensure 'course_id' is correctly mapped
      facultyId: json['faculty_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'student_reg_no': studentRegNo,
      'course_id': courseCode, // Make sure it matches the key from the response
      'faculty_id': facultyId,
    };
  }

  @override
  String toString() {
    return 'StudentCourseFacultyModel(studentRegNo: $studentRegNo, courseCode: $courseCode, facultyId: $facultyId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StudentCourseFacultyModel &&
        other.studentRegNo == studentRegNo &&
        other.courseCode == courseCode &&
        other.facultyId == facultyId;
  }
  
  @override
  int get hashCode {
    return studentRegNo.hashCode ^ courseCode.hashCode ^ facultyId.hashCode;
  }
  
}
