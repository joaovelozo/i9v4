import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i9/src/models/clientes.dart';
import 'package:i9/src/screens/checkout/cubit/shop_cart_cubit.dart';
import 'package:i9/src/widget/alert.dart';

import '../checkout/shop_cart_screen.dart';

class ClienteDetails extends StatelessWidget {
  final Cliente cliente;
  const ClienteDetails({
    super.key,
    required this.cliente,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Voltar'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  showExitPopup(context);
                },
                icon: Icon(Icons.exit_to_app))
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(19.0),
              child: Center(
                child: Text(
                  cliente.nome!,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text("Nome Fantasia"),
            Text(
              cliente.nome_fantasia!,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Telefone"),
            Text(
              cliente.telefone!,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("WhatsApp"),
            Text(
              cliente.celular!,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Email"),
            Text(
              cliente.email!,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Cidade"),
            Text(
              cliente.cidade!,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Estado"),
            Text(cliente.uf!,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => ShopCartCubit(),
                  child: ShopCartScreen(
                    client: cliente,
                  ),
                ),
              ),
            );
          },
          label: Text('Gerar Pedido'),
          icon: Icon(Icons.add),
        ),
      ),
    );
  }
}
