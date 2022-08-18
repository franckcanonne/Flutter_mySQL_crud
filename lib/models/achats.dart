class Course {
  final int id;
  final String name;
  final int age;

  Course({this.id, this.name, this.age});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      name: json['name'],
      age: json['age'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'age': age,
      };
}
