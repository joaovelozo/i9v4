// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PaymantGatewayEntity {
  String? idFormaPagamento;
  String? idEmpresa;
  String? descricao;
  bool? inativo;

  PaymantGatewayEntity({
    required this.idFormaPagamento,
    required this.idEmpresa,
    required this.descricao,
    required this.inativo,
  });

  PaymantGatewayEntity copyWith({
    String? idFormaPagamento,
    String? idEmpresa,
    String? descricao,
    bool? inativo,
  }) {
    return PaymantGatewayEntity(
      idFormaPagamento: idFormaPagamento ?? this.idFormaPagamento,
      idEmpresa: idEmpresa ?? this.idEmpresa,
      descricao: descricao ?? this.descricao,
      inativo: inativo ?? this.inativo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idFormaPagamento': idFormaPagamento,
      'idEmpresa': idEmpresa,
      'descricao': descricao,
      'inativo': inativo,
    };
  }

  factory PaymantGatewayEntity.fromMap(Map<String, dynamic> map) {
    return PaymantGatewayEntity(
      idFormaPagamento: map['idFormaPagamento'] != null ? map['idFormaPagamento'] as String : null,
      idEmpresa: map['idEmpresa'] != null ? map['idEmpresa'] as String : null,
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
      inativo: map['inativo'] != null ? map['inativo'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymantGatewayEntity.fromJson(String source) =>
      PaymantGatewayEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PaymantGatewayEntity(idFormaPagamento: $idFormaPagamento, idEmpresa: $idEmpresa, descricao: $descricao, inativo: $inativo)';
  }

  @override
  bool operator ==(covariant PaymantGatewayEntity other) {
    if (identical(this, other)) return true;

    return other.idFormaPagamento == idFormaPagamento &&
        other.idEmpresa == idEmpresa &&
        other.descricao == descricao &&
        other.inativo == inativo;
  }

  @override
  int get hashCode {
    return idFormaPagamento.hashCode ^ idEmpresa.hashCode ^ descricao.hashCode ^ inativo.hashCode;
  }
}
