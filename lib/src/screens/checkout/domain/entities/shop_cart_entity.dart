// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'shop_item_entity.dart';

class ShopCartEntity {
  final String idPedidoApp;
  final String idCliente;
  final String idEmpresa;
  final String token;
  final String nome;
  final String cpfCnpj;
  final String? celular;
  final String email;
  final String? status;
  final String? desconto;
  final double subTotal;
  final String dataLancamento;
  final String idFormaPagamento;
  final List<ShopItemEntity>? item;
  final String? observacao;

  ShopCartEntity({
    required this.idPedidoApp,
    required this.idCliente,
    required this.idEmpresa,
    required this.token,
    required this.nome,
    required this.cpfCnpj,
    this.celular,
    required this.email,
    this.status,
    this.desconto,
    required this.subTotal,
    required this.dataLancamento,
    required this.idFormaPagamento,
    this.item,
    this.observacao,
  });

  int get totalItens {
    return item?.length ?? 0;
  }

  double get total {
    return (item?.fold(0.0, (previousValue, element) => previousValue! + element.total) ?? 0.0);
  }

  ShopCartEntity copyWith({
    String? idPedidoApp,
    String? idCliente,
    String? idEmpresa,
    String? token,
    String? nome,
    String? cpfCnpj,
    String? celular,
    String? email,
    String? status,
    String? desconto,
    double? subTotal,
    String? dataLancamento,
    String? idFormaPagamento,
    bool hasSent = false,
    String? observacao,
    List<ShopItemEntity>? item,
  }) {
    return ShopCartEntity(
      idPedidoApp: idPedidoApp ?? this.idPedidoApp,
      idCliente: idCliente ?? this.idCliente,
      idEmpresa: idEmpresa ?? this.idEmpresa,
      token: token ?? this.token,
      nome: nome ?? this.nome,
      cpfCnpj: cpfCnpj ?? this.cpfCnpj,
      celular: celular ?? this.celular,
      email: email ?? this.email,
      status: status ?? this.status,
      desconto: desconto ?? this.desconto,
      subTotal: subTotal ?? this.subTotal,
      dataLancamento: dataLancamento ?? this.dataLancamento,
      idFormaPagamento: idFormaPagamento ?? this.idFormaPagamento,
      observacao: observacao??this.observacao,
      item: item ?? this.item,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idPedidoApp': idPedidoApp,
      'idCliente': idCliente,
      'idEmpresa': idEmpresa,
      'token': token,
      'nome': nome,
      'cpfCnpj': cpfCnpj,
      'celular': celular,
      'email': email,
      'status': status,
      'desconto': desconto,
      'subTotal': subTotal,
      'dataLancamento': dataLancamento,
      'idFormaPagamento': idFormaPagamento,
      'observacao':observacao,
      'item': item!.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  factory ShopCartEntity.fromMap(Map<String, dynamic> map) {
    return ShopCartEntity(
      idPedidoApp: map['idPedidoApp'] as String,
      idCliente: map['idCliente'] as String,
      idEmpresa: map['idEmpresa'] as String,
      token: map['token'] as String,
      nome: map['nome'] as String,
      cpfCnpj: map['cpfCnpj'] as String,
      celular: map['celular'] != null ? map['celular'] as String : null,
      email: map['email'] as String,
      status: map['status'] != null ? map['status'] as String : null,
      desconto: map['desconto'] != null ? map['desconto'] as String : null,
      subTotal: map['subTotal'] as double,
      dataLancamento: map['dataLancamento'] as String,
      idFormaPagamento: map['idFormaPagamento'] as String,
      observacao: map['observacao']!= null ? map['observacao'] as String:null,
      item: map['item'] != null
          ? List<ShopItemEntity>.from(
              (map['item'] as List<dynamic>).map<ShopItemEntity?>(
                (x) => ShopItemEntity.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  factory ShopCartEntity.fromJson(String source) => ShopCartEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ShopCartEntity(idPedidoApp: $idPedidoApp, idCliente: $idCliente, idEmpresa: $idEmpresa, token: $token, nome: $nome, cpfCnpj: $cpfCnpj, celular: $celular, email: $email, status: $status, desconto: $desconto, subTotal: $subTotal, dataLancamento: $dataLancamento, idFormaPagamento: $idFormaPagamento, item: $item)';
  }

  @override
  bool operator ==(covariant ShopCartEntity other) {
    if (identical(this, other)) return true;

    return other.idPedidoApp == idPedidoApp &&
        other.idCliente == idCliente &&
        other.idEmpresa == idEmpresa &&
        other.token == token &&
        other.nome == nome &&
        other.cpfCnpj == cpfCnpj &&
        other.celular == celular &&
        other.email == email &&
        other.status == status &&
        other.desconto == desconto &&
        other.subTotal == subTotal &&
        other.dataLancamento == dataLancamento &&
        other.idFormaPagamento == idFormaPagamento &&
        listEquals(other.item, item);
  }

  @override
  int get hashCode {
    return idPedidoApp.hashCode ^
        idCliente.hashCode ^
        idEmpresa.hashCode ^
        token.hashCode ^
        nome.hashCode ^
        cpfCnpj.hashCode ^
        celular.hashCode ^
        email.hashCode ^
        status.hashCode ^
        desconto.hashCode ^
        subTotal.hashCode ^
        dataLancamento.hashCode ^
        idFormaPagamento.hashCode ^
        item.hashCode;
  }
}
