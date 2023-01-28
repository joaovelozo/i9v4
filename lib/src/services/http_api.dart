import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:i9/src/helpers/banco_controller.dart';
import 'package:i9/src/models/cliente_model.dart';
import 'package:i9/src/models/formas_pagamento_model.dart';
import 'package:i9/src/models/produto_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String baseHost = 'https://erp.sosistemas.com.br:8443/ERP/';

class HttpApi {
  Databasepadrao db = Databasepadrao.instance;
  Future<http.Response?> post(String endpoint) async {
    var body = jsonEncode({"token": "c8c8cf52-5c11-11ec-bf63-0242ac130002"});
    var url = Uri.parse('$baseHost$endpoint');
    final http.Response response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      return response;
    } else {
      return null;
    }
  }

  formasPagamento() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var body = jsonEncode({"token": prefs.get('token')});
      var url = Uri.parse('${baseHost}FORMAS_PAGAMENTO_WS.rule?sys=ERP');
      final http.Response response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        List lista = jsonDecode(response.body);
        if (lista.isNotEmpty) {
          for (var item in lista) {
            await db.insert(
                'FORMAS_PAGAMENTO', FormasPagamentoModel.fromJson(item));
          }
        }
      }
    } catch (e) {
      throw Exception('formas de pagamento');
    }
  }

  produtos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var body = jsonEncode({"token": prefs.get('token')});
      var url = Uri.parse('${baseHost}PRODUTOS_WS.rule?sys=ERP');
      final http.Response response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        var lista = await jsonDecode(response.body);
        if (lista.isNotEmpty) {
          db.delete('PRODUTO');
          for (var item in lista) {
            await db.insert('PRODUTO', ProdutoModel.fromJson(item));
          }
        }
      }
    } catch (e) {
      throw Exception('produtos');
    }
  }

  clientes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var body = jsonEncode({"token": prefs.get('token')});
      var url = Uri.parse('${baseHost}CLIENTES_WS.rule?sys=ERP');
      final http.Response response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        var lista = await jsonDecode(response.body);
        if (lista.isNotEmpty) {
          db.delete('CLIENTES');
          for (var item in lista) {
            await db.insert('CLIENTES', ClienteModel.fromJson(item));
          }
        }
      }
    } catch (e) {
      throw Exception('clientes');
    }
  }
}
