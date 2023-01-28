import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:i9/src/models/pedidos.dart';
import 'package:i9/src/services/http_api.dart';

import '../services/http_adapter.dart';

Future<List<Pedido>> parsePedido(String responseBody) async {
  var list = json.decode(responseBody) as List<dynamic>;
  var pedidos = list.map((e) => Pedido.fromMap(e)).toList();
  return pedidos;
}

Future<List<Pedido>> fetchPedidos() async {
  const String url = '${baseHost}PEDIDOS_APP_WS.rule?sys=ERP';

  try {
    var response = await HttpAdapter(http.Client()).request(
      url: url,
      method: 'post',
      body: {
        'token': 'c8c8cf52-5c11-11ec-bf63-0242ac130002',
      },
    );

    return compute(parsePedido, response!);
  } catch (e) {
    throw Exception('fetchPedidos');
  }
}
