import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:meta/meta.dart';
import 'package:i9/src/models/clientes.dart';
import 'package:i9/src/repositories/cliente_local_repository.dart';
import 'package:i9/src/repositories/cliente_remoto_repository.dart';
part 'cliente_state.dart';

class ClienteCubit extends Cubit<ClienteState> {
  final ClienteRemotoRepository clienteRemotoRepository;
  final ClienteLocalRepository clienteLocalRepository;
  final Connectivity connectivity;
  ClienteCubit(this.clienteRemotoRepository, this.clienteLocalRepository,
      this.connectivity)
      : super(ClienteInitial());

  Future<void> getClienteList() async {
    final connectivityStatus = await connectivity.checkConnectivity();
    if (connectivityStatus == ConnectivityResult.none) {
      getClienteLocalList();
    } else {
      getClienteRemotoList();
    }
  }

  Future<void> getClienteRemotoList() async {
    try {
      emit(ClienteLoading());
      final result = await clienteRemotoRepository.getAllClientes();
      emit(ClienteLocalLoaded(clienteList: result));
    } catch (error) {
      emit(ClienteError());
    }
  }

  Future<void> getClienteLocalList() async {
    try {
      emit(ClienteLoading());
      //delay to fake http request fetch time
      await Future.delayed(Duration(milliseconds: 500));
      final result = await clienteLocalRepository.getAllClientes();
      emit(ClienteLocalLoaded(clienteList: result));
    } catch (error) {
      emit(ClienteError());
    }
  }

  Future<void> updateClienteLocalDatabase(List<Cliente> clienteList) async {
    try {
      await clienteLocalRepository.updateLocalCLienteDatatable(clienteList);
      emit(ClienteLocalSync());
    } catch (error) {
      emit(ClienteError());
    }
  }
}
