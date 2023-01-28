import 'dart:convert';

class Produto {
  final String id_produto;
  final String id_empresa;
  final String codigo_interno;
  final String descricao_pdv;
  final String preco_a_vista;
  final String preco_promocional;
  final String foto;
  Produto({
    required this.id_produto,
    required this.id_empresa,
    required this.descricao_pdv,
    required this.preco_a_vista,
    required this.preco_promocional,
    required this.codigo_interno,
    required this.foto,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_produto': id_produto,
      'id_empresa': id_empresa,
      'descricao_pdv': descricao_pdv,
      'preco_a_vista': preco_a_vista,
      'preco_promocional': preco_promocional,
      'codigo_interno': codigo_interno,
      'foto': foto,
    };
  }

  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
      id_produto: map['id_produto'] ?? '',
      id_empresa: map['id_empresa'] ?? '',
      codigo_interno: map['codigo_interno'] ?? '',
      descricao_pdv: map['descricao_pdv'] ?? '',
      preco_a_vista: double.parse(map['preco_a_vista'] ?? '0.0').toStringAsFixed(2),
      preco_promocional: double.parse(map['preco_promocional'] ?? '0.0').toStringAsFixed(2),
      foto: map['foto'] ?? 'Image nao existe',
    );
  }

  String toJson() => json.encode(toMap());

  factory Produto.fromJson(String source) => Produto.fromMap(json.decode(source));
}
