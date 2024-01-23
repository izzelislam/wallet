import 'dart:convert';

import 'package:bank_sha/models/data_plan_form_model.dart';
import 'package:bank_sha/models/topup_form_model.dart';
import 'package:bank_sha/models/transfer_form_model.dart';
import 'package:bank_sha/services/auth_service.dart';
import 'package:bank_sha/shared/values.dart';
import 'package:http/http.dart' as http;

class TransactionService{
  
  // store transaction

  Future<String> topUp(TopUpFormModel data) async {
    try {
      final token = await AuthService().getToken();
      final Uri url = Uri.parse('$baseUrl/top_ups');
      final headers = {'Authorization' : token};

      final res = await http.post(url,
        body: data.toJson(),
        headers: headers
      );

      if (res.statusCode != 200 ){
        throw jsonDecode(res.body)["message"];
      }

      print(jsonDecode(res.body)["redirect_url"]);

      return jsonDecode(res.body)["redirect_url"];
      
    } catch (e) {
      rethrow;
    }
  }

  Future<void> transfer(TransferFormModel data) async {
    try {
      final token = await AuthService().getToken();
      final Uri url = Uri.parse('$baseUrl/transfers');
      final headers = {'Authorization' : token};

      final res = await http.post(url,
        body: data.toJson(),
        headers: headers
      );

      if (res.statusCode != 200 ){
        throw jsonDecode(res.body)["message"];
      }
      
    } catch (e) {
      rethrow;
    }
  }

  Future<void> dataPlan(DataPlanFormModel data) async {
    try {
      final token = await AuthService().getToken();
      final Uri url = Uri.parse('$baseUrl/data_plans');
      final headers = {'Authorization' : token};

      final res = await http.post(url,
        body: data.toJson(),
        headers: headers
      );

      if (res.statusCode != 200 ){
        throw jsonDecode(res.body)["message"];
      }
      
    } catch (e) {
      rethrow;
    }
  }

}