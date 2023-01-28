import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:i9/src/models/produtos.dart';
import 'package:i9/src/screens/checkout/cart.dart';
import 'package:i9/src/screens/checkout/comum_shop.dart';
import 'package:i9/src/screens/checkout/cubit/shop_cart_cubit.dart';

class CheckoutProducts extends StatelessWidget {
  final Produto produto;
  final String observacao;
  final ComumShop comum;
  const CheckoutProducts({
    Key? key,
    required this.produto,
    required this.observacao,
    required this.comum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Builder(builder: (contexts) {
            return ListTile(
              title: Text(
                produto.descricao_pdv,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Preço Padrão",
                    style: TextStyle(fontSize: 10, color: Colors.green),
                  ),
                  Text(produto.preco_a_vista, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text("|"),
                  Text("Preço Promocional", style: TextStyle(fontSize: 10, color: Colors.orange)),
                  Text(produto.preco_promocional, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              onTap: () {
                if (comum.paymantGatewayDescription!.isNotEmpty) {
                  Navigator.push(
                    contexts,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: BlocProvider.of<ShopCartCubit>(contexts),
                        child: CartScreen(
                          produto: produto,
                          observacao: observacao,
                          comum: comum,
                        ),
                      ),
                    ),
                  );
                } else {
                  ComumShop().showMessage(
                      context, 'Defina primeiro a forma de pagamento.');
                }
              },
            );
          }),
          const Divider(
            thickness: 2.0,
          ),
        ],
      ),
    );
  }
}
