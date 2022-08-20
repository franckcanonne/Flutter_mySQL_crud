class Achat {
  final int id;
  final String name;
  final int age;

  Achat({this.id, this.name, this.age});

  factory Achat.fromJson(Map<String, dynamic> json) {
    return Achat(
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
