part of 'list_order_cubit.dart';

abstract class ListOrderState extends Equatable {
  const ListOrderState();

  @override
  List<Object> get props => [];
}

class ListOrderInitial extends ListOrderState {}

class ListOrderLoaded extends ListOrderState {
  final List<ShopCartEntity> listorders;

  ListOrderLoaded(this.listorders);

  @override
  List<Object> get props => [listorders];
}
