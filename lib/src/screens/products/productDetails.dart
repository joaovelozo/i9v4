import 'package:flutter/material.dart';
import 'package:i9/src/models/produtos.dart';
import 'package:i9/src/widget/alert.dart';

class ProdutoDetails extends StatelessWidget {
  final Produto produto;
  const ProdutoDetails({
    super.key,
    required this.produto,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Produtos'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                showExitPopup(context);
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16.0,
            ),
            Center(),
            Text(
              produto.descricao_pdv,
              style: const TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 12.0,
            ),
            Text(
              "Preço Padrão",
              style: TextStyle(fontSize: 15, color: Colors.green),
            ),
            Text(
              produto.preco_a_vista,
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
            const Divider(
              thickness: 2.0,
            ),
            Text("Preço Promocional",
                style: TextStyle(fontSize: 15, color: Colors.orange)),
            Text(
              produto.preco_promocional,
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 12.0,
            ),
          ],
        ),
      ),
    ));
  }
}
