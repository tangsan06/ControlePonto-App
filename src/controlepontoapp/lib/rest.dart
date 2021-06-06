import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'model/LoginResponse.dart'; // trabalha com o protocolo HTTP

class RestDart {
  // Método para requisição da API
  Future<LoginResponse> jsonRestLogin(String username, String password) async {
    var dio = Dio();

    var url2 = Uri.tryParse(
        'https://projetopontoapi.000webhostapp.com/api/v1/user/search/');

    var res1 = await dio
        .get('https://projetopontoapi.000webhostapp.com/api/v1/user/search/');

    var url = Uri.parse(
        'https://projetopontoapi.000webhostapp.com/api/v1/user/search/');
    // esse bloco de código envia a requisição ao servidor da API

    // var url = Uri.parse('http://emsapi.esy.es/rest/api/search/');

    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'Application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }));

    // Bloco que recupera a informação do servidor e converte JSON para objeto
    final parsedList = json.decode(response.body);

    Map<String, dynamic> parsedObject = parsedList[0];

    var res = LoginResponse.fromJson(parsedObject);

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
    return null;
  }
}
