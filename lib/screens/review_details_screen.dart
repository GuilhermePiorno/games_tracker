import 'package:flutter/material.dart';
import 'package:games_tracker/controller/DashboardController.dart';
import 'package:games_tracker/model/review.dart';
import 'package:games_tracker/model/user.dart';

class ReviewDetailsScreen extends StatefulWidget {
  final Review review;
  final User user;

  const ReviewDetailsScreen(
      {super.key, required this.review, required this.user});

  @override
  State<ReviewDetailsScreen> createState() => _ReviewDetailsScreenState();
}

class _ReviewDetailsScreenState extends State<ReviewDetailsScreen> {
  DashboardController dashboardController = DashboardController();

  List<Widget> _mostraBtnEditar() {
    List<Widget> lista = [];

    if (widget.user.id == widget.review.user_id) {
      lista.add(ElevatedButton(
        child: Text("Editar review"),
        //TODO edição de review
        onPressed: () {},
      ));
    }

    return lista;
  }

  List<Widget> _mostraBtnExcluir() {
    List<Widget> lista = [];

    if (widget.user.id == widget.review.user_id) {
      lista.add(
        ElevatedButton(
          child: Text("Excluir review"),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Aviso"),
                  content: Text(
                      "Essa ação não tem volta, deseja mesmo excluir a review?"),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Não'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Sim'),
                      onPressed: () {
                        dashboardController.removeReview(widget.review.id);
                        Navigator.pop(context);
                        Navigator.pop(context, true);
                      },
                    )
                  ],
                );
              },
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
        title: Text('Review número ${widget.review.id}'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Jogo: ${widget.review.game_name}"),
            Text("Nota: ${widget.review.score}"),
            Text("Descrição: ${widget.review.description}"),
            Text("Data de criação: ${widget.review.date}"),
            Text("Criada pelo usuário: ${widget.review.user_name}"),
            SizedBox(height: 20),
            ..._mostraBtnEditar(),
            SizedBox(height: 15),
            ..._mostraBtnExcluir(),
          ],
        ),
      ),
    );
  }
}
