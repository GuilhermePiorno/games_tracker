import 'package:flutter/material.dart';
import 'package:games_tracker/controller/LoginController.dart';
import 'package:games_tracker/model/user.dart';
import 'package:games_tracker/screens/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LoginStatus { notSignedin, signedIn }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginStatus _loginStatus = LoginStatus.notSignedin;
  final _formKey = GlobalKey<FormState>();
  String _email = "", _password = "";
  late LoginController controller;
  var value; // 0 ou 1, não logado ou logado
  late User _current_user;

  _LoginScreenState() {
    this.controller = LoginController();
  }

  savePref(int value, String name, String email, String pass) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      preferences.setInt("value", value);
      preferences.setString("name", email);
      preferences.setString("email", email);
      preferences.setString("pass", pass);
    });
  }

  void _submit() async {
    final form = _formKey.currentState;

    if (form!.validate()) {
      form.save();

      try {
        User user = await controller.getLogin(_email!, _password!);
        if (user.id != -1) {
          savePref(1, user.name, user.email, user.password);
          _current_user = user;
          _loginStatus = LoginStatus.signedIn;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User not registered!')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      preferences.setInt("value", 0);
      _loginStatus = LoginStatus.notSignedin;
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _email = preferences.getString("email")!;
    _password = preferences.getString("pass")!;
    value = preferences.getInt("value");
    if (value == 1) {
      _current_user = await controller.getLogin(_email!, _password!);
    }
    setState(() {
      _loginStatus =
          value == 1 ? LoginStatus.signedIn : LoginStatus.notSignedin;
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentWidget;

    switch (_loginStatus) {
      case LoginStatus.notSignedin:
        currentWidget = Scaffold(
            appBar: AppBar(
              title: Text("Login"),
              backgroundColor: Colors.blue,
            ),
            body: Center(
                child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                    onSaved: (newVal) => _email = newVal!,
                                    decoration: InputDecoration(
                                        labelText: "email",
                                        border: OutlineInputBorder())),
                                Padding(
                                    padding:
                                        EdgeInsets.only(top: 20, bottom: 20),
                                    child: TextFormField(
                                        onSaved: (newVal) =>
                                            _password = newVal!,
                                        decoration: InputDecoration(
                                            labelText: "Password",
                                            border: OutlineInputBorder())))
                              ],
                            )),
                        ElevatedButton(onPressed: _submit, child: Text("Login"))
                      ],
                    ))));
        break;

      case LoginStatus.signedIn:
        currentWidget = DashboardScreen(user: _current_user);
        break;
    }

    return currentWidget;
  }
}
