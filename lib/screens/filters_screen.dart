import 'package:flutter/material.dart';
import '../model/user.dart';

class FiltersScreen extends StatefulWidget {
  final User user;

  const FiltersScreen({super.key, required this.user});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  TextEditingController genreController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController scoreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buscar jogos"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: genreController,
                decoration: InputDecoration(
                  labelText: "Gênero",
                  helperText: "Filtrar jogo por gênero",
                  helperStyle: TextStyle(color: Colors.blueAccent),
                  filled: true,
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // TODO: filtrar por gênero
                },
                child: Text("Buscar"),
              ),
              SizedBox(height: 15),
              TextField(
                controller: dateController,
                decoration: InputDecoration(
                  labelText: "Data",
                  helperText: "Filtrar jogo por data de lançamento",
                  helperStyle: TextStyle(color: Colors.blueAccent),
                  filled: true,
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // TODO: filtrar por data
                },
                child: Text("Buscar"),
              ),
              SizedBox(height: 15),
              TextField(
                controller: scoreController,
                decoration: InputDecoration(
                  labelText: "Nota",
                  helperText: "Filtrar jogo por média da nota",
                  helperStyle: TextStyle(color: Colors.blueAccent),
                  filled: true,
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // TODO: filtrar por nota
                },
                child: Text("Buscar"),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
