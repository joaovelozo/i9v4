import 'package:flutter/material.dart';
import 'package:i9/src/components/listProducts.dart';
import 'package:i9/src/components/loading.dart';
import 'package:i9/src/helpers/banco_controller.dart';
import 'package:i9/src/models/produtos.dart';
import 'package:i9/src/widget/alert.dart';

import '../../components/search.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Produto> _produtos = <Produto>[];
  List<Produto> _produtosDisplay = <Produto>[];
  bool _isLoading = true;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Databasepadrao db = Databasepadrao.instance;
  retornarProdutos() async {
    _produtosDisplay = [];
    _produtos = [];
    setState(() {});
    var listaDB = await db.select('PRODUTO');
    if (listaDB.isNotEmpty) {
      for (var item in listaDB) {
        _produtos.add(Produto.fromMap(item));
      }
      _produtosDisplay = _produtos;
    }
    _isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    retornarProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Produtos'),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  showExitPopup(context);
                },
                icon: Icon(Icons.exit_to_app))
          ],
        ),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () async {
            await retornarProdutos();
            setState(() {});
          },
          child: ListView.builder(
            physics: BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            itemBuilder: (context, index) {
              if (!_isLoading) {
                return index == 0
                    ? Search(
                        hintText:
                            'Digite código do produto, ou nome do produto',
                        onChanged: (searchText) {
                          searchText = searchText.toLowerCase();
                          setState(() {
                            _produtosDisplay = _produtos.where((u) {
                              var codigo_internoLowerCase =
                                  u.codigo_interno.toLowerCase();
                              var descricao_pdvLowerCase =
                                  u.descricao_pdv.toLowerCase();

                              return codigo_internoLowerCase
                                      .contains(searchText) ||
                                  descricao_pdvLowerCase.contains(searchText);
                            }).toList();
                          });
                        },
                      )
                    : ListProducts(produto: _produtosDisplay[index - 1]);
              } else {
                return const MyLoading();
              }
            },
            itemCount: _produtosDisplay.length + 1,
          ),
        ),
      ),
    );
  }
}
