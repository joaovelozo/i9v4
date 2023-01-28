import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:i9/src/screens/checkout/comum_shop.dart';
import 'package:i9/src/screens/checkout/cubit/shop_cart_cubit.dart';

class EditarSalvarPedidoShop extends StatefulWidget {
  dynamic state;
  BuildContext contexts;
  Function(BuildContext contexts, dynamic state) editarItem;
  String? paymantGatewayDescription;
  TextEditingController controller;
  EditarSalvarPedidoShop({
    Key? key,
    required this.state,
    required this.contexts,
    required this.editarItem,
    required this.paymantGatewayDescription,
    required this.controller,
  }) : super(key: key);

  @override
  State<EditarSalvarPedidoShop> createState() => _EditarSalvarPedidoShopState();
}

class _EditarSalvarPedidoShopState extends State<EditarSalvarPedidoShop> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
          ),
          onPressed: widget.state.cart.item.isNotEmpty ?? false
              ? () async {
                  if (widget.state.cart.item?.isNotEmpty ?? false)
                    // await ComumShop().editarItem(contexts, state);
                    await widget.editarItem(widget.contexts, widget.state);

                  setState(() {});
                }
              : null,
          child: Text("Editar Lista"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.orange,
          ),
          onPressed: widget.state.cart.item?.isNotEmpty ?? false
              ? () async {
                  if (widget.paymantGatewayDescription != '') {
                    bool hasDispatched = false;
                    if (widget.state.cart.item?.isNotEmpty ?? false) {
                      hasDispatched = await widget.contexts
                          .read<ShopCartCubit>()
                          .saveLocalOrder(
                            widget.controller.value.text,
                            widget.paymantGatewayDescription!,
                          );
                    }
                    if (hasDispatched) {
                      await ComumShop().showMessage(context, 'Pedido Salvo');
                      Navigator.of(widget.contexts).pop();
                    }
                  } else {
                    ComumShop().showMessage(context,
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
    );
  }
}
