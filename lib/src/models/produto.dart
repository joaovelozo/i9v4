class Produto {
  int id_produto = 0;
  int id_empresa = 0;
  String descricao_pdv = "";
  String codigo_interno = "";
  String preco_a_vista = "";

  Produto(
    this.id_produto,
    this.id_empresa,
    this.descricao_pdv,
    this.codigo_interno,
    this.preco_a_vista,
  );
  Produto.fromJson(Map<String, dynamic> json) {
    id_produto = json['id_produto'];
    id_empresa = json['id_empresa'];
    descricao_pdv = json['descricao_pdv'];
    codigo_interno = json['codigo_interno'];
    preco_a_vista = json['preco_a_vista'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_produto'];
    data['id_empresa'];
    data['descricao_pdv'];
    data['codigo_interno'];
    data['preco_a_vista'];

    return data;
  }
}
