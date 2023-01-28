import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:i9/src/components/checkoutProducts.dart';
import 'package:i9/src/components/loading.dart';
import 'package:i9/src/components/search.dart';
import 'package:i9/src/models/produtos.dart';
import 'package:i9/src/screens/checkout/comum_shop.dart';
import 'package:i9/src/screens/checkout/cubit/shop_cart_cubit.dart';

class ListaProdutosShop extends StatefulWidget {
  final bool isLoading;
  final String observacao;
  final ComumShop comum;
  List<Produto> produtos = <Produto>[];
  List<Produto> produtosDisplay = <Produto>[];
  ListaProdutosShop({
    Key? key,
    required this.isLoading,
    required this.observacao,
    required this.comum,
    required this.produtos,
    required this.produtosDisplay,
  }) : super(key: key);

  @override
  State<ListaProdutosShop> createState() => _ListaProdutosShopState();
}

class _ListaProdutosShopState extends State<ListaProdutosShop> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 200,
        child: new ListView.builder(
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemBuilder: (context, index) {
            if (!widget.isLoading) {
              return index == 0
                  ? Search(
                      hintText: 'Digite código do produto, ou nome do produto',
                      onChanged: (searchText) {
                        searchText = searchText.toLowerCase();
                        setState(() {
                          widget.produtosDisplay = widget.produtos.where((u) {
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
                  : BlocProvider.value(
                      value: BlocProvider.of<ShopCartCubit>(context),
                      child: CheckoutProducts(
                        comum: widget.comum,
                        observacao: widget.observacao,
                        produto: widget.produtosDisplay[index - 1],
                      ),
                    );
            } else {
              return const MyLoading();
            }
          },
          itemCount: widget.produtosDisplay.length + 1,
        ),
      ),
    );
  }
}
