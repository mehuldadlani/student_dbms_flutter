class ExamModel {
  final int id;
  final String courseId;
  final String examType;
  final String examDate;

  ExamModel({
    required this.id,
    required this.courseId,
    required this.examType,
    required this.examDate,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      id: json['id'] ?? 0,
      courseId: json['course_id'] ?? '',
      examType: json['exam_type'] ?? '',
      examDate: json['exam_date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'course_id': courseId,
      'exam_type': examType,
      'exam_date': examDate,
    };
  }

  @override
  String toString() {
    return 'ExamModel(id: $id,courseId: $courseId, examType: $examType, examDate: $examDate)';
  }

  @override

  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExamModel &&
        other.id == id &&
        other.courseId == courseId &&
        other.examType == examType &&
        other.examDate == examDate;
  }

  @override
  int get hashCode {

    return id.hashCode ^ courseId.hashCode ^ examType.hashCode ^ examDate.hashCode;
  }
}
