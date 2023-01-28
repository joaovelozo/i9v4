import 'package:i9/src/helpers/clienteHelper.dart';
import 'package:i9/src/models/clientes.dart';
import 'package:sqflite/sqflite.dart';

class ClienteLocalRepository {
  var clienteFuture = ClienteHelper.db.database;
  static const CLIENTE_TABLE_NAME = 'cliente';

  Future<List<Cliente>> getAllClientes() async {
    late final List<Cliente> clienteList;
    final Database database = await clienteFuture;
    final clienteMap = await database.query(CLIENTE_TABLE_NAME);
    clienteList =
        clienteMap.map((cliente) => Cliente.fromMap(cliente)).toList();
    return clienteList;
  }

  Future<void> updateLocalCLienteDatatable(List<Cliente> clienteList) async {
    final Database database = await clienteFuture;
    Batch batch = database.batch();
    clienteList.forEach((cliente) async {
      batch.insert(
        CLIENTE_TABLE_NAME,
        cliente.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
    batch.commit();
  }
}
