part of 'shop_cart_cubit.dart';

@immutable
abstract class ShopCartState extends Equatable {}

class ShopCartInitial extends ShopCartState {
  // final ShopCartEntity shopCartEntity;

  // ShopCartInitial(this.shopCartEntity);
  @override
  List<Object> get props => [];
}

class ShopCartLoading extends ShopCartState {
  @override
  List<Object> get props => [];
}

class ShopCartLoaded extends ShopCartState {
  final ShopCartEntity cart;

  ShopCartLoaded(this.cart);
  @override
  List<Object> get props => [cart];
}
