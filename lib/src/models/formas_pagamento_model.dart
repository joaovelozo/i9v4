class FormasPagamentoModel {
  String? idFormaPagamento;
  String? idEmpresa;
  String? descricao;
  String? inativo;

  FormasPagamentoModel();
  FormasPagamentoModel.fromJson(Map<String, dynamic> json) {
    idFormaPagamento = json['id_forma_pagamento']?.toString();
    idEmpresa = json['id_empresa']?.toString();
    descricao = json['descricao']?.toString();
    inativo = json['inativo']?.toString() ?? '';
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id_forma_pagamento'] = idFormaPagamento;
    data['id_empresa'] = idEmpresa;
    data['descricao'] = descricao;
    data['inativo'] = inativo;
    return data;
  }
}
