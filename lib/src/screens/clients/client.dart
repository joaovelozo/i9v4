import 'package:flutter/material.dart';
import 'package:i9/src/helpers/banco_controller.dart';
import 'package:i9/src/models/clientes.dart';
import 'package:i9/src/components/list.dart';
import 'package:i9/src/components/loading.dart';
import 'package:i9/src/components/search.dart';
import 'package:i9/src/widget/alert.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({super.key});

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  final List<Cliente> _clientes = <Cliente>[];
  List<Cliente> _clientesDisplay = <Cliente>[];
  bool _isLoading = true;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Databasepadrao db = Databasepadrao.instance;
  retornarLista() async {
    var listaDB = await db.select('CLIENTES');
    if (listaDB.isNotEmpty) {
      for (var item in listaDB) {
        _clientes.add(Cliente.fromMap(item));
      }
      _clientesDisplay = _clientes;
    }
    _isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    retornarLista();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Clientes'),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  showExitPopup(context);
                },
                icon: Icon(Icons.exit_to_app))
          ],
        ),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () async {
            await retornarLista();
            setState(() {});
          },
          child: ListView.builder(
            physics: BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            itemBuilder: (context, index) {
              if (!_isLoading) {
                return index == 0
                    ? Search(
                        hintText:
                            'Digite nome, nome fantasia, email ou telefone',
                        onChanged: (searchText) {
                          searchText = searchText.toLowerCase();
                          setState(() {
                            _clientesDisplay = _clientes.where((u) {
                              var nomeLowerCase = u.nome!.toLowerCase();
                              var nome_fantasiaLowerCase =
                                  u.nome_fantasia!.toLowerCase();
                              var emailLowerCase = u.telefone!.toLowerCase();
                              var telefoneLowerCase = u.telefone!.toLowerCase();
                              return nomeLowerCase.contains(searchText) ||
                                  nome_fantasiaLowerCase.contains(searchText) ||
                                  telefoneLowerCase.contains(searchText) ||
                                  emailLowerCase.contains(searchText);
                            }).toList();
                          });
                        },
                      )
                    : MyList(cliente: _clientesDisplay[index - 1]);
              } else {
                return const MyLoading();
              }
            },
            itemCount: _clientesDisplay.length + 1,
          ),
        ),
      ),
    );
  }
}
