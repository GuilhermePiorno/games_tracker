import 'package:games_tracker/model/game.dart';
import '../helper/DatabaseHelper.dart';
import '../model/review.dart';

class DashboardController {
  DatabaseHelper con = DatabaseHelper();

  Future<int> addGame(Game game) async {
    var db = await con.db;
    int res = await db.insert('game', game.toMap());
    return res;
  }

  Future<int> removeGame(String name, String releaseDate) async {
    var db = await con.db;
    int res = await db.delete("game",
        where: "name = ? AND release_date = ?", whereArgs: [name, releaseDate]);
    return res;
  }

  Future<int> updateGame(
      Game game, String newname, String newdate, String newDescription) async {
    var db = await con.db;

    int count = await db.rawUpdate(
        'UPDATE game SET name = ?, release_date = ?, description = ? WHERE name = ? AND release_date = ?',
        [newname, newdate, newDescription, game.name, game.release_date]);
    return count;
  }

  Future<Game> getGame(String name, String releaseDate) async {
    var db = await con.db;
    String sql = """
      SELECT game.*, 
        genre.name AS genre,
        IFNULL(AVG(review.score), 0.0) AS score 
      FROM game 
      INNER JOIN game_genre ON game.id = game_genre.game_id
      INNER JOIN genre ON game_genre.genre_id = genre.id
      LEFT JOIN review ON game.id = review.game_id
      WHERE game.name = '${name}' AND game.release_date = '${releaseDate}' 
      GROUP BY game.id, game.name, game.release_date
      """;
    var res = await db.rawQuery(sql);

    if (res.length > 0) {
      return Game.fromMap(res.first);
    }

    return Game(
        id: -1,
        user_id: -1,
        name: "",
        release_date: '1970-01-01',
        description: "",
        genre: "");
  }

  Future<List<Game>> getAllGames(
      [String coluna = 'name', String ordem = 'ASC']) async {
    var db = await con.db;

    String sort = coluna + ' ' + ordem;
    String sql = """
      SELECT game.*, 
        genre.name AS genre, 
        IFNULL(AVG(review.score), 0.0) AS score
      FROM game 
      INNER JOIN game_genre ON game.id = game_genre.game_id
      INNER JOIN genre ON game_genre.genre_id = genre.id
      LEFT JOIN review ON game.id = review.game_id
      GROUP BY game.id, game.name, game.release_date
      ORDER BY $sort
      """;
    var res = await db.rawQuery(sql);

    List<Game> list =
        res.isNotEmpty ? res.map((c) => Game.fromMap(c)).toList() : [];

    return list;
  }

  Future<int> addReview(Review review) async {
    var db = await con.db;
    int res = await db.insert('review', review.toMap());
    return res;
  }

  Future<List<Review>> getAllReviews(
      [String coluna = 'game_id', String ordem = 'ASC']) async {
    var db = await con.db;
    String sort = coluna + ' ' + ordem;
    var res = await db.query("review", orderBy: sort);

    List<Review> list =
        res.isNotEmpty ? res.map((c) => Review.fromMap(c)).toList() : [];

    return list;
  }

  Future<List<Review>> recentReviews() async {
    DateTime sete_dias_atras = DateTime.now().subtract(Duration(days: 7));

    var db = await con.db;

    String sql = """
      SELECT review.*, game.name AS game_name
      FROM review
      INNER JOIN game ON review.game_id = game.id
      WHERE review.date >= ? 
      ORDER BY review.date DESC
    """;
    var res = await db.rawQuery(sql, [sete_dias_atras.toIso8601String()]);

    List<Review> list =
        res.isNotEmpty ? res.map((c) => Review.fromMap(c)).toList() : [];

    return list;
  }

  Future<Review> getReview(int user_id, int game_id) async {
    var db = await con.db;
    String sql = """
      SELECT * FROM review WHERE user_id = '${user_id}' AND game_id = '${game_id}' 
      """;
    var res = await db.rawQuery(sql);

    if (res.length > 0) {
      return Review.fromMap(res.first);
    }

    return Review(
        user_id: -1,
        game_id: -1,
        game_name: "",
        score: -1,
        description: "",
        date: "1970-01-01");
  }

  Future<int> removeReview(int user_id, int game_id) async {
    var db = await con.db;
    int res = await db.delete("review",
        where: "user_id = ? AND game_id = ?", whereArgs: [user_id, game_id]);
    return res;
  }

  Future<int> updateReview(Review review, double newscore,
      String newDescription, String newDate) async {
    var db = await con.db;

    int count = await db.rawUpdate(
        'UPDATE review SET score = ?, description = ?, date WHERE user_id = ? AND game_id = ?',
        [newscore, newDescription, newDate, review.user_id, review.game_id]);
    return count;
  }
}
