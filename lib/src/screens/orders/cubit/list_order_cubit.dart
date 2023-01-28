import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../checkout/data/datasources/shop_cart_datasources.dart';
import '../../checkout/domain/entities/order_entity.dart';
import '../../checkout/domain/entities/shop_cart_entity.dart';

part 'list_order_state.dart';

class ListOrderCubit extends Cubit<ListOrderState> {
  ListOrderCubit() : super(ListOrderInitial());
  ShopCartDataSources datasources = ShopCartDataSources();

  Future<void> getLocarOrder() async {
    var prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('pedidos')) {
      List<String>? a = prefs.getStringList('pedidos');
      List<ShopCartEntity> listShopCart =
          a!.map((e) => ShopCartEntity.fromJson(e)).toList();
      emit(ListOrderLoaded(listShopCart));
    }
  }

  Future<String> postOrder(String cart, ShopCartEntity order) async {
    ListOrderState state = this.state;
    if (state is ListOrderLoaded) {
      // ShopCartEntity? order = state.listorders
      //     .firstWhere((element) => element.idPedidoApp == cart, orElse: null);

      String orderStatus = '';

      OrderEntity orderEntity =
          OrderEntity(shopCartEntity: order, shopItemEntity: order.item!);
      orderStatus = await datasources.postOrder(orderEntity);
      if (orderStatus != '') {
        await saveLocalOrder(orderEntity.shopCartEntity);
      }

      return orderStatus;
    } else {
      return '';
    }
  }

  Future<void> saveLocalOrder(ShopCartEntity order) async {
    var prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('pedidos')) {
      List<String>? a = prefs.getStringList('pedidos');
      List<ShopCartEntity> listShopCart =
          a!.map((e) => ShopCartEntity.fromJson(e)).toList();

      var aa = listShopCart.map((e) {
        if (e.idPedidoApp == order.idPedidoApp) {
          return e.copyWith(status: 'ENVIADO').toJson();
        } else {
          return e.toJson();
        }
      }).toList();

      await prefs.remove('pedidos');
      await prefs.setStringList('pedidos', aa);
      List<String>? as = prefs.getStringList('pedidos');
      List<ShopCartEntity> listShopCarts =
          as!.map((e) => ShopCartEntity.fromJson(e)).toList();

      emit(ListOrderLoaded(listShopCarts));
    } else {
      return;
    }
  }

  void removeItem(String idOrder, String idItem) async {
    var state = this.state;
    var prefs = await SharedPreferences.getInstance();
    if (state is ListOrderLoaded) {
      var orderFilter = state.listorders
          .firstWhere((element) => element.idPedidoApp == idOrder);
      orderFilter.item!.removeWhere((element) => element.idProduto == idItem);

      if (prefs.containsKey('pedidos')) {
        List<String>? a = prefs.getStringList('pedidos');
        List<ShopCartEntity> listShopCart =
            a!.map((e) => ShopCartEntity.fromJson(e)).toList();
        if (orderFilter.totalItens == 0) {
          listShopCart.removeWhere(
            (element) => element.idPedidoApp == orderFilter.idPedidoApp,
          );
        }
        var newList = listShopCart.map((e) {
          if (e.idPedidoApp == orderFilter.idPedidoApp) {
            return e.copyWith(item: orderFilter.item).toJson();
          } else {
            return e.toJson();
          }
        }).toList();

        await prefs.remove('pedidos');
        await prefs.setStringList('pedidos', newList);
        List<String>? as = prefs.getStringList('pedidos');
        List<ShopCartEntity> listShopCarts =
            as!.map((e) => ShopCartEntity.fromJson(e)).toList();

        emit(ListOrderLoaded(listShopCarts));
      }
    }
  }

  Future<void> removeOrder(String idOrder) async {
    var state = this.state;
    var prefs = await SharedPreferences.getInstance();
    if (state is ListOrderLoaded) {
      if (prefs.containsKey('pedidos')) {
        List<String>? a = prefs.getStringList('pedidos');
        List<ShopCartEntity> listShopCart =
            a!.map((e) => ShopCartEntity.fromJson(e)).toList();

        listShopCart.removeWhere((element) => element.idPedidoApp == idOrder);

        var newList = listShopCart.map((e) {
          return e.toJson();
        }).toList();

        await prefs.remove('pedidos');
        await prefs.setStringList('pedidos', newList);
        List<String>? as = prefs.getStringList('pedidos');
        List<ShopCartEntity> listShopCarts =
            as!.map((e) => ShopCartEntity.fromJson(e)).toList();
        emit(ListOrderInitial());
        emit(ListOrderLoaded(listShopCarts));
      }
    }
  }
}
