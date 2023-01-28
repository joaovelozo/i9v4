import 'package:flutter/material.dart';
import 'package:i9/src/models/pedidos.dart';

class ListPedidos extends StatelessWidget {
  final Pedido pedido;
  const ListPedidos({super.key, required this.pedido});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          ListTile(
            title: Text(
              pedido.nome,
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
                Text(pedido.cpf_cnpj,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text("|"),
                Text("Preço Promocional",
                    style: TextStyle(fontSize: 10, color: Colors.orange)),
                Text(pedido.status,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const Divider(
            thickness: 2.0,
          ),
        ],
      ),
    );
  }
}
