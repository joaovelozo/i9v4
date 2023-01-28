import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:i9/src/screens/checkout/comum_shop.dart';
import 'package:i9/src/screens/checkout/cubit/shop_cart_cubit.dart';

class FormaPagamentoWidget extends StatefulWidget {
  final Function() formasPagamento;
  final Function(BuildContext contexts) inserirObservacao;
  final BuildContext contexts;
  final List paymentGateways;
  final ComumShop comum;
  FormaPagamentoWidget({
    Key? key,
    required this.formasPagamento,
    required this.inserirObservacao,
    required this.contexts,
    required this.paymentGateways,
    required this.comum,
  }) : super(key: key);

  @override
  State<FormaPagamentoWidget> createState() => _FormaPagamentoWidgetState();
}

class _FormaPagamentoWidgetState extends State<FormaPagamentoWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () async {
            await widget.formasPagamento();
            await showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return FractionallySizedBox(
                  heightFactor: 0.90,
                  child: ListView.builder(
                    itemCount: widget.paymentGateways.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          widget.paymentGateways[index].descricao ?? '',
                        ),
                        onTap: () => Navigator.pop(
                          context,
                          widget.paymentGateways[index],
                        ),
                      );
                    },
                  ),
                );
              },
            ).then(
              (value) {
                widget.comum.paymantGatewayDescription = value!.descricao ?? '';
                context.read<ShopCartCubit>().addPaymantGateway(value);
              },
            );
            setState(() {});
          },
          icon: Icon(Icons.credit_card),
        ),
        Text(widget.comum.paymantGatewayDescription == ''
            ? 'Forma de Pagamento'
            : widget.comum.paymantGatewayDescription!),
        IconButton(
          onPressed: () async {
            await widget.inserirObservacao(widget.contexts);
          },
          icon: Icon(Icons.edit),
        ),
        Text("Observações")
      ],
    );
  }
}
