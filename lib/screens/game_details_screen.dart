import 'package:flutter/material.dart';
import 'package:games_tracker/model/game.dart';

class GameDetailsScreen extends StatefulWidget {

  final Game game;
  
  const GameDetailsScreen({super.key, required this.game});

  @override
  State<GameDetailsScreen> createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends State<GameDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.game.name),
      ),
      body: Column(
        children: [
          ElevatedButton(
            child: Text("Cadastrar review"), 
            onPressed: (){}
          ),
          ElevatedButton(
            child: Text("Voltar"), 
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}