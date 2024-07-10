import 'package:flutter/material.dart';
import 'package:games_tracker/screens/filtered_games_screen.dart';
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
  DateTime? dataLancamento;
  String txtData = "";

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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FilteredGamesScreen(
                            user: widget.user,
                            opcao: "genero",
                            genre: genreController.text,
                            data: "")),
                  );
                },
                child: Text("Buscar"),
              ),
              SizedBox(height: 15),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FilteredGamesScreen(
                            user: widget.user,
                            opcao: "data",
                            genre: "",
                            data: dataLancamento!
                                .toIso8601String()
                                .split('T')[0])),
                  );
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
