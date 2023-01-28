import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:meta/meta.dart';
import 'package:i9/src/models/produto.dart';
import 'package:i9/src/repositories/produto_local_repository.dart';
import 'package:i9/src/repositories/produto_remoto_repository.dart';

part 'produto_state.dart';

class ProdutoCubit extends Cubit<ProdutoState> {
  final ProdutoLocalRepository produtoLocalRepository;
  final RemotoProdutoRepository remotoProdutoRepository;
  final Connectivity connectivity;
  ProdutoCubit(this.produtoLocalRepository, this.remotoProdutoRepository,
      this.connectivity)
      : super(ProdutoInitial());

  Future<void> getProdutoList() async {
    final connectivityStatus = await connectivity.checkConnectivity();
    if (connectivityStatus == ConnectivityResult.none) {
      getLocalProdutoList();
    } else {
      getRemoteProdutoList();
    }
  }

  Future<void> getRemoteProdutoList() async {
    try {
      emit(ProdutoLoading());
      final result = await remotoProdutoRepository.getAllProdutos();
      emit(ProdutoRemotoLoaded(produtoList: result));
    } catch (error) {
      emit(ProdutoError());
    }
  }

  Future<void> getLocalProdutoList() async {
    try {
      emit(ProdutoLoading());
      //delay to fake http request fetch time
      await Future.delayed(Duration(milliseconds: 500));
      final result = await produtoLocalRepository.getAllProdutos();
      emit(ProdutoLocalLoaded(produtoList: result));
    } catch (error) {
      emit(ProdutoError());
    }
  }

  Future<void> updateLocalProdutoDatabase(List<Produto> produtoList) async {
    try {
      await produtoLocalRepository.updateLocalProdutoDatatable(produtoList);
      emit(ProdutoLocalSync());
    } catch (error) {
      emit(ProdutoError());
    }
  }
}
