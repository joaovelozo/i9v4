import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:i9/src/helpers/banco_controller.dart';
import 'package:i9/src/models/clientes.dart';
import 'package:i9/src/models/formas_pagamento_model.dart';
import 'package:i9/src/models/produtos.dart';
import 'package:i9/src/screens/auth/loginScreen.dart';
import 'package:i9/src/screens/checkout/cabecalho_shop.dart';
import 'package:i9/src/screens/checkout/comum_shop.dart';
import 'package:i9/src/screens/checkout/cubit/shop_cart_cubit.dart';
import 'package:i9/src/screens/checkout/domain/entities/shop_cart_entity.dart';
import 'package:i9/src/screens/checkout/formas_pagamento_widget.dart';
import 'package:i9/src/screens/checkout/lista_produtos_shop.dart';
import 'package:i9/src/screens/home/home.dart';

class ShopCartScreen extends StatefulWidget {
  final Cliente? client;
  final ShopCartEntity? pedido;
  const ShopCartScreen({
    Key? key,
    this.client,
    this.pedido,
  }) : super(key: key);

  @override
  State<ShopCartScreen> createState() => _ShopCartScreenState();
}

class _ShopCartScreenState extends State<ShopCartScreen> {
  ComumShop comum = ComumShop();
  Databasepadrao db = Databasepadrao.instance;
  List<Produto> produtos = <Produto>[];
  List<Produto> produtosDisplay = <Produto>[];
  List<FormasPagamentoModel> paymentGateways = [];
  bool isLoading = true;
  TextEditingController textEditingController = TextEditingController(text: '');
  Cliente ClienteAtual = Cliente();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  editarPedido() async {
    if (widget.pedido != null) {
      //retornar todos os dados do pedido
      Cliente? cliente = await db.retornarCliente(
        widget.pedido!.idCliente,
      );
      if (cliente != null) {
        ClienteAtual = cliente;
        context.read<ShopCartCubit>().startCart(order: widget.pedido);
        var lista = await db.select(
          'FORMAS_PAGAMENTO',
          id: widget.pedido!.idFormaPagamento,
        );
        if (lista.isNotEmpty) {
          comum.paymantGatewayDescription = lista[0]['descricao'].toString();
        }
      }
    } else {
      //retornar dados para novo pedido
      ClienteAtual = widget.client!;
      context.read<ShopCartCubit>().startCart(cliente: ClienteAtual);
    }
  }

  formasPagamento() async {
    var lista = await db.select('FORMAS_PAGAMENTO');
    for (var item in lista) {
      paymentGateways.add(FormasPagamentoModel.fromJson(item));
    }
  }

  retornarProdutos() async {
    produtosDisplay = [];
    produtos = [];
    setState(() {});
    var listaDB = await db.select('PRODUTO');
    if (listaDB.isNotEmpty) {
      for (var item in listaDB) {
        produtos.add(Produto.fromMap(item));
      }
      produtosDisplay = produtos;
    }
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    editarPedido();
    retornarProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Carrinho'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                icon: Icon(Icons.exit_to_app))
          ],
        ),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () async {
            await retornarProdutos();
            setState(() {});
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BlocBuilder<ShopCartCubit, ShopCartState>(
                  builder: (contexts, state) {
                    if (state is ShopCartLoading) {
                      return CircularProgressIndicator();
                    }
                    if (state is ShopCartLoaded) {
                      return Column(
                        children: [
                          //Cabeçalho
                          CabecalhoShop(
                            state: state,
                            ClienteAtual: ClienteAtual,
                          ),
                          const Divider(thickness: 2),
                          //Forma de pagamento
                          FormaPagamentoWidget(
                            comum: comum,
                            formasPagamento: formasPagamento,
                            inserirObservacao: inserirObservacao,
                            contexts: contexts,
                            paymentGateways: paymentGateways,
                          ),
                          const Divider(thickness: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.blue),
                                onPressed: state.cart.item?.isNotEmpty ?? false
                                    ? () async {
                                        if (state.cart.item?.isNotEmpty ??
                                            false)
                                          // await ComumShop().editarItem(contexts, state);
                                          await editarItem(contexts);

                                        setState(() {});
                                      }
                                    : null,
                                child: Text("Editar Lista"),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.orange),
                                onPressed: state.cart.item?.isNotEmpty ?? false
                                    ? () async {
                                        if (state.cart.idFormaPagamento != '') {
                                          bool hasDispatched = false;
                                          if (state.cart.item?.isNotEmpty ??
                                              false) {
                                            hasDispatched = await contexts
                                                .read<ShopCartCubit>()
                                                .saveLocalOrder(
                                                  textEditingController.text,
                                                  state.cart.idFormaPagamento,
                                                );
                                          }
                                          if (hasDispatched) {
                                            await comum.showMessage(
                                                contexts, 'Pedido Salvo');
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const HomeScreen()));
                                          }
                                        } else {
                                          comum.showMessage(context,
                                              'Selecione a forma de pagamento antes de salvar o pedido');
                                        }
                                      }
                                    : null,
                                child: Text(
                                  "Salvar Pedido",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                    return Center(
                      child: Text('data'),
                    );
                  },
                ),
                //Lista de produtos
                ListaProdutosShop(
                  comum: comum,
                  observacao: textEditingController.text,
                  isLoading: isLoading,
                  produtos: produtos,
                  produtosDisplay: produtosDisplay,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  inserirObservacao(BuildContext contexts) async {
    return showDialog(
      context: contexts,
      builder: (context) {
        return Dialog(
          // insetPadding: EdgeInsets.symmetric(vertical: 140),
          child: Container(
            // margin: EdgeInsets.all(18),
            padding: EdgeInsets.all(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Observaçåo'),
                TextField(
                  controller: textEditingController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Ok'),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  editarItem(BuildContext contexts) async {
    return showDialog(
      context: contexts,
      builder: (context) {
        return BlocProvider.value(
          value: BlocProvider.of<ShopCartCubit>(contexts),
          child: Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 36, vertical: 48),
            child: BlocConsumer<ShopCartCubit, ShopCartState>(
              listener: (context, state) {
                if (state is ShopCartLoaded)
                  state.cart.item == null || state.cart.item!.isEmpty
                      ? Navigator.pop(context)
                      : null;
              },
              builder: (context, state) {
                if (state is ShopCartLoaded) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.cart.item!.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  state.cart.item![index].nameproduct,
                                ),
                                trailing: Column(
                                  children: [
                                    Flexible(
                                      child: Text(
                                          'R\$ ${state.cart.item![index].total.toStringAsFixed(2)}'),
                                    ),
                                    Flexible(
                                      child: Text(
                                          'R\$ ${state.cart.item![index].precoUnitario.toStringAsFixed(2)}'),
                                    ),
                                  ],
                                ),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          contexts
                                              .read<ShopCartCubit>()
                                              .removeItemQtd(index);
                                        },
                                        icon: Icon(Icons.remove),
                                        color: Colors.blue),
                                    Text('${state.cart.item![index].qtde}x'),
                                    IconButton(
                                        onPressed: () {
                                          contexts
                                              .read<ShopCartCubit>()
                                              .addItem(state.cart.item![index]
                                                  .copyWith(qtde: 1));
                                        },
                                        icon: Icon(Icons.add),
                                        color: Colors.orange),
                                    IconButton(
                                        onPressed: () {
                                          contexts
                                              .read<ShopCartCubit>()
                                              .removeItem(
                                                  state.cart.item![index],
                                                  index);
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.delete),
                                        color: Colors.red),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              // textStyle: TextStyle(
                              //   color: Colors.white,
                              // ),
                              foregroundColor: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Fechar'),
                        )
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        );
      },
    );
  }
}
