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
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Cadastrar Novo Usuário'), backgroundColor: Colors.blue),
      body: Center(
          child: Container(
              margin: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextField(
                    controller: nameController,
                    maxLength: 10,
                    decoration: InputDecoration(
                      labelText: "Nome",
                      helperText: "Máximo de 10 caracteres",
                      helperStyle: TextStyle(color: Colors.blueAccent),
                      filled: true,
                    ),
                  ),
                  TextField(
                    controller: emailController,
                    maxLength: 40,
                    decoration: InputDecoration(
                      labelText: "Email",
                      helperText: "Máximo de 40 caracteres",
                      helperStyle: TextStyle(color: Colors.blueAccent),
                      border: UnderlineInputBorder(),
                      filled: true,
                    ),
                  ),
                  TextField(
                    obscureText: passwordVisible,
                    controller: passwordController,
                    maxLength: 12,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Senha",
                      helperText: "Máximo de 12 caracteres",
                      helperStyle: TextStyle(color: Colors.blueAccent),
                      suffixIcon: IconButton(
                        icon: Icon(passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(
                            () {
                              passwordVisible = !passwordVisible;
                            },
                          );
                        },
                      ),
                      alignLabelWithHint: false,
                      filled: true,
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
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
                      child: Text("Cadastrar"))
                ],
              ))),
    );
  }
}
