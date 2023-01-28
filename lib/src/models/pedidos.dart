import 'dart:convert';

class Pedido {
  final String id_forma_pagamento;
  final String id_pedido_app_det;
  final String id_produto;
  final String id_pedido_app;
  final String id_cliente;
  final String id_empresa;
  final String nome;
  final String cpf_cnpj;
  final String celular;
  final String email;
  final String total_itens;
  final String status;
  final String desconto;
  final String sub_total;
  final String data_lancamento;
  final String qtde;
  final String preco_unitario;
  final String total;

  Pedido({
    required this.id_forma_pagamento,
    required this.id_pedido_app_det,
    required this.id_produto,
    required this.id_pedido_app,
    required this.id_cliente,
    required this.id_empresa,
    required this.nome,
    required this.cpf_cnpj,
    required this.celular,
    required this.email,
    required this.total_itens,
    required this.status,
    required this.desconto,
    required this.sub_total,
    required this.data_lancamento,
    required this.qtde,
    required this.preco_unitario,
    required this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_forma_pagamento': id_forma_pagamento,
      'id_pedido_apt_det': id_pedido_app_det,
      'id_produto': id_produto,
      'id_pedido_app': id_pedido_app,
      'id_cliente': id_cliente,
      'id_empresa': id_empresa,
      'nome': nome,
      'cpf_cnpj': cpf_cnpj,
      'celular': celular,
      'email': email,
      'total_itens': total_itens,
      'status': status,
      'desconto': desconto,
      'sub_total': sub_total,
      'data_lancamento': data_lancamento,
      'qtde': qtde,
      'preco_unitario': preco_unitario,
      'total': total,
    };
  }

  factory Pedido.fromMap(Map<String, dynamic> map) {
    return Pedido(
      id_pedido_app_det: map['id_pedido_apt_det'] ?? '',
      id_produto: map['id_produto'],
      id_pedido_app: map['id_pedido_app'] ?? '',
      id_cliente: map['id_cliente'] ?? '',
      id_empresa: map['id_empresa'] ?? '',
      cpf_cnpj: map['cpf_cnpj'] ?? '',
      nome: map['nome'] ?? '',
      celular: map['celular'] ?? '',
      email: map['email'] ?? '',
      total_itens: map['total_itens'] ?? '',
      status: map['status'] ?? '',
      desconto: map['desconto'] ?? '',
      sub_total: map['sub_total'] ?? '',
      data_lancamento: map['data_lancamento'] ?? '',
      id_forma_pagamento: map['id_forma_pagamento'] ?? '',
      qtde: map['qtde'] ?? '',
      preco_unitario: map['preco_unitario'] ?? '',
      total: map['total'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Pedido.fromJson(String source) => Pedido.fromMap(json.decode(source));
}
