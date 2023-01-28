import 'package:dio/dio.dart';
import 'package:i9/src/helpers/produtoHelper.dart';
import 'package:i9/src/models/produto.dart';
import 'package:i9/src/services/http_api.dart';
import 'package:sqflite/sqflite.dart';

class RemotoProdutoRepository {
  final dio = Dio();
  var produtoFuture = ProdutosHelper.db.database;
  static const PRODUTO_TABLE_NAME = 'produtos';
  static const PRODUTO_API_URL = '${baseHost}PRODUTOS_WS.rule?sys=ERP';

  Future<List<Produto>> getAllProdutos() async {
    late final List<Produto> produtoList;
    final Database database = await produtoFuture;
    try {
      //Try to fetch data from API
      Response response = await dio.get(PRODUTO_API_URL);

      if (response.statusCode == 200) {
        final produtos = (response.data['results'] as List);
        produtoList =
            produtos.map((produto) => Produto.fromJson(produto)).toList();
      }
    } on DioError catch (_) {
      // return data from local DB in case of DioError
      final produtoMap = await database.query(PRODUTO_TABLE_NAME);
      produtoList =
          produtoMap.map((produto) => Produto.fromJson(produto)).toList();
    }
    return produtoList;
  }
}
