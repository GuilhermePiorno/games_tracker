import 'package:flutter/material.dart';
import 'package:games_tracker/controller/DashboardController.dart';
import 'package:games_tracker/screens/filters_screen.dart';
import 'package:games_tracker/screens/game_details_screen.dart';
import 'package:games_tracker/screens/game_register_screen.dart';
import 'package:games_tracker/screens/recent_reviews_screen.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';
import 'package:games_tracker/model/game.dart';

class DashboardScreen extends StatefulWidget {
  final User user;

  const DashboardScreen({super.key, required this.user});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late DashboardController controller;
  String titulo = "";
  List<Game> gamesList = [];

  _DashboardScreenState() {
    this.controller = DashboardController();
  }

  void printgames() async {
    //Teste getGame
    //Game agame = await controller.getGame('God of War', '2018-04-18');
    //print("user_id: ${agame.user_id}");
    //print("Name: ${agame.name}");
    //print("Description: ${agame.description}");
    //print("Release: ${agame.release_date}");

    //Teste addgame
    // Game newgame = Game(user_id: 7, name: 'Baldurs Gate 3', description: 'Cool RPG game', release_date: '2023-08-08');
    // var confirm = controller.addGame(newgame);

    //Teste remove um jogo
    // controller.removeGame('God of War', '2018-04-18');

    //Teste altera um jogo.
    // Game umjogo = await controller.getGame('Persona 5', '2017-04-17');
    // controller.updateGame(umjogo, umjogo.name, umjogo.release_date, 'Jogo legal.');
    // print("user_id: ${umjogo.user_id}");
    // print("Name: ${umjogo.name}");
    // print("Description: ${umjogo.description}");
    // print("Release: ${umjogo.release_date}");

    //Teste getAllGamesWithScore()
    // List<Game> test = await controller.getAllGamesWithScore('release_date', 'DESC');
    // test.forEach((game){
    //   print("game_id: ${game.id}, name: ${game.name}, release: ${game.release_date}, description: ${game.description}");
    // });

    //Teste addReview
    // Review areview = Review(user_id: 7, game_id: 1, score: 9.9, description: "meh", date: "2024-07-02");
    // controller.addReview(areview);

    //Teste getAllReviews()
    // List<Review> testreview = await controller.getAllReviews('score', 'ASC');
    // testreview.forEach((review){
    //   print("auth_id: ${review.user_id}, game_id: ${review.game_id} score: ${review.score} description: ${review.description} date: ${review.date}");
    // });

    //Teste recentReviews()
    // List<Review> testreview2 = await controller.recentReviews();
    // testreview2.forEach((review){
    //   print("auth_id: ${review.user_id}, game_id: ${review.game_id} score: ${review.score} description: ${review.description} date: ${review.date}");
    // });

    //Teste getReview
    // Review someReview = await controller.getReview(2, 1);
    // print("auth_id: ${someReview.user_id}, game_id: ${someReview.game_id} score: ${someReview.score} description: ${someReview.description} date: ${someReview.date}");

    //Teste updateReview
    // controller.updateReview(someReview, 4, 'They ruined the game!');

    //Teste removeReview
    // controller.removeReview(7, 1);
  }

  void _preencheGamesNaoLogado() async {
    List<Game> games =
        await controller.getAllGamesWithScore('release_date', 'DESC');
    setState(() {
      gamesList = games;
    });
  }

  void _preencheGamesLogado() async {
    List<Game> games = await controller.getAllGamesByUser(
        'release_date', 'DESC', widget.user.id);
    setState(() {
      gamesList = games;
    });
  }

  void _setTitulo() {
    if (widget.user.id != -1) {
      titulo = "Dashboard de ${widget.user.name}";
    } else {
      titulo = "Dashboard anônimo";
    }
  }

  deslogar() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", 0);
    });
    Navigator.pop(context);
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
    _setTitulo();
    Widget corpo;

    if (widget.user.id != -1) {
      print(widget.user.id);
      // dashboard de usuário logado
      _preencheGamesLogado();
      corpo = Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(flex: 10, child: _geraListaDeJogos(widget.user)),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        width: 170,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GameRegisterScreen(
                                          user: widget.user))).then(
                                  (createdSuccess) {
                                _preencheGamesLogado();
                                if (createdSuccess != null && createdSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Novo jogo cadastrado com sucesso!'),
                                    ),
                                  );
                                }
                              });
                            },
                            child: Text("Cadastrar jogo"))),
                    SizedBox(
                        width: 100,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FiltersScreen(user: widget.user),
                                ),
                              );
                            },
                            child: Text("Filtrar"))),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        width: 170,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    RecentReviewsScreen(user: widget.user),
                              ),
                            );
                          },
                          child: Text("Reviews Recentes"),
                        )),
                    SizedBox(
                        width: 100,
                        child: ElevatedButton(
                            onPressed: deslogar, child: Text("Logout"))),
                  ],
                ),
              ),
            ],
          ));
    } else {
      // dashboard de usuário não logado
      _preencheGamesNaoLogado();
      corpo = Padding(
          padding: EdgeInsets.all(15),
          child: Column(children: [
            Expanded(flex: 10, child: _geraListaDeJogos(widget.user)),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RecentReviewsScreen(user: widget.user),
                        ),
                      );
                    },
                    child: Text("Reviews Recentes"),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                FiltersScreen(user: widget.user),
                          ),
                        );
                      },
                      child: Text("Filtrar")),
                ],
              ),
            ),
          ]));
    }
    return corpo;
  }

  @override
  void initState() {
    super.initState();
    _setTitulo();
  }

  @override
  Widget build(BuildContext context) {
    printgames();
    return Scaffold(
        appBar: AppBar(
          title: Text(titulo),
          backgroundColor: Colors.blue,
        ),
        body: _geraCorpo());
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
