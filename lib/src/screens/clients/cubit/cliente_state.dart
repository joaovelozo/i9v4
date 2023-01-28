part of 'cliente_cubit.dart';

@immutable
abstract class ClienteState {}

class ClienteInitial extends ClienteState {}

class ClienteLoading extends ClienteState {}

class ClienteRemotoLoaded extends ClienteState {
  final List<Cliente> clienteList;
  ClienteRemotoLoaded({required this.clienteList});
}

class ClienteLocalLoaded extends ClienteState {
  final List<Cliente> clienteList;
  ClienteLocalLoaded({required this.clienteList});
}

class ClienteLocalSync extends ClienteState {}

class ClienteError extends ClienteState {}
