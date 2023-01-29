import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i9/src/screens/checkout/comum_shop.dart';

import 'package:i9/src/screens/clients/client.dart';
import 'package:i9/src/screens/dashboard/dashboard.dart';
import 'package:i9/src/screens/orders/cubit/list_order_cubit.dart';
import 'package:i9/src/screens/orders/orders.dart';
import 'package:i9/src/screens/products/product.dart';
import 'package:i9/src/services/http_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int initialPage = 3;
  late PageController pc;
  bool isLoading = true;
  @override
  void initState() {
    Future.wait([
      atualizar(),
    ]).whenComplete(
      () {
        setState(() {
          isLoading = false;
        });
      },
    );
    super.initState();
    pc = PageController(initialPage: initialPage);
  }

  Future<void> atualizar() async {
    // Executa a rotina de atualização de dados
    try {
      await HttpApi().produtos();
      await HttpApi().clientes();
      await HttpApi().formasPagamento();
      ComumShop()
          .mensagem(context, 'Produtos e clientes atualizados com sucesso.');
    } catch (e) {}

    // Configura a rotina para executar novamente em 5 minutos
    Timer(Duration(minutes: 10), atualizar);
  }

  setActualPage(page) {
    setState(() {
      initialPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? Scaffold(
            body: PageView(
              controller: pc,
              children: [
                const DashboardScreen(),
                const ClientScreen(),
                const ProductScreen(),
                BlocProvider(
                  create: (context) => ListOrderCubit()..getLocarOrder(),
                  child: const OrdersScreen(),
                ),
              ],
              onPageChanged: setActualPage,
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.orange,
              unselectedItemColor: Colors.orangeAccent,
              backgroundColor: Colors.white,
              currentIndex: initialPage,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.dashboard_sharp,
                      color: Colors.orangeAccent,
                    ),
                    label: 'Dashboard'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.people,
                      color: Colors.orangeAccent,
                    ),
                    label: 'Clientes'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.shopping_bag,
                      color: Colors.orangeAccent,
                    ),
                    label: 'Produtos'),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.monetization_on,
                    color: Colors.orangeAccent,
                  ),
                  label: 'Pedidos',
                ),
              ],
              onTap: (page) {
                pc.animateToPage(
                  page,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.ease,
                );
              },
            ),
          )
        : Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 15),
                  Text('Atualizando produtos e clientes...'),
                ],
              ),
            ),
          );
  }
}
