import 'package:flutter/material.dart';
import 'package:games_tracker/model/review.dart';

class ReviewDetailsScreen extends StatefulWidget {
  final Review review;

  const ReviewDetailsScreen({super.key, required this.review});

  @override
  State<ReviewDetailsScreen> createState() => _ReviewDetailsScreenState();
}

class _ReviewDetailsScreenState extends State<ReviewDetailsScreen> {
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
            Text("Jogo: ${widget.review.game_name}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Nota: ${widget.review.score}"),
            Text("Descrição: ${widget.review.description}"),
            Text("Data de criação: ${widget.review.date}"),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Editar review"),
              //TODO edição de review
              onPressed: () {},
            ),
            SizedBox(height: 15),
            ElevatedButton(
              child: Text("Excluir review"),
              //TODO exclusao de review
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
