import 'package:flutter/material.dart';
import 'package:games_tracker/controller/DashboardController.dart';
import 'package:games_tracker/model/review.dart';

class EditReviewScreen extends StatefulWidget {
  final Review review;

  const EditReviewScreen({super.key, required this.review});

  @override
  _EditReviewScreenState createState() => _EditReviewScreenState();
}

class _EditReviewScreenState extends State<EditReviewScreen> {
  final TextEditingController _scoreController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final DashboardController _controller = DashboardController();

  void _editaReview() async {
    double newScore = double.parse(_scoreController.text);
    String newDescription = _descriptionController.text;

    await _controller.updateReview(widget.review, newScore, newDescription);

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editando review ${widget.review.id}',
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _scoreController,
              decoration: InputDecoration(
                labelText: 'Nova nota',
                helperText: "A nota deve ser entre 0 e 10",
                helperStyle: TextStyle(color: Colors.blueAccent),
                filled: true,
              ),
              keyboardType: TextInputType.number,
              maxLength: 2,
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                  labelText: 'Nova descrição',
                  helperText: "Máximo 5 linhas",
                  helperStyle: TextStyle(color: Colors.blueAccent)),
              minLines: 1,
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (int.parse(_scoreController.text) >= 0 &&
                    int.parse(_scoreController.text) <= 10) {
                  _editaReview();
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Erro"),
                        content: Text("A nota precisa ser entre 0 e 10."),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Ok, fechar'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Concluir Edição'),
            ),
          ],
        ),
      ),
    );
  }
}
