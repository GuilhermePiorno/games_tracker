import 'package:games_tracker/model/game.dart';
import '../helper/DatabaseHelper.dart';
import '../model/user.dart';

class DashboardController{
  DatabaseHelper con = DatabaseHelper();

  Future<int> addGame(Game game) async{
    var db = await con.db;
    int res = await db.insert('game', game.toMap());
    return res;
  }

  Future<int> removeGame(String name, String releaseDate) async {
    var db = await con.db;
    int res = await db.delete("game", where: "name = ? AND release_date = ?", whereArgs: [name, releaseDate]);
    return res;
  }

  Future<int> updateGame(Game game, String newname, String newdate, String newDescription) async {
    var db = await con.db;

    int count = await db.rawUpdate(
  'UPDATE game SET name = ?, release_date = ?, description = ? WHERE name = ? AND release_date = ?',
  [newname, newdate, newDescription, game.name, game.release_date]);
    return count;
  }

  Future<Game> getGame(String name, String releaseDate) async {
    var db = await con.db;
    String sql = """
      SELECT * FROM game WHERE name = '${name}' AND release_date = '${releaseDate}' 
      """;
    var res = await db.rawQuery(sql);

    if (res.length > 0) {
      return Game.fromMap(res.first);
    }

    return Game(id: -1, user_id: -1, name: "", release_date: '1970-01-01', description: "");
  }


  Future<List<Game>> getAllGames() async {
    var db = await con.db;

    var res = await db.query("game");

    List<Game> list =
        res.isNotEmpty ? res.map((c) => Game.fromMap(c)).toList() : [];

    return list;
  }
}
