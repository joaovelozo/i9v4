import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:i9/src/models/clientes.dart';
import 'package:i9/src/services/http_adapter.dart';
import 'package:i9/src/services/http_api.dart';

Future<List<Cliente>> parseCliente(String responseBody) async {
  var list = json.decode(responseBody) as List<dynamic>;
  var clientes = list.map((e) => Cliente.fromMap(e)).toList();
  return clientes;
}

Future<List<Cliente>> fetchClientes() async {
  const String url = '${baseHost}CLIENTES_WS.rule?sys=ERP';

  try {
    var response = await HttpAdapter(http.Client()).request(
      url: url,
      method: 'post',
      body: {
        'token': 'c8c8cf52-5c11-11ec-bf63-0242ac130002',
      },
    );

    return compute(parseCliente, response!);
  } catch (e) {
    throw Exception('fetchClientes');
  }
}
