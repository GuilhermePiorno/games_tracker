import 'dart:convert';

class Review {
  int? id;
  int user_id;
  int game_id;
  String game_name;
  double score;
  String description;
  String date;

  Review(
      {this.id,
      required this.user_id,
      required this.game_id,
      required this.game_name,
      required this.score,
      required this.description,
      required this.date});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": this.id,
      "user_id": this.user_id,
      "game_id": this.game_id,
      "score": this.score,
      "description": this.description,
      "date": this.date
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
        id: map["id"] ??= map["id"],
        user_id: map["user_id"] as int,
        game_id: map["game_id"] as int,
        game_name: map["game_name"] as String,
        score: map["score"] as double,
        description: map["description"] as String,
        date: map["date"] as String);
  }

  String toJson() => jsonEncode(toMap());

  factory Review.fromJson(String source) =>
      Review.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
