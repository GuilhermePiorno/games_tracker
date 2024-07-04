import 'package:flutter/material.dart';
import 'package:games_tracker/model/game.dart';
import 'package:games_tracker/model/user.dart';

class GameDetailsScreen extends StatefulWidget {
  final Game game;
  final User user;

  const GameDetailsScreen({super.key, required this.game, required this.user});

  @override
  State<GameDetailsScreen> createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends State<GameDetailsScreen> {
  List<Widget> _mostraBtnReview() {
    List<Widget> lista = [];

    if (widget.user.id != -1) {
      lista.add(
        ElevatedButton(
          child: Text("Cadastrar review"),
          onPressed: () {},
        ),
      );
    }
    return lista;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.game.name),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Text("${widget.game.name}"),
          Text("Data de lançamento: ${widget.game.release_date}"),
          Text("Média nota: ${widget.game.score}"),
          Text("Gênero: ${widget.game.genre}"),
          Text("Descrição: ${widget.game.description}"),
          ..._mostraBtnReview(),
          ElevatedButton(
            child: Text("Voltar"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
