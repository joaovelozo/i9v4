import 'package:dio/dio.dart';
import 'package:i9/src/helpers/clienteHelper.dart';
import 'package:i9/src/models/clientes.dart';
import 'package:i9/src/services/http_api.dart';
import 'package:sqflite/sqflite.dart';

class ClienteRemotoRepository {
  final dio = Dio();
  var clienteFuture = ClienteHelper.db.database;
  static const CLIENTE_TABLE_NAME = 'cliente';
  static const CLIENTE_API_URL = '${baseHost}CLIENTES_WS.rule?sys=ERP';
  Future<List<Cliente>> getAllClientes() async {
    late final List<Cliente> clienteList;
    final Database database = await clienteFuture;
    try {
      Response response = await dio.get(CLIENTE_API_URL);
      if (response.statusCode == 200) {
        final clientes = (response.data['results'] as List);
        clienteList =
            clientes.map((cliente) => Cliente.fromJson(cliente)).toList();
      }
    } on DioError catch (_) {
      // return data from local DB in case of DioError
      final clienteMap = await database.query(CLIENTE_TABLE_NAME);
      clienteList =
          clienteMap.map((cliente) => Cliente.fromMap(cliente)).toList();
    }
    return clienteList;
  }
}
