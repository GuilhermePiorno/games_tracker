import 'package:flutter/material.dart';
import 'package:games_tracker/controller/DashboardController.dart';
import 'package:games_tracker/screens/game_details_screen.dart';
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
    // Game agame = await controller.getGame('God of War', '2018-04-18');
    // print("user_id: ${agame.user_id}");
    // print("Name: ${agame.name}");
    // print("Description: ${agame.description}");
    // print("Release: ${agame.release_date}");

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

    //Teste getAllGames()
    // List<Game> test = await controller.getAllGames('release_date', 'DESC');
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

  void _getGames() async {
    List<Game> games = await controller.getAllGames('release_date', 'DESC');
    for (var game in games) {
      gamesList.add(game);
    }

    setState(() {});
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

  ListView _geraListaDeJogos() {
    List<ListItem> list = [];
    ListView lv = ListView(children: list,);
    for (var game in gamesList) {
      ListItem li = ListItem(game: game);
      list.add(li);
    }
    return lv;
  }

  Widget? _geraCorpo() {
    _setTitulo();
    Widget corpo;

    if (widget.user.id != -1) {
      // dashboard de usuário logado
      // corpo = Text("Usuário ${widget.user.id}");
      corpo = Column(
        children: [
          Expanded(
            flex: 10,
            child: _geraListaDeJogos()
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: (){}, child: Text("Cadastrar jogo")),
                ElevatedButton(onPressed: (){}, child: Text("Filtrar")),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: (){}, child: Text("Reviews Recentes")),
                ElevatedButton(onPressed: deslogar, child: Text("Logout")),
              ],
            ),
          ),
        ],
      );
    } else {
      // dashboard de usuário não logado
      // corpo = Text("Usuário anônimo");
      corpo = Center(
          child: Column(children: [
        Expanded(
            child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: gamesList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                height: 150,
                child: Column(children: [
                  Text("Nome: ${gamesList[index].name}"),
                  Text("Data de lançamento: ${gamesList[index].release_date}"),
                  Text("Descrição: ${gamesList[index].description}"),
                  Text("Gênero: ${gamesList[index].genre}"),
                  Text("Média nota: ${gamesList[index].score}")
                ]));
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ))
      ]));

      // ElevatedButton(onPressed: fuckit, child: Text("Logout"));
    }
    return corpo;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setTitulo();
    _getGames();
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
  const ListItem({super.key, required this.game});

  final Game game;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(widget.game.name + " (Média: " + widget.game.score.toString() + ")"),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GameDetailsScreen(game: widget.game)),
        );
      },
    );
  }
}