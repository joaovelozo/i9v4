// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:i9/src/screens/checkout/domain/entities/shop_cart_entity.dart';
import 'package:i9/src/screens/checkout/domain/entities/shop_item_entity.dart';

class OrderEntity {
  final ShopCartEntity shopCartEntity;
  final List<ShopItemEntity> shopItemEntity;

  OrderEntity({
    required this.shopCartEntity,
    required this.shopItemEntity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pedido': shopCartEntity.toMap(),
      'produtos': shopItemEntity.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'OrderEntity(shopCartEntity: $shopCartEntity, shopItemEntity: $shopItemEntity)';

  @override
  bool operator ==(covariant OrderEntity other) {
    if (identical(this, other)) return true;

    return other.shopCartEntity == shopCartEntity &&
        listEquals(other.shopItemEntity, shopItemEntity);
  }

  @override
  int get hashCode => shopCartEntity.hashCode ^ shopItemEntity.hashCode;
}
