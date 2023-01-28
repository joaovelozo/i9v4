import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:i9/src/components/login_background.dart';
import 'package:i9/src/helpers/banco_controller.dart';
import 'package:i9/src/screens/home/home.dart';
import 'package:i9/src/services/http_api.dart';

import 'package:i9/src/widget/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Databasepadrao db = Databasepadrao.instance;
  bool isChecked = false;

  //FormKEY(Configuração de ações)
  final _formKey = GlobalKey<FormState>();

  // Controllers Login
  final _loginController = TextEditingController();

  final _senhaController = TextEditingController();

  //Validators
  String loginControllerErrorText = "";

  String senhaControllerErrorText = "";

  //Variaveis Username
  String loginHintText = "Nome de Usuário";

  Color loginHintColor = Colors.purple;

  IconData loginTextFieldPrefixIcon = Icons.person;

  Color loginTextFieldPrefixIconColor = Colors.purple;

  //Variaveis Password
  String senhaHintText = "Senha";

  Color senhaHintColor = Colors.purple;

  IconData senhaTextFieldPrefixIcon = Icons.fingerprint;

  Color senhaTextFieldPrefixIconColor = Colors.purple;

  //Var Login
  void signUser() {}

  retonarDados() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _loginController.text = await prefs.getString('usuario') ?? '';
    _senhaController.text = await prefs.getString('senha') ?? '';

    if (_loginController.text != '' && _senhaController.text != '') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    }
  }

  //Função de validação de Login
  logar() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse('${baseHost}LOGIN_WS.rule?sys=ERP');

    var body = jsonEncode({
      'LOGIN': _loginController.text,
      'SENHA': _senhaController.text,
    });

    var response = await http.post(
      url,
      body: body,
    );
    if (response.statusCode == 200) {
      try {
        var value = json.decode(response.body);
        await _sharedPreferences.setString('token', value[0]['token']);
        await _sharedPreferences.setString('usuario', _loginController.text);
        await _sharedPreferences.setString('senha', _senhaController.text);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text('Usuário ou Senha Inváidos, \n contacte o administrador!'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.pop(context);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('Usuário ou Senha Inváidos, \n contacte o administrador!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    retonarDados();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: LoginBackground(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/logo.png", height: 100),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: size.width * 0.8,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      decoration:
                          BoxDecoration(color: MyTheme.loginPageBoxColor, borderRadius: BorderRadius.circular(20)),
                      child: TextFormField(
                        controller: _loginController,
                        decoration: InputDecoration(
                            hintText: loginHintText.trim(),
                            hintStyle: TextStyle(
                              color: loginHintColor,
                            ),
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              loginTextFieldPrefixIcon,
                              color: loginTextFieldPrefixIconColor,
                            )),
                      ),
                    ),
                    Container(
                      width: size.width * 0.8,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      decoration:
                          BoxDecoration(color: MyTheme.loginPageBoxColor, borderRadius: BorderRadius.circular(20)),
                      child: TextFormField(
                        obscureText: true,
                        controller: _senhaController,
                        decoration: InputDecoration(
                          hintText: senhaHintText,
                          hintStyle: TextStyle(
                            color: senhaHintColor,
                          ),
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            senhaTextFieldPrefixIcon,
                            color: senhaTextFieldPrefixIconColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    GestureDetector(
                      onTap: () {
                        logar();
                      },
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.symmetric(horizontal: 35),
                          decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20)),
                          child: const Center(
                              child: Text(
                            "Entrar",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          )),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
