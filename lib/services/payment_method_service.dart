import 'dart:convert';

import 'package:bank_sha/models/payment_method_model.dart';
import 'package:bank_sha/services/auth_service.dart';
import 'package:bank_sha/shared/values.dart';
import 'package:http/http.dart' as http;

class PaymentMethodService{
  Future<List<PaymentMethodModel>> getPaymentMethods() async {
    try {
      final token = await AuthService().getToken();
      Uri url = Uri.parse('$baseUrl/payment_methods');

      final res = await http.get(url, headers: {'Authorization' : token});

      if (res.statusCode != 200){
        throw jsonDecode(res.body)["message"];
      }

    //  List<PaymentMethodModel> data = (jsonDecode(res.body).map((e) => PaymentMethodModel.fromJson(e))).toList();

    // List<PaymentMethodModel> data = (jsonDecode(res.body) as List<Map<String, dynamic>>)
    //   .map((data) => PaymentMethodModel.fromJson(data))
    //   .toList();

      List<dynamic> datasDecoded = jsonDecode(res.body);

      List<PaymentMethodModel> data = datasDecoded.map((e) => PaymentMethodModel.fromJson(e)).toList();

      return data;

    } catch (e) {
      rethrow;
    }
  }

  

}