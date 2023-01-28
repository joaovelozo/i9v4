import 'package:flutter/material.dart';
import 'package:i9/src/models/produto.dart';
import 'package:i9/src/screens/auth/loginScreen.dart';

class ProdutoDetails extends StatefulWidget {
  final Produto produto;
  const ProdutoDetails({super.key, required this.produto});

  @override
  State<ProdutoDetails> createState() => _ProdutoDetailsState();
}

class _ProdutoDetailsState extends State<ProdutoDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Produtos'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
    ));
  }
}
