import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:i9/src/models/produtos.dart';
import 'package:i9/src/services/http_api.dart';

import '../services/http_adapter.dart';

Future<List<Produto>> parseProduto(String responseBody) async {
  var list = json.decode(responseBody) as List<dynamic>;
  var produtos = list.map((e) => Produto.fromMap(e)).toList();
  return produtos;
}

Future<List<Produto>> fetchProdutos() async {
  const String url = '${baseHost}PRODUTOS_WS.rule?sys=ERP';

  try {
    var response = await HttpAdapter(http.Client()).request(
      url: url,
      method: 'post',
      body: {
        'token': 'c8c8cf52-5c11-11ec-bf63-0242ac130002',
      },
    );

    return compute(parseProduto, response!);
  } catch (e) {
    throw Exception('fetchProdutos');
  }
}
