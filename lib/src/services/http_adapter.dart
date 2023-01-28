import 'dart:convert';
import 'package:http/http.dart';

import 'http_error.dart';

const Utf8Codec utf8 = Utf8Codec();

class HttpAdapter {
  final Client client;

  HttpAdapter(this.client);

  Future<String?> request(
      {required String url, required String method, Map? body}) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };
    final jsonBody = body != null ? jsonEncode(body) : null;
    var response = Response('', 500);
    try {
      if (method == 'post') {
        response =
            await client.post(Uri.parse(url), headers: headers, body: jsonBody);
      }
    } catch (error) {
      throw HttpError.serverError;
    }
    return await _handdleResponse(response);
  }

  String? _handdleResponse(Response response) {
    if (response.statusCode == 200) {
      return response.body.isEmpty ? null : utf8.decode(response.bodyBytes);
    } else if (response.statusCode == 204) {
      return null;
    } else if (response.statusCode == 400) {
      throw HttpError.badRequest;
    } else if (response.statusCode == 401) {
      throw HttpError.unauthorized;
    } else if (response.statusCode == 403) {
      throw HttpError.forbidden;
    } else if (response.statusCode == 404) {
      throw HttpError.notFound;
    } else {
      throw HttpError.serverError;
    }
  }
}
