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
        title: Text('Cadastrar Novo Usuário'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: "name"),),
            TextField(controller: emailController, decoration: InputDecoration(labelText: "email"),),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: "password"),),
            ElevatedButton(onPressed: (){
              loginController.getLogin(emailController.text, passwordController.text).then((user){
                if(user.id != -1) {
                  print("Usuário já existe");
                } else {
                  User novoUsuario = User(null, nameController.text, emailController.text, passwordController.text);
                  loginController.saveUser(novoUsuario);
                  print("Usuário ${novoUsuario.name} ${novoUsuario.email} ${novoUsuario.password} cadastrado");
                }
              });
            }, child: Text("cadastrar"))
          ],
        )
      ),
    );
  }
}