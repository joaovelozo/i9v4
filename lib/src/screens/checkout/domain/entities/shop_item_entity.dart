import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ShopItemEntity {
  String idPedidoAppDet;
  String idPedidoApp;
  String idProduto;
  int qtde;
  double precoUnitario;
  double desconto;
  double total;
  String nameproduct;
  final bool isPricePromotion;

  ShopItemEntity({
    required this.idPedidoAppDet,
    required this.idPedidoApp,
    required this.idProduto,
    required this.qtde,
    required this.precoUnitario,
    required this.desconto,
    required this.total,
    required this.nameproduct,
    this.isPricePromotion = false,
  });

  ShopItemEntity copyWith({
    String? idPedidoAppDet,
    String? idPedidoApp,
    String? idProduto,
    int? qtde,
    double? precoUnitario,
    double? desconto,
    double? total,
    String? nameproduct,
    bool? isPromotion,
  }) {
    return ShopItemEntity(
      idPedidoAppDet: idPedidoAppDet ?? this.idPedidoAppDet,
      idPedidoApp: idPedidoApp ?? this.idPedidoApp,
      idProduto: idProduto ?? this.idProduto,
      qtde: qtde ?? this.qtde,
      precoUnitario: precoUnitario ?? this.precoUnitario,
      desconto: desconto ?? this.desconto,
      total: total ?? this.total,
      nameproduct: nameproduct ?? this.nameproduct,
      isPricePromotion: isPromotion ?? this.isPricePromotion,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idPedidoAppDet': idPedidoAppDet,
      'idPedidoApp': idPedidoApp,
      'idProduto': idProduto,
      'qtde': qtde,
      'precoUnitario': precoUnitario,
      'desconto': desconto,
      'total': total,
      'nameproduct': nameproduct,
      'isPricePromotion': isPricePromotion
    };
  }

  Map<String, dynamic> toMapPost() {
    return <String, dynamic>{
      'idPedidoAppDet': idPedidoAppDet,
      'idPedidoApp': idPedidoApp,
      'idProduto': idProduto,
      'qtde': qtde,
      'precoUnitario': isPricePromotion,
      'desconto': desconto,
      'total': total,
      'nameproduct': nameproduct,
      'isPricePromotion': isPricePromotion,
    };
  }

  String toJson() => json.encode(toMap());

  factory ShopItemEntity.fromMap(Map<String, dynamic> map) {
    return ShopItemEntity(
      idPedidoAppDet: map['idPedidoAppDet'] as String,
      idPedidoApp: map['idPedidoApp'] as String,
      idProduto: map['idProduto'] as String,
      qtde: map['qtde'] as int,
      precoUnitario: map['precoUnitario'] as double,
      desconto: map['desconto'] as double,
      total: map['total'] as double,
      nameproduct: map['nameproduct'] as String,
      isPricePromotion: map['isPricePromotion'] as bool,
    );
  }

  factory ShopItemEntity.fromJson(String source) => ShopItemEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ShopItemEntity(idPedidoAppDet: $idPedidoAppDet, idPedidoApp: $idPedidoApp, idProduto: $idProduto, qtde: $qtde, precoUnitario: $precoUnitario, desconto: $desconto, total: $total, nameproduct: $nameproduct)';
  }

  @override
  bool operator ==(covariant ShopItemEntity other) {
    if (identical(this, other)) return true;

    return other.idPedidoAppDet == idPedidoAppDet &&
        other.idPedidoApp == idPedidoApp &&
        other.idProduto == idProduto &&
        other.qtde == qtde &&
        other.precoUnitario == precoUnitario &&
        other.desconto == desconto &&
        other.total == total &&
        other.nameproduct == nameproduct;
  }

  @override
  int get hashCode {
    return idPedidoAppDet.hashCode ^
        idPedidoApp.hashCode ^
        idProduto.hashCode ^
        qtde.hashCode ^
        precoUnitario.hashCode ^
        desconto.hashCode ^
        total.hashCode ^
        nameproduct.hashCode;
  }
}
