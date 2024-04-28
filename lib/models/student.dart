class StudentModel {
  final String regNo;
  final String name;
  final String email;
  final String departmentName;
  final int phone;
  final String dob;
  final String address;
  final int age;

  StudentModel({
    required this.regNo,
    required this.name,
    required this.email,
    required this.departmentName,
    required this.phone,
    required this.dob,
    required this.address,
    required this.age,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      regNo: json['reg_no'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      departmentName: json['department'] ?? '',
      phone: json['phone'] ?? 0,
      dob: json['dob'] ?? '',
      address: json['address'] ?? '',
      age: json['age'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reg_no': regNo,
      'name': name,
      'email': email,
      'department_name': departmentName,
      'phone': phone,
      'dob': dob,
      'address': address,
      'age': age,
    };
  }

  @override
  String toString() {
    return 'StudentModel(regNo: $regNo, name: $name, email: $email, departmentName: $departmentName, phone: $phone, dob: $dob, address: $address, age: $age)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StudentModel &&
        other.regNo == regNo &&
        other.name == name &&
        other.email == email &&
        other.departmentName == departmentName &&
        other.phone == phone &&
        other.dob == dob &&
        other.address == address &&
        other.age == age;
  }

  @override
  int get hashCode {
    return regNo.hashCode ^
        name.hashCode ^
        email.hashCode ^
        departmentName.hashCode ^
        phone.hashCode ^
        dob.hashCode ^
        address.hashCode ^
        age.hashCode;
  }



}
