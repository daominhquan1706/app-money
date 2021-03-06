class User {
  int id;
  String name;

  User({this.id, this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'] as int, name: json['name'] as String);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
