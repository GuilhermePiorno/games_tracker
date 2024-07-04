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
  DashboardController dashboardController = DashboardController();
  DateTime? dataLancamento;
  String txtData = "data";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar jogo"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: "Nome do jogo"),
          ),
          TextField(
            controller: descriptionController,
            maxLines: 10,
            decoration: InputDecoration(labelText: "Descrição do jogo"),
          ),
          Container(
            child: Column(
              children: [
                Text(txtData),
                ElevatedButton(
                  child: Text("Escolha a data de lançamento"), 
                  onPressed: () async {
                    dataLancamento = await showDatePicker(context: context, firstDate: DateTime.parse("1970-01-01"), lastDate: DateTime.now());
                    if(dataLancamento != null) {
                      setState(() { 
                        txtData = "${dataLancamento!.day}/${dataLancamento!.month}/${dataLancamento!.year}";
                      });
                    }
                  },
                ),
              ],
            ), 
          ),
          ElevatedButton(
            onPressed: () {
              if(nameController.text != null && descriptionController.text != null && dataLancamento != null) {
                dashboardController.getGame(nameController.text, "${dataLancamento!.year}-${dataLancamento!.month}-${dataLancamento!.day}").then((res){
                  Game game = res;
                  if(game.id != -1) {
                    print("Jogo já existe");
                  } else {
                    dashboardController.addGame(game);
                    print("Novo Jogo Cadastrado");
                  }
                });
              }
            }, 
            child: Text("Cadastrar")
          )
        ],
      ),
    );
  }
}