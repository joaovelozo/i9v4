import 'package:i9/src/helpers/produtoHelper.dart';
import 'package:i9/src/models/produto.dart';
import 'package:sqflite/sqflite.dart';

class ProdutoLocalRepository {
  var produtoFuture = ProdutosHelper.db.database;
  static const PRODUTO_TABLE_NAME = 'produtos';

  Future<List<Produto>> getAllProdutos() async {
    late final List<Produto> produtoList;
    final Database database = await produtoFuture;
    final produtoMap = await database.query(PRODUTO_TABLE_NAME);
    produtoList =
        produtoMap.map((produto) => Produto.fromJson(produto)).toList();
    return produtoList;
  }

  Future<void> updateLocalProdutoDatatable(List<Produto> produtoList) async {
    final Database database = await produtoFuture;
    Batch batch = database.batch();
    produtoList.forEach((produto) async {
      batch.insert(
        PRODUTO_TABLE_NAME,
        produto.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
    batch.commit();
  }
}
