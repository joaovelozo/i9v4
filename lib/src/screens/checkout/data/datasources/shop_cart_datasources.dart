// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:i9/src/screens/checkout/data/datasources/pedido_model.dart';
import 'package:i9/src/screens/checkout/domain/entities/paymant_gateway_entity.dart';
import 'package:i9/src/services/http_api.dart';

import '../../../../services/http_adapter.dart';
import '../../domain/entities/order_entity.dart';

class ShopCartDataSources {
  Future<String> postOrder(OrderEntity order) async {
    var url = Uri.parse("${baseHost}PEDIDOS_APP_WS.rule?sys=ERP");

    var body = jsonEncode(PedidoProdutoModel.fromJson(order.toMap()));
    try {
      var response = await http.post(
        url,
        body: body,
      );
      try {
        if (response.body.toString().contains('id_pedido_app')) {
          List value = jsonDecode(response.body);
          return value[0]['id_pedido_app'];
        } else {
          Map value = jsonDecode(response.body);
          return value['INFORMACAO'];
        }
      } catch (e) {
        print(e.toString());
        return 'Error ao enviar';
      }
    } catch (e) {
      throw Exception('fetchClientes');
    }
  }

  Future<List<PaymantGatewayEntity>> getGatewayPayment() async {
    const String url = "${baseHost}FORMAS_PAGAMENTO_WS.rule?sys=ERP";

    var body = {
      'token': 'c8c8cf52-5c11-11ec-bf63-0242ac130002',
    };
    try {
      var response = await HttpAdapter(http.Client()).request(
        url: url,
        method: 'post',
        body: body,
      );

      var list = json.decode(response!) as List<dynamic>;
      return list.map((e) => PaymantGatewayEntity.fromMap(e)).toList();
    } catch (e) {
      throw Exception('fetchClientes');
    }
  }
}
