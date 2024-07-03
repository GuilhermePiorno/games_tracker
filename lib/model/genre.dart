import 'dart:convert';

class Genre {
  int? id;
  String name;

  Genre({this.id, required this.name});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": this.id,
      "name": this.name,
    };
  }

  factory Genre.fromMap(Map<String, dynamic> map) {
    return Genre(
      id: map["id"] ??= map["id"],
      name: map["name"] as String,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory Genre.fromJson(String source) =>
      Genre.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
