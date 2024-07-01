import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';

class DashboardScreen extends StatefulWidget {
  final User user;

  const DashboardScreen({super.key, required this.user});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String titulo = "";

  void _setTitulo() {
    if (widget.user.id != -1) {
      titulo = "Dashboard de ${widget.user.name}";
    } else {
      titulo = "Dashboard anônimo";
    }
  }

  fuckit() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", 0);
    });
  }

  Widget? _geraCorpo() {
    _setTitulo();
    Widget corpo;
    if (widget.user.id != -1) {
      // dashboard de usuário logado
      // corpo = Text("Usuário ${widget.user.id}");
      corpo = ElevatedButton(onPressed: fuckit, child: Text("Logout"));
    } else {
      // dashboard de usuário não logado
      // corpo = Text("Usuário anônimo");
      corpo = ElevatedButton(onPressed: fuckit, child: Text("Logout"));
    }
    return corpo;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setTitulo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(titulo),
        ),
        body: _geraCorpo());
  }
}
