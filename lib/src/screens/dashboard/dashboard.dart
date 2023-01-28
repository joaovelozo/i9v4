import 'dart:async';

import 'package:flutter/material.dart';
import 'package:i9/src/controllers/clienteController.dart';
import 'package:i9/src/controllers/produtoController.dart';
import 'package:i9/src/screens/clients/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../checkout/domain/entities/shop_cart_entity.dart';
import 'package:i9/src/widget/alert.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isLoading = true;
  int totalClient = 0;
  int totalProdutos = 0;
  int totalPedidos = 0;
  @override
  void initState() {
    Future.wait([
      fetchTotalClients(),
      fecthTotalProdutos(),
      fecthTotalPedidos(),
    ]).whenComplete(
      () {
        setState(() {
          isLoading = false;
        });
      },
    );
    super.initState();
  }

  Future<void> fetchTotalClients() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await fetchClientes().then((value) {
        totalClient = value.length;
        prefs.setInt('totalClient', value.length);
      });
    } catch (e) {
      totalClient = prefs.getInt('totalClient') ?? 0;
    }
  }

  Future<void> fecthTotalProdutos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await fetchProdutos().then((value) {
        totalProdutos = value.length;
        prefs.setInt('totalProdutos', value.length);
      });
    } catch (e) {
      totalProdutos = prefs.getInt('totalProdutos') ?? 0;
    }
  }

  Future<void> fecthTotalPedidos() async {
    var prefs = await SharedPreferences.getInstance();
    try {
      List<ShopCartEntity> listShopCart = [];
      if (prefs.containsKey('pedidos')) {
        List<String>? a = prefs.getStringList('pedidos');
        listShopCart = a!.map((e) => ShopCartEntity.fromJson(e)).toList();
        prefs.setInt('listShopCart', listShopCart.length);
      }
      totalPedidos = listShopCart.length;
    } catch (e) {
      totalPedidos = prefs.getInt('listShopCart') ?? 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Dashboard"),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  showExitPopup(context);
                },
                icon: Icon(Icons.exit_to_app))
          ],
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(30.0),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                "Clientes",
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 11.0,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "$totalClient",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.apply(
                                              color: Colors.white,
                                              fontWeightDelta: 2),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 11.0,
                              ),
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: 11.0,
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(30.0),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                "Produtos",
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 11.0,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "$totalProdutos",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.apply(
                                              color: Colors.white,
                                              fontWeightDelta: 2),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 11.0,
                              ),
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: 11.0,
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(30.0),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              "Ultimos Pedidos",
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 11.0,
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "$totalPedidos",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.apply(
                                            color: Colors.white,
                                            fontWeightDelta: 2),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ClientScreen(),
              ),
            );
          },
          label: Text('Novo Pedido'),
          icon: Icon(Icons.add),
        ),
      ),
    );
  }
}
