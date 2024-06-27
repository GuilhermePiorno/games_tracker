import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final bool registered;

  DashboardScreen({required this.registered});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: Text(registered
            ? 'Dashboard Usuário Cadastrado'
            : 'Dashboard Usuário Não Cadastrado'),
      ),
    );
  }
}
