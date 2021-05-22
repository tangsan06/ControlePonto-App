import 'dart:async';
import 'dart:convert';

import 'package:controlepontoapp/model/LoginResponse.dart';
import 'package:http/http.dart' as http; // trabalha com o protocolo HTTP

class RestDart {
  // Método para requisição da API
  jsonRestLogin(String username, String password) async {
    Uri url = Uri.parse(
        'https://projetopontoapi.000webhostapp.com/api/v1/user/search/index.php');
    // esse bloco de código envia a requisição ao servidor da API

    http.Response response = await http.post(
      url,
      headers: <String, String>{
        "Content-Type": "Application/json; charset=UTF-8",
      },
      body: jsonEncode(<String, String>{
        "username": username,
        "password": password,
      }),
    );

    // Bloco que recupera a informação do servidor e converte JSON para objeto
    final parsed = json.decode(response.body);
    var res = new LoginResponse.fromJson(parsed);

    // Vamos mostrar os dados na tela do APP, tratando os erros
    try {
      if (int.parse(res.id) > 0) {
        return res;
      } else {
        return null;
      }
    } catch (e) {
      // se não retornou dados (id, nome, email)
      print('Error');
    }
  }
}
