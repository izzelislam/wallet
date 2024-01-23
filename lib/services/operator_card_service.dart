import 'dart:convert';

import 'package:bank_sha/models/operator_card_model.dart';
import 'package:bank_sha/services/auth_service.dart';
import 'package:bank_sha/shared/values.dart';
import 'package:http/http.dart' as http;

class OperatorCardService{

  Future<List<OperatorCardModel>> getOperator() async {
    try {
      final token = await AuthService().getToken();
      Uri url = Uri.parse('$baseUrl/operator_cards');


      final res = await http.get(url, headers: {'Authorization' : token});  

      if (res.statusCode != 200){
        throw jsonDecode(res.body)["message"];
      }

      return List<OperatorCardModel>.from(jsonDecode(res.body)["data"].map((e) => OperatorCardModel.fromJson(e))).toList();

      
    } catch (e) {
      rethrow;
    }
  }


}