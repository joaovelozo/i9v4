import 'package:flutter/material.dart';
import 'package:i9/src/models/clientes.dart';
import 'package:i9/src/screens/clients/details.dart';

class MyList extends StatelessWidget {
  final Cliente? cliente;
  const MyList({super.key, required this.cliente});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(children: [
        ListTile(
          title: Text(cliente!.nome!),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(cliente!.cpf_cnpj!),
              Text(cliente!.email!),
              Text(cliente!.celular!),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ClienteDetails(
                  cliente: cliente!,
                ),
              ),
            );
          },
        ),
        const Divider(
          thickness: 2.0,
        ),
      ]),
    );
  }
}
