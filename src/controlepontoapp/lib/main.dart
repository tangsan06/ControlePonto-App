import 'dart:convert';

import 'package:controlepontoapp/model/LoginResponse.dart';
import 'package:controlepontoapp/rest.dart';
import 'package:flutter/material.dart';

import 'cadastro.dart';
import 'package:http/http.dart' as http; // trabalha com o protocolo HTTP

// Main de inicialização do app
void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

// Inicialização da tela de login
class LoginScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

// Tela de login
class _State extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String message = '';
  RestDart restDart = new RestDart();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Controle de Ponto',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w300,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nome do usuário',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Senha',
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    height: 40,
                    padding: EdgeInsets.fromLTRB(10, 5, 5, 10),
                    child: Row(
                      children: <Widget>[
                        TextButton(
                          child: Text(
                            "Esqueceu sua senha?",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {},
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: Text('Login'),
                      onPressed: () {
                        jsonRestApiHttp();
                      },
                    )),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text('Não tem conta? ', style: TextStyle(fontSize: 18)),
                    TextButton(
                      child: Text(
                        'Cadastre-se!',
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () {
                        _redirecionaTelaCadastro(context);
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                )),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Row(children: [
                    Text(this.message,
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 210, 20, 20)))
                  ], mainAxisAlignment: MainAxisAlignment.center),
                )
              ],
            )));
  }

  void _redirecionaTelaCadastro(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Cadastro()));
  }

  Uri url =
      Uri.parse('http://projetopontoapi.000webhostapp.com/api/v1/user/search/');
  // Uri url = Uri.parse('http://emsapi.esy.es/rest/api/search/');
  // Método para requisição da API
  jsonRestApiHttp() async {
    // esse bloco de código envia a requisição ao servidor da API

    try {
      http.Response response = await http.post(
        'http://projetopontoapi.000webhostapp.com/api/v1/user/search/',
        headers: <String, String>{
          "Content-Type": "Application/json; charset=UTF-8"
        },
        body: jsonEncode(<String, String>{
          "username": nameController.text,
          "password": passwordController.text,
        }),
      );

      // Bloco que recupera a informação do servidor e converte JSON para objeto
      final parsed = json.decode(response.body);
      var res = new LoginResponse.fromJson(parsed);

      // Vamos mostrar os dados na tela do APP, tratando os erros
      try {
        if (res == null) {
          setState(() {
            this.message = "Login ou senha incorretos";
          });
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => DrawerScreen()));
        }
      } catch (e) {
        // se não retornou dados (id, nome, email)
        print('Error');
      }
    } catch (e) {
      print(e);
    }
  }
}

//Tela após efetuação de login
class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Controle de Ponto'),
        ),
        // Menu com opções
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Usuário'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.insert_chart_outlined_sharp),
                title: Text('Controle de ponto'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Sair'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        // Tela principal do apontamento
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Apontamento',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w300,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '',
                      style: TextStyle(fontSize: 20),
                    )),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.blue,
                    padding: EdgeInsets.only(
                        top: 0, bottom: 50, right: 5, left: 5), // foreground
                  ),
                  onPressed: () {},
                  child: Text(''),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: Text('Lançar'),
                      onPressed: () {},
                    ))
              ],
            )));
  }
}
