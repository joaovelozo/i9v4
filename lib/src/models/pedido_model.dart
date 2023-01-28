class PedidoModel {
  String? idPedidoApp;
  String? idCliente;
  String? idEmpresa;
  String? token;
  String? nome;
  String? cpfCnpj;
  String? celular;
  String? email;
  int? totalItens;
  String? status;
  String? desconto;
  double? subTotal;
  double? total;
  String? dataLancamento;
  String? idFormaPagamento;

  PedidoModel({
    this.idPedidoApp,
    this.idCliente,
    this.idEmpresa,
    this.token,
    this.nome,
    this.cpfCnpj,
    this.celular,
    this.email,
    this.totalItens,
    this.status,
    this.desconto,
    this.subTotal,
    this.total,
    this.dataLancamento,
    this.idFormaPagamento,
  });
  PedidoModel.fromJson(Map<String, dynamic> json) {
    idPedidoApp = json['id_pedido_app']?.toString();
    idCliente = json['id_cliente']?.toString();
    idEmpresa = json['id_empresa']?.toString();
    token = json['token']?.toString();
    nome = json['nome']?.toString();
    cpfCnpj = json['cpf_cnpj']?.toString();
    celular = json['celular']?.toString();
    email = json['email']?.toString();
    totalItens = json['total_itens']?.toInt();
    status = json['status']?.toString();
    desconto = json['desconto']?.toString();
    subTotal = json['sub_total']?.toDouble();
    total = json['total']?.toDouble();
    dataLancamento = json['data_lancamento']?.toString();
    idFormaPagamento = json['id_forma_pagamento']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id_pedido_app'] = idPedidoApp;
    data['id_cliente'] = idCliente;
    data['id_empresa'] = idEmpresa;
    data['token'] = token;
    data['nome'] = nome;
    data['cpf_cnpj'] = cpfCnpj;
    data['celular'] = celular;
    data['email'] = email;
    data['total_itens'] = totalItens;
    data['status'] = status;
    data['desconto'] = desconto;
    data['sub_total'] = subTotal;
    data['total'] = total;
    data['data_lancamento'] = dataLancamento;
    data['id_forma_pagamento'] = idFormaPagamento;
    return data;
  }
}
