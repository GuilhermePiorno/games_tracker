import 'package:flutter/material.dart';
import 'package:games_tracker/controller/DashboardController.dart';
import 'package:games_tracker/model/game.dart';
import 'package:games_tracker/model/user.dart';
import 'package:games_tracker/screens/add_review_screen.dart';
import 'package:games_tracker/screens/edit_game_screen.dart';

class GameDetailsScreen extends StatefulWidget {
  final Game game;
  final User user;

  const GameDetailsScreen({super.key, required this.game, required this.user});

  @override
  State<GameDetailsScreen> createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends State<GameDetailsScreen> {
  DashboardController dashboardController = DashboardController();
  bool _isOwner = false;

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
            ).then((createdSuccess) {
              if (createdSuccess != null && createdSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Review criada com sucesso!'),
                  ),
                );
              }
            });
          },
        ),
      );
    }
    return lista;
  }

  List<Widget> _mostraBtnExcluir() {
    List<Widget> lista = [];
    dashboardController
        .userIsTheOwnerOfGame(widget.user.id!, widget.game.id!)
        .then((res) {
      setState(() {
        _isOwner = res;
      });
    });
    if (_isOwner) {
      lista.add(
        ElevatedButton(
          child: Text("Excluir jogo"),
          onPressed: () async {
            int res = await dashboardController.removeGame(
                widget.game.name, widget.game.release_date);
            if (res > 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Jogo removido com sucesso!")),
              );
            }
          },
        ),
      );
    }
    return lista;
  }

  List<Widget> _mostraBtnEditar() {
    List<Widget> lista = [];

    dashboardController
        .userIsTheOwnerOfGame(widget.user.id!, widget.game.id!)
        .then((res) {
      setState(() {
        _isOwner = res;
      });
    });

    if (_isOwner) {
      lista.add(
        ElevatedButton(
          child: Text("Editar jogo"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditGameScreen(game: widget.game),
              ),
            ).then((editedSuccess) {
              if (editedSuccess != null && editedSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Jogo editado com sucesso!'),
                  ),
                );
              }
            });
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
            ..._mostraBtnReview(),
            SizedBox(height: 15),
            ..._mostraBtnEditar(),
            SizedBox(height: 15),
            ..._mostraBtnExcluir(),
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
