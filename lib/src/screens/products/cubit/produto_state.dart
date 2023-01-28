part of 'produto_cubit.dart';

@immutable
abstract class ProdutoState {}

class ProdutoInitial extends ProdutoState {}

class ProdutoLoading extends ProdutoState {}

class ProdutoRemotoLoaded extends ProdutoState {
  final List<Produto> produtoList;
  ProdutoRemotoLoaded({required this.produtoList});
}

class ProdutoLocalLoaded extends ProdutoState {
  final List<Produto> produtoList;
  ProdutoLocalLoaded({required this.produtoList});
}

class ProdutoLocalSync extends ProdutoState {}

class ProdutoError extends ProdutoState {}
