import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:i9/src/models/clientes.dart';
import 'package:i9/src/screens/checkout/domain/entities/paymant_gateway_entity.dart';
import 'package:i9/src/screens/checkout/domain/entities/shop_cart_entity.dart';
import 'package:i9/src/screens/checkout/domain/entities/shop_item_entity.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../../models/formas_pagamento_model.dart';
import '../data/datasources/shop_cart_datasources.dart';

part 'shop_cart_state.dart';

class ShopCartCubit extends Cubit<ShopCartState> {
  ShopCartCubit() : super(ShopCartInitial());
  ShopCartDataSources datasources = ShopCartDataSources();
  List<PaymantGatewayEntity> _paymantList = [];
  List<PaymantGatewayEntity> get paymantList => _paymantList;

  ShopCartEntity? cartEntity;
  void startCart({
    Cliente? cliente,
    ShopCartEntity? order,
  }) async {
    DateTime date = DateTime.now();
    emit(ShopCartLoading());
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? '';
    if (order == null) {
      cartEntity = ShopCartEntity(
        idPedidoApp: Uuid().v1(),
        idCliente: cliente!.id_cliente!,
        idEmpresa: cliente.id_empresa!,
        token: token,
        nome: cliente.nome!,
        cpfCnpj: cliente.cpf_cnpj!,
        celular: cliente.celular!,
        email: cliente.email!,
        status: null,
        desconto: null,
        subTotal: 0.0,
        dataLancamento: '${date.day}/${date.month}/${date.year}',
        idFormaPagamento: '',
      );
    } else {
      cartEntity = order;
    }

    emit(ShopCartLoaded(cartEntity!));
    await paymantGateway();
  }

  Future<List<PaymantGatewayEntity>> paymantGateway() async {
    _paymantList = await datasources.getGatewayPayment();
    return _paymantList;
  }

  void addPaymantGateway(FormasPagamentoModel payment) {
    ShopCartState state = this.state;
    if (state is ShopCartLoaded) {
      emit(
        ShopCartLoaded(
          state.cart.copyWith(
            idFormaPagamento: payment.idFormaPagamento,
          ),
        ),
      );
    }
  }

  Future<void> addItem(ShopItemEntity newItem) async {
    ShopCartState state = this.state;
    if (state is ShopCartLoaded) {
      newItem.idPedidoApp = state.cart.idPedidoApp;
      ShopItemEntity? oldItem;
      state.cart.item?.forEach((element) {
        if (element.idProduto == newItem.idProduto) {
          oldItem = element;
        }
      });

      List<ShopItemEntity>? newUpdateItem = state.cart.item ?? [];
      if (oldItem != null) {
        var updateItem = oldItem!.copyWith(
          desconto: oldItem!.desconto + newItem.desconto,
          qtde: oldItem!.qtde + newItem.qtde,
          total: oldItem!.total + (newItem.precoUnitario * newItem.qtde),
        );
        newUpdateItem = state.cart.item?.map((element) {
          return element.idProduto == updateItem.idProduto
              ? updateItem
              : element;
        }).toList();
      } else {
        newUpdateItem.add(newItem);
      }
      emit(
        ShopCartLoading(),
      );
      emit(
        ShopCartLoaded(state.cart.copyWith(
          item: newUpdateItem,
        )),
      );
    }
  }

  void removeItemQtd(int index) {
    ShopCartState state = this.state;
    ShopItemEntity? newCartUpdate;
    if (state is ShopCartLoaded) {
      var aa = state.cart;
      var newItem = state.cart.item![index];
      var newListItem = state.cart.item;

      var update = newListItem!.map((e) {
        return e.idProduto == newItem.idProduto
            ? newItem.copyWith(
                // desconto: newItem.desconto - newItem.precoUnitario,
                qtde: newItem.qtde - 1,
                total: newItem.total - newItem.precoUnitario,
              )
            : e;
      }).toList();

      update.removeWhere(
        (element) {
          return element.qtde == 0;
        },
      );

      emit(ShopCartLoading());
      emit(ShopCartLoaded(state.cart.copyWith(item: update)));
    }
  }

  void removeItem(ShopItemEntity item, int index) {
    ShopCartState state = this.state;
    if (state is ShopCartLoaded) {
      state.cart.item?.removeAt(index);

      emit(ShopCartLoaded(state.cart));
    }
  }

  Future<bool> saveLocalOrder(
      String observacao, String idFormaPagamento) async {
    var prefs = await SharedPreferences.getInstance();
    var state = this.state;
    if (state is ShopCartLoaded) {
      var orderUpdated = state.cart.copyWith(observacao: observacao);
      if (prefs.containsKey('pedidos')) {
        List<String>? pedidos = prefs.getStringList('pedidos');
        List<ShopCartEntity> listShopCart =
            pedidos!.map((e) => ShopCartEntity.fromJson(e)).toList();

        if (listShopCart.any(
            (element) => element.idPedidoApp == orderUpdated.idPedidoApp)) {
          listShopCart
              .map(
                (e) => e.idPedidoApp == orderUpdated.idPedidoApp
                    ? orderUpdated
                    : e,
              )
              .toList();
        } else {
          listShopCart.add(orderUpdated);
        }

        var newOrderList = listShopCart
            .map(
              (e) => e.idPedidoApp == orderUpdated.idPedidoApp
                  ? orderUpdated.toJson()
                  : e.toJson(),
            )
            .toList();

        await prefs.setStringList('pedidos', newOrderList);
      } else {
        await prefs.setStringList(
          'pedidos',
          [orderUpdated.toJson()],
        );
      }
      return true;
    } else {
      return false;
    }
  }

  Future<List<ShopCartEntity>> getLocarOrder() async {
    var prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('pedidos')) {
      List<String>? a = prefs.getStringList('pedidos');
      List<ShopCartEntity> listShopCart =
          a!.map((e) => ShopCartEntity.fromJson(e)).toList();
      return listShopCart;
    } else {
      return [];
    }
  }
}
