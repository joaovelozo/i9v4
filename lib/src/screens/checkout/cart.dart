import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:i9/src/models/produtos.dart';
import 'package:i9/src/screens/checkout/comum_shop.dart';
import 'package:i9/src/screens/checkout/cubit/shop_cart_cubit.dart';
import 'package:i9/src/screens/checkout/domain/entities/shop_item_entity.dart';
import 'package:i9/src/screens/orders/orders.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class CartScreen extends StatefulWidget {
  final Produto produto;
  final String observacao;
  final ComumShop comum;
  const CartScreen({
    Key? key,
    required this.produto,
    required this.observacao,
    required this.comum,
  }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int itemQuantity = 1;
  bool isPromoValue = false;
  NumberFormat formatacao = NumberFormat.simpleCurrency(locale: 'pt-BR');

  void incrementItem() {
    setState(() {
      itemQuantity++;
    });
  }

  void decrementItem() {
    setState(() {
      if (itemQuantity > 0) itemQuantity--;
    });
  }

  double get getUnitPrice {
    return isPromoValue
        ? double.parse(
            widget.produto.preco_promocional,
          )
        : double.parse(
            widget.produto.preco_a_vista,
          );
  }

  double get getDesconto {
    return 0.0;
  }

  double get getProdutoValue {
    return getUnitPrice * itemQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Produtos'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrdersScreen(),
                  ),
                );
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: ListView(children: [
        SizedBox(height: 15.0),
        Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text('${widget.produto.descricao_pdv}',
              style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 42.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF17532),
              )),
        ),
        SizedBox(height: 15.0),
        InkWell(
          onTap: () {
            setState(() {
              isPromoValue = false;
            });
          },
          child: Column(
            children: [
              Center(
                child: Text(
                  "Preço Padrão",
                  style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF17532),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Center(
                child: Text(
                    "${formatacao.format(double.parse(widget.produto.preco_a_vista))}",
                    style: TextStyle(
                      color: Color(0xFF575E67),
                      fontFamily: 'Varela',
                      fontSize: 24.0,
                    )),
              ),
            ],
          ),
        ),
        SizedBox(height: 15.0),
        InkWell(
          onTap: () {
            setState(() {
              isPromoValue = true;
            });
          },
          child: Column(
            children: [
              Center(
                child: Text("Preço Promocional",
                    style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 109, 85))),
              ),
              SizedBox(height: 10.0),
              Center(
                child: Text(
                    "${formatacao.format(double.parse(widget.produto.preco_promocional))}",
                    style: TextStyle(
                      color: Color(0xFF575E67),
                      fontFamily: 'Varela',
                      fontSize: 24.0,
                    )),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.0),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FloatingActionButton(
                heroTag: 1,
                child: Icon(Icons.remove),
                onPressed: () {
                  decrementItem();
                },
              ),
              //Texto Clicavél
              Text(
                '${itemQuantity.toString()}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 30,
                  color: isPromoValue
                      ? Color.fromARGB(255, 0, 109, 85)
                      : Color(0xFFF17532),
                ),
              ),
              FloatingActionButton(
                heroTag: 2,
                child: Icon(Icons.add),
                onPressed: () {
                  incrementItem();
                },
              )
            ],
          ),
        ),
        SizedBox(height: 50.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Builder(builder: (contexts) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF17532),
                ),
                onPressed: () async {
                  await contexts.read<ShopCartCubit>().addItem(
                        ShopItemEntity(
                          nameproduct: widget.produto.descricao_pdv,
                          idPedidoAppDet: Uuid().v1(),
                          idPedidoApp: '',
                          idProduto: widget.produto.id_produto,
                          qtde: itemQuantity,
                          precoUnitario: getUnitPrice,
                          desconto: getDesconto,
                          total: getProdutoValue,
                          isPricePromotion: isPromoValue,
                        ),
                      );
                  await contexts.read<ShopCartCubit>().saveLocalOrder(
                        widget.observacao,
                        widget.comum.paymantGatewayDescription!,
                      );

                  Navigator.pop(contexts);
                },
                child: Center(
                  child: Text(
                    'Adicionar Ao Carrinho',
                    style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Center(
          child: Text(
            "Total: ${formatacao.format(getProdutoValue)}",
            style: TextStyle(
              fontSize: 23,
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ]),
    ));
  }
}
