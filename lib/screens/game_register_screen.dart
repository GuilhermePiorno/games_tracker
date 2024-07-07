import 'package:flutter/material.dart';
import 'package:games_tracker/controller/DashboardController.dart';
import 'package:games_tracker/model/game.dart';
import 'package:games_tracker/model/user.dart';

class GameRegisterScreen extends StatefulWidget {
  final User user;

  const GameRegisterScreen({super.key, required this.user});

  @override
  State<GameRegisterScreen> createState() => _GameRegisterScreenState();
}

class _GameRegisterScreenState extends State<GameRegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController genreController = TextEditingController();
  DashboardController dashboardController = DashboardController();
  DateTime? dataLancamento;
  String txtData = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar jogo"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Nome do jogo",
                  helperText: "Máximo de 50 caracteres",
                  helperStyle: TextStyle(color: Colors.blueAccent),
                  filled: true,
                ),
                maxLength: 50,
              ),
              TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: "Descrição do jogo",
                    helperText: "Máximo de 10 linhas",
                    helperStyle: TextStyle(color: Colors.blueAccent),
                    filled: true,
                  ),
                  minLines: 1,
                  maxLines: 10),
              TextField(
                controller: genreController,
                decoration: InputDecoration(
                  labelText: "Gênero do jogo",
                  helperText: "Máximo de 50 caracteres",
                  helperStyle: TextStyle(color: Colors.blueAccent),
                  filled: true,
                ),
                maxLength: 50,
              ),    
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Text(
                  "Data de lançamento: " + txtData,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text("Escolha"),
                  onPressed: () async {
                    dataLancamento = await showDatePicker(
                        context: context,
                        firstDate: DateTime.parse("1970-01-01"),
                        lastDate: DateTime.now());
                    if (dataLancamento != null) {
                      setState(() {
                        txtData =
                            "${dataLancamento!.day}/${dataLancamento!.month}/${dataLancamento!.year}";
                      });
                    }
                  },
                )
              ]),
              ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isNotEmpty &&
                        descriptionController.text.isNotEmpty &&
                        dataLancamento != null) {
                      dashboardController
                          .getGame(nameController.text,
                              "${dataLancamento!.year}-${dataLancamento!.month}-${dataLancamento!.day}")
                          .then((res) {
                        if (res.id != -1) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Jogo já existe!')),
                          );
                        } else {
                          Game novoJogo = Game(
                            user_id: widget.user.id!, 
                            name: nameController.text, 
                            release_date: dataLancamento!.toIso8601String().substring(0, 11), 
                            description: descriptionController.text, 
                            genre: genreController.text);
                          dashboardController.addGame(novoJogo);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Novo jogo cadastrado com sucesso!')),
                          );
                        }
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Não foi possível cadastrar o jogo, tente novamente')),
                      );
                    }
                  },
                  child: Text("Cadastrar"))
            ],
          )),
    );
  }
}
