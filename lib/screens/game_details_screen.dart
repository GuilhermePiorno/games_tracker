import 'package:flutter/material.dart';
import 'package:games_tracker/model/game.dart';
import 'package:games_tracker/model/user.dart';
import 'package:games_tracker/screens/add_review_screen.dart';

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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AddReviewScreen(game: widget.game, user: widget.user),
              ),
            );
          },
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${widget.game.name}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Data de lançamento: ${widget.game.release_date}"),
            Text("Média nota: ${widget.game.score}"),
            Text("Gênero: ${widget.game.genre}"),
            Text("Descrição: ${widget.game.description}"),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Editar jogo"),
              //TODO edição de jogo
              onPressed: () {},
            ),
            SizedBox(height: 15),
            ElevatedButton(
              child: Text("Excluir jogo"),
              //TODO exclusao de jogo
              onPressed: () {},
            ),
            SizedBox(height: 15),
            ..._mostraBtnReview(),
            SizedBox(height: 15),
            ElevatedButton(
              child: Text("Voltar"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
