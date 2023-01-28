class PedidoProdutosModel {
  String? idPedidoAppDet;
  String? idPedidoApp;
  bool? isPricePromotion;
  String? idProduto;
  int? qtde;
  double? precoUnitario;
  int? desconto;
  double? total;

  PedidoProdutosModel({
    this.idPedidoAppDet,
    this.idPedidoApp,
    this.idProduto,
    this.qtde,
    this.precoUnitario,
    this.desconto,
    this.total,
    this.isPricePromotion,
  });
  PedidoProdutosModel.fromJson(Map<String, dynamic> json) {
    idPedidoAppDet = json['id_pedido_app_det']?.toString();
    idPedidoApp = json['id_pedido_app']?.toString();
    idProduto = json['id_produto']?.toString();
    qtde = json['qtde']?.toInt();
    precoUnitario = json['preco_unitario']?.toDouble();
    desconto = json['desconto']?.toInt();
    total = json['total']?.toDouble();
    isPricePromotion = json['is_price_promotion'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id_pedido_app_det'] = idPedidoAppDet;
    data['id_pedido_app'] = idPedidoApp;
    data['id_produto'] = idProduto;
    data['qtde'] = qtde;
    data['preco_unitario'] = precoUnitario;
    data['desconto'] = desconto;
    data['total'] = total;
    data['is_price_promotion'] = isPricePromotion;
    return data;
  }
}
