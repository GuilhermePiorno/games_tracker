import 'package:flutter/material.dart';
import 'package:games_tracker/controller/DashboardController.dart';
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

  _DashboardScreenState(){
    this.controller = DashboardController();
  }

  void printgames() async{
    
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
    // List<Game> test = await controller.getAllGames();
    // test.forEach((game){
    //   print("game numer: ${game.id}");
    //   print("game name: ${game.name}");
    // });

  }

  void _setTitulo() {
    if (widget.user.id != -1) {
      titulo = "Dashboard de ${widget.user.name}";
    } else {
      titulo = "Dashboard anônimo";
    }
  }

  fuckit() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", 0);
    });
  }

  Widget? _geraCorpo() {
    _setTitulo();
    Widget corpo;

    if (widget.user.id != -1) {
      // dashboard de usuário logado
      // corpo = Text("Usuário ${widget.user.id}");
      corpo = ElevatedButton(onPressed: fuckit, child: Text("Logout"));
    } else {
      // dashboard de usuário não logado
      // corpo = Text("Usuário anônimo");
      corpo = ElevatedButton(onPressed: fuckit, child: Text("Logout"));
    }
    return corpo;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setTitulo();
  }

  @override
  Widget build(BuildContext context) {
    printgames();
    return Scaffold(
        appBar: AppBar(
          title: Text(titulo),
        ),
        body: _geraCorpo());
  }
}
