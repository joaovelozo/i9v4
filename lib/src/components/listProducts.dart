import 'package:flutter/material.dart';
import 'package:i9/src/models/produtos.dart';
import 'package:i9/src/screens/products/productDetails.dart';

class ListProducts extends StatelessWidget {
  final Produto produto;
  const ListProducts({super.key, required this.produto});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          ListTile(
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
                Text(produto.preco_a_vista,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text("|"),
                Text("Preço Promocional",
                    style: TextStyle(fontSize: 10, color: Colors.orange)),
                Text(produto.preco_promocional,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProdutoDetails(produto: produto)));
            },
          ),
          const Divider(
            thickness: 2.0,
          ),
        ],
      ),
    );
  }
}
