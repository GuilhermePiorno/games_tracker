import 'package:flutter/material.dart';
import 'package:games_tracker/controller/DashboardController.dart';
import 'package:games_tracker/screens/game_details_screen.dart';
import 'package:intl/intl.dart';
import '../model/user.dart';
import 'package:games_tracker/model/game.dart';

class FilteredGamesScreen extends StatefulWidget {
  final User user;
  final String genre;

  const FilteredGamesScreen(
      {super.key, required this.user, required this.genre});

  @override
  State<FilteredGamesScreen> createState() => _FilteredGamesScreenState();
}

class _FilteredGamesScreenState extends State<FilteredGamesScreen> {
  late DashboardController controller;
  List<Game> gamesList = [];

  _FilteredGamesScreenState() {
    this.controller = DashboardController();
  }

  void _preencheGames() async {
    List<Game> games = await controller.getAllGamesByGenre(
        'release_date', 'DESC', widget.genre);
    setState(() {
      gamesList = games;
    });
  }

  ListView _geraListaDeJogos(User user) {
    List<ListItem> list = [];

    ListView lv = ListView(
      children: list,
    );

    for (var game in gamesList) {
      ListItem li = ListItem(game: game, user: user);
      list.add(li);
    }
    return lv;
  }

  Widget? _geraCorpo() {
    Widget corpo;

    _preencheGames();
    corpo = Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(flex: 10, child: _geraListaDeJogos(widget.user)),
            SizedBox(height: 15),
            ElevatedButton(
              child: Text("Voltar"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ));

    return corpo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("titulo"),
        backgroundColor: Colors.blue,
      ),
      body: _geraCorpo(),
    );
  }
}

class ListItem extends StatefulWidget {
  const ListItem({super.key, required this.game, required this.user});

  final Game game;
  final User user;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
          "${widget.game.name} - Média: ${NumberFormat("#,##0.00", "pt_BR").format(widget.game.score)}",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => GameDetailsScreen(
                    game: widget.game, user: widget.user))).then((_) {
          setState(() {});
        });
      },
    );
  }
}
