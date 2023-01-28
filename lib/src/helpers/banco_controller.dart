import 'dart:async';
import 'dart:io';
import 'package:i9/src/helpers/tabelas.dart';
import 'package:i9/src/models/clientes.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

const String databaseName = 'bd1';
const int databaseVersion = 1;

class Databasepadrao {
  Databasepadrao._privateConstructor();
  static final Databasepadrao instance = Databasepadrao._privateConstructor();
  static Database? _database;

  Future<Database?> get db async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, databaseName);
    return await openDatabase(
      path,
      version: databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(table().sqlProduto);
    await db.execute(table().sqlCliente);
    await db.execute(table().sqlFormasPagamento);
    await db.execute(table().sqlPedidos);
    await db.execute(table().sqlPedidosProdutos);
  }

  Future<void> insert(String tabela, model) async {
    Database? dbPadrao = await db;
    await dbPadrao!.insert(tabela, model.toJson());
  }

  Future<int> delete(String tabela) async {
    Database? dbPadrao = await db;
    return await dbPadrao!.delete(tabela);
  }

  Future<List<Map<String, Object?>>> select(String tabela, {String? id}) async {
    Database? dbPadrao = await db;
    if (id == null) {
      return await dbPadrao!.query(tabela);
    } else {
      return await dbPadrao!.query(
        tabela,
        where: ' id_forma_pagamento = ? ',
        whereArgs: [id],
      );
    }
  }

  Future<Cliente?> retornarCliente(String codigo) async {
    Database? dbPadrao = await db;
    var value = await dbPadrao!.query(
      'CLIENTES',
      where: 'id_cliente = ?',
      whereArgs: ["$codigo"],
    );
    if (value.isNotEmpty) {
      var cliente = Cliente(
        id_cliente: value[0]['id_cliente'].toString(),
        id_empresa: value[0]['id_empresa'].toString(),
        cpf_cnpj: value[0]['cpf_cnpj'].toString(),
        nome: value[0]['nome'].toString(),
        nome_fantasia: value[0]['nome_fantasia'].toString(),
        telefone: value[0]['telefone'].toString(),
        celular: value[0]['celular'].toString(),
        email: value[0]['email'].toString(),
        cidade: value[0]['cidade'].toString(),
        uf: value[0]['uf'].toString(),
      );
      return cliente;
    } else {
      return null;
    }
  }

  Future close() async {
    Database? dbPadrao = await db;
    dbPadrao!.close();
  }
}
