class Review {
  int? id;
  int? userId;
  int? gameId;
  double? score;
  String? description;
  DateTime? date;

  Review(this.userId, this.gameId, this.score, this.description, this.date);

  Review.fromMap(Map map) {
    this.id = map["id"];
    this.userId = map["user_id"];
    this.gameId = map["game_id"];
    this.score = map["score"];
    this.description = map["description"];
    this.date = map["date"];
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "user_id": this.userId,
      "game_id": this.gameId,
      "score": this.score,
      "description": this.description,
      "date": this.date.toString()
    };
    
    if (this.id != null) {
      map["id"] = this.id;
    }
    
    return map; 
  }
}