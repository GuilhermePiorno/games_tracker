import 'dart:convert';

class Game {
  int? id;
  int user_id;
  String name;
  String release_date;
  String description;
  String genre;

  Game({
    this.id,
    required this.user_id,
    required this.name,
    required this.release_date,
    required this.description,
    required this.genre,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": this.id,
      "user_id": this.user_id,
      "name": this.name,
      "release_date": this.release_date,
      "description": this.description,
      "genre": this.description
    };
  }

  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(
        id: map["id"] ??= map["id"],
        user_id: map["user_id"] as int,
        name: map["name"] as String,
        release_date: map["release_date"] as String,
        description: map["description"] as String,
        genre: map["genre"] as String);
  }

  String toJson() => jsonEncode(toMap());

  factory Game.fromJson(String source) =>
      Game.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
