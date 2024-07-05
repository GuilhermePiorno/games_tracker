import 'package:flutter/material.dart';
import 'package:games_tracker/controller/DashboardController.dart';
import 'package:games_tracker/model/game.dart';
import 'package:games_tracker/model/review.dart';
import 'package:games_tracker/model/user.dart';

class AddReviewScreen extends StatefulWidget {
  final Game game;
  final User user;

  const AddReviewScreen({super.key, required this.game, required this.user});

  @override
  _AddReviewScreenState createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final TextEditingController _scoreController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final DashboardController _controller = DashboardController();

  void _addReview() async {
    double score = double.parse(_scoreController.text);
    String description = _descriptionController.text;
    String date = DateTime.now().toIso8601String();

    Review review = Review(
      user_id: widget.user.id!,
      game_id: widget.game.id!,
      score: score,
      description: description,
      date: date,
    );

    await _controller.addReview(review);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar review para ${widget.game.name}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _scoreController,
              decoration: InputDecoration(labelText: 'Nota (0-10)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descrição'),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addReview,
              child: Text('Concluir Review'),
            ),
          ],
        ),
      ),
    );
  }
}
