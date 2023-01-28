class ProdutosModel {
  String? id_pedido_app_det;
  String? id_pedido_app;
  String? id_produto;
  int? qtde;
  double? preco_unitario;
  int? desconto;
  double? total;
  bool? isPricePromotion;

  ProdutosModel({
    this.id_pedido_app_det,
    this.id_pedido_app,
    this.id_produto,
    this.qtde,
    this.preco_unitario,
    this.desconto,
    this.total,
    this.isPricePromotion,
  });
  ProdutosModel.fromJson(Map<String, dynamic> json) {
    id_pedido_app_det = json['idPedidoAppDet']?.toString();
    id_pedido_app = json['idPedidoApp']?.toString();
    id_produto = json['idProduto']?.toString();
    qtde = json['qtde']?.toInt();
    preco_unitario = json['precoUnitario'];
    desconto = json['desconto']?.toInt();
    total = json['total']?.toDouble();
    isPricePromotion = json['isPricePromotion'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id_pedido_app_det'] = id_pedido_app_det;
    data['id_pedido_app'] = id_pedido_app;
    data['id_produto'] = id_produto;
    data['qtde'] = qtde;
    data['preco_unitario'] = preco_unitario;
    data['desconto'] = desconto;
    data['total'] = total;
    data['is_price_promotion'] = isPricePromotion;
    return data;
  }
}

class pedido_model {
  String? id_pedido_app;
  String? id_cliente;
  String? id_empresa;
  String? token;
  String? nome;
  String? cpf_cnpj;
  String? celular;
  String? email;
  int? total_itens;
  String? status;
  String? desconto;
  double? sub_total;
  double? total;
  String? data_lancamento;
  String? id_forma_pagamento;

  pedido_model({
    this.id_pedido_app,
    this.id_cliente,
    this.id_empresa,
    this.token,
    this.nome,
    this.cpf_cnpj,
    this.celular,
    this.email,
    this.total_itens,
    this.status,
    this.desconto,
    this.sub_total,
    this.total,
    this.data_lancamento,
    this.id_forma_pagamento,
  });
  pedido_model.fromJson(
    Map<String, dynamic> json,
    int totalItens,
    double valorTotal,
  ) {
    id_pedido_app = json['idPedidoApp']?.toString();
    id_cliente = json['idCliente']?.toString();
    id_empresa = json['idEmpresa']?.toString();
    token = json['token']?.toString();
    nome = json['nome']?.toString();
    cpf_cnpj = json['cpfCnpj']?.toString();
    celular = json['celular']?.toString();
    email = json['email']?.toString();
    total_itens = totalItens; //verificar
    status = json['status']?.toString();
    desconto = json['desconto']?.toString();
    sub_total = json['subTotal']?.toDouble();
    total = valorTotal; //verificar
    data_lancamento = json['dataLancamento']?.toString();
    id_forma_pagamento = json['idFormaPagamento']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id_pedido_app'] = id_pedido_app;
    data['id_cliente'] = id_cliente;
    data['id_empresa'] = id_empresa;
    data['token'] = token;
    data['nome'] = nome;
    data['cpf_cnpj'] = cpf_cnpj;
    data['celular'] = celular;
    data['email'] = email;
    data['total_itens'] = total_itens;
    data['status'] = status;
    data['desconto'] = desconto;
    data['sub_total'] = sub_total;
    data['total'] = total;
    data['data_lancamento'] = data_lancamento;
    data['id_forma_pagamento'] = id_forma_pagamento;
    return data;
  }
}

class PedidoProdutoModel {
  pedido_model? pedido;
  List<ProdutosModel?>? produtos;

  PedidoProdutoModel({
    this.pedido,
    this.produtos,
  });
  PedidoProdutoModel.fromJson(Map<String, dynamic> json) {
    int totalItens = 0;
    double total = 0;

    if (json['produtos'] != null) {
      List v = json['produtos'];

      totalItens = v.length;
      for (var item in v) {
        total = total + item['total']?.toDouble();
      }
    }

    pedido = (json['pedido'] != null)
        ? pedido_model.fromJson(
            json['pedido'],
            totalItens,
            total,
          )
        : null;

    if (json['produtos'] != null) {
      final v = json['produtos'];
      final arr0 = <ProdutosModel>[];
      v.forEach((v) {
        arr0.add(ProdutosModel.fromJson(v));
      });
      produtos = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (pedido != null) {
      data['pedido'] = pedido!.toJson();
    }
    if (produtos != null) {
      final v = produtos;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['produtos'] = arr0;
    }
    return data;
  }
}
