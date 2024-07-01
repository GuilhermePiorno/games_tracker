import 'package:flutter/material.dart';
import 'package:games_tracker/controller/LoginController.dart';
import 'package:games_tracker/model/user.dart';
import 'package:games_tracker/screens/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginController loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextField(controller: emailController, decoration: InputDecoration(labelText: "email"),),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: "password"),),
            ElevatedButton(
              onPressed: () {

                loginController.getLogin(emailController.text, passwordController.text).then((user){
                  if(user.id != -1) {
                    print("Usuário existe: ${user.id} ${user.name} ${user.email} ${user.password}");
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen(user: user)));
                  } else {
                    print("Usuário não existe");
                  }
                });

              }, 
              child: Text("Login"))
          ]
        ),
      ),
    );
  }
}