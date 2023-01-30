import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:i9/src/screens/checkout/cubit/shop_cart_cubit.dart';

class ComumShop {
  String? paymantGatewayDescription = '';

  mensagem(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 50),
        content: Text(msg),
        action: SnackBarAction(
          label: 'Aviso',
          onPressed: () {},
        ),
      ),
    );
  }

  editarItem(BuildContext context, state) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: ListView.builder(
            itemCount: state.cart.item!.length,
            itemBuilder: (context, index) {
              return ListTile(
                trailing: IconButton(
                  onPressed: () {
                    context.read<ShopCartCubit>().removeItem(
                          state.cart.item![index],
                          index,
                        );
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.delete),
                ),
                title: Text(
                  state.cart.item![index].nameproduct,
                ),
              );
            },
          ),
        );
      },
    );
  }

  showMessage(BuildContext context, String msg) {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Atenção!'),
          content: Text(msg),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}



  // inserirObservacao(BuildContext contexts) async {
  //   return showDialog(
  //     context: contexts,
  //     builder: (context) {
  //       return Dialog(
  //         // insetPadding: EdgeInsets.symmetric(vertical: 140),
  //         child: Container(
  //           // margin: EdgeInsets.all(18),
  //           padding: EdgeInsets.all(18),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Text('Observaçåo'),
  //               TextField(
  //                 controller: textEditingController,
  //                 maxLines: 5,
  //                 decoration: InputDecoration(
  //                   border: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(8),
  //                   ),
  //                 ),
  //               ),
  //               ElevatedButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: Text('Ok'),
  //               )
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // editarItem(BuildContext contexts, state) async {
  //   return showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Dialog(
  //         child: ListView.builder(
  //           itemCount: state.cart.item!.length,
  //           itemBuilder: (context, index) {
  //             return ListTile(
  //               trailing: IconButton(
  //                 onPressed: () {
  //                   contexts.read<ShopCartCubit>().removeItem(
  //                         state.cart.item![index],
  //                       );
  //                   Navigator.pop(context);
  //                 },
  //                 icon: Icon(Icons.delete),
  //               ),
  //               title: Text(
  //                 state.cart.item![index].nameproduct,
  //               ),
  //             );
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }

  // ShowMessage(String msg) {
  //   showDialog(
  //     context: context,
  //     builder: (_) {
  //       return AlertDialog(
  //         title: Text('Atenção!'),
  //         content: Text(msg),
  //         actions: [
  //           ElevatedButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: Text('Ok'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }