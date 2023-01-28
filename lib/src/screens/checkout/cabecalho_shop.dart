import 'package:flutter/material.dart';

import 'package:i9/src/models/clientes.dart';

class CabecalhoShop extends StatefulWidget {
  final dynamic state;
  final Cliente ClienteAtual;
  CabecalhoShop({
    Key? key,
    required this.state,
    required this.ClienteAtual,
  }) : super(key: key);

  @override
  State<CabecalhoShop> createState() => _CabecalhoShopState();
}

class _CabecalhoShopState extends State<CabecalhoShop> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            widget.state.cart.nome,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ),
        SizedBox(height: 15),
        Text(
          "CNPJ: ${widget.state.cart.cpfCnpj}",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        SizedBox(height: 15),
        Text(
          "Cidade: ${widget.ClienteAtual.cidade}",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const Divider(thickness: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.shopping_cart_checkout,
                color: Colors.blue,
              ),
            ),
            Text(
              '${widget.state.cart.totalItens.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.monetization_on),
              color: Colors.green,
            ),
            Text(
              'Total R\$ ${widget.state.cart.total.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
