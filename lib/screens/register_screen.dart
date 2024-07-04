import 'package:flutter/material.dart';
import 'package:games_tracker/controller/LoginController.dart';
import 'package:games_tracker/model/user.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginController loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Cadastrar Novo Usuário'), backgroundColor: Colors.blue),
      body: Center(
          child: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: "name"),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: "email"),
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(labelText: "password"),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        loginController
                            .checkRegistration(emailController.text)
                            .then((regStatus) {
                          if (regStatus) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Aviso"),
                                  content: Text("Usuário já cadastrado."),
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
                          } else if (nameController.text.isEmpty ||
                              emailController.text.isEmpty ||
                              passwordController.text.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Aviso"),
                                  content: Text(
                                      "Não foi possível cadastrar o usuário, tente novamente."),
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
                          } else {
                            User novoUsuario = User(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text);
                            loginController.saveUser(novoUsuario);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Aviso"),
                                  content: Text(
                                    "Usuário ${novoUsuario.name} foi cadastrado com sucesso.",
                                  ),
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
                        });
                      },
                      child: Text("cadastrar"))
                ],
              ))),
    );
  }
}
