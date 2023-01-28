import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i9/src/screens/checkout/comum_shop.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:i9/src/screens/checkout/domain/entities/shop_cart_entity.dart';
import 'package:i9/src/screens/checkout/shop_cart_screen.dart';
import 'package:i9/src/screens/clients/client.dart';
import 'package:i9/src/screens/orders/cubit/list_order_cubit.dart';

import '../checkout/cubit/shop_cart_cubit.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool isLoading = true;
  List<ShopCartEntity> listShopCart = [];
  List<ShopCartEntity> listShopCartOld = [];

  retornarDados() async {
    listShopCart = [];
    listShopCartOld = [];
    var prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('pedidos')) {
      List<String>? a = prefs.getStringList('pedidos');

      listShopCartOld =
          await a!.map((e) => ShopCartEntity.fromJson(e)).toList();
      // emit(ListOrderLoaded(listShopCart));
      listShopCart = listShopCartOld;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    retornarDados();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                color: Theme.of(context).primaryColor,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.search),
                      title: TextField(
                        onChanged: (searchText) {
                          searchText = searchText.toLowerCase();
                          setState(() {
                            listShopCart = listShopCartOld.where((u) {
                              var idPedido = u.idPedidoApp.toLowerCase();
                              var nomeCliente = u.nome.toLowerCase();

                              return idPedido.contains(searchText) ||
                                  nomeCliente.contains(searchText);
                            }).toList();
                          });
                        },
                        decoration: InputDecoration(
                            hintText:
                                'Informe nome do cliente ou número do pedido para pesquisar',
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                ),
              ),
              DefaultTabController(
                length: 3,
                initialIndex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      child: TabBar(
                        labelColor: Colors.green,
                        unselectedLabelColor: Colors.black,
                        tabs: [
                          Tab(text: 'Todos '),
                          Tab(text: 'Enviados'),
                          Tab(text: 'Pendentes'),
                        ],
                      ),
                    ),
                    Container(
                      height: 550,
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.grey, width: 0.5)),
                      ),
                      child: TabBarView(
                        children: <Widget>[
                          BlocBuilder<ListOrderCubit, ListOrderState>(
                            builder: (contexts, state) {
                              if (state is ListOrderLoaded) {
                                return TabBarItems(
                                  contexts: contexts,
                                  orders: listShopCart,
                                  funcao: retornarDados,
                                );
                              }
                              return Container();
                            },
                          ),
                          BlocBuilder<ListOrderCubit, ListOrderState>(
                            builder: (contexts, state) {
                              if (state is ListOrderLoaded) {
                                var orders = listShopCart
                                    .where((element) =>
                                        element.status == 'ENVIADO')
                                    .toList();
                                return TabBarItems(
                                  contexts: contexts,
                                  orders: orders,
                                  funcao: retornarDados,
                                );
                              }
                              return Container();
                            },
                          ),
                          BlocBuilder<ListOrderCubit, ListOrderState>(
                            builder: (contexts, state) {
                              if (state is ListOrderLoaded) {
                                var orders = listShopCart
                                    .where((element) =>
                                        element.status != 'ENVIADO')
                                    .toList();
                                return TabBarItems(
                                  contexts: contexts,
                                  orders: orders,
                                  funcao: retornarDados,
                                );
                              }
                              return Container();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ClientScreen(),
              ),
            );
            retornarDados();
          },
          label: Text('Novo Pedido'),
          icon: Icon(Icons.add),
        ),
      ),
    );
  }
}

class TabBarItems extends StatelessWidget {
  final List<ShopCartEntity> orders;
  final BuildContext contexts;
  final Function() funcao;
  const TabBarItems({
    Key? key,
    required this.orders,
    required this.contexts,
    required this.funcao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Nome do Cliente"),
              Text(
                orders[index].nome,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text("CPF/CNPJ"),
              Text(
                orders[index].cpfCnpj,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Status do Pedido"),
              Text(
                orders[index].status ?? 'PENDENTE',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.shopping_cart_checkout,
                      color: Colors.blue,
                    ),
                  ),
                  Text("Quantidade"),
                  Text(
                    orders[index].totalItens.toString(),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.monetization_on),
                    color: Colors.green,
                  ),
                  Text("Total:"),
                  Text(
                    NumberFormat.simpleCurrency(
                            locale: 'pt-BR', decimalDigits: 2)
                        .format(orders[index].total),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              orders[index].status != 'ENVIADO'
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => ShopCartCubit(),
                                  child: ShopCartScreen(
                                    pedido: orders[index],
                                  ),
                                ),
                              ),
                            ).whenComplete(() =>
                                context.read<ListOrderCubit>().getLocarOrder());
                          },
                          child: Text('Editar Pedido'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.orange),
                          onPressed: () async {
                            Connectivity connectivity = Connectivity();
                            final connectivityStatus =
                                await connectivity.checkConnectivity();
                            if (connectivityStatus != ConnectivityResult.none) {
                              var hasDispatched = await context
                                  .read<ListOrderCubit>()
                                  .postOrder(
                                    orders[index].idPedidoApp,
                                    orders[index],
                                  );

                              if (hasDispatched != '') {
                                await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              funcao();
                                            },
                                            child: Text('Ok'))
                                      ],
                                      title: Text(
                                          'Pedido enviado: $hasDispatched'),
                                    );
                                  },
                                );
                              }
                            } else {
                              ComumShop().showMessage(
                                  context, 'Sem conexão de internet');
                            }
                          },
                          child: Text('Enviar Pedido'),
                        ),
                      ],
                    )
                  : Container(),
              orders[index].status != 'ENVIADO'
                  ? TextButton(
                      onPressed: () async {
                        await context.read<ListOrderCubit>().removeOrder(
                              orders[index].idPedidoApp,
                            );
                        funcao();
                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 30,
                      ),
                    )
                  : Container(),
              const Divider(thickness: 1),
            ],
          ),
        );
      },
    );
  }
}
