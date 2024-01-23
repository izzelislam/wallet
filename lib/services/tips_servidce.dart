import 'dart:convert';

import 'package:bank_sha/models/tips_model.dart';
import 'package:bank_sha/services/auth_service.dart';
import 'package:bank_sha/shared/values.dart';
import 'package:http/http.dart' as http;

class TipsService{

  Future<List<TipsModel>> getTips() async{
    try {
      final token = await AuthService().getToken();
      final Uri url = Uri.parse('$baseUrl/tips');
      final headers = {'Authorization' : token};

      final res = await http.get(url, headers: headers);

      if (res.statusCode != 200){
        throw jsonDecode(res.body)["message"];
      }
      

      List<dynamic> datasDecoded = jsonDecode(res.body)["data"];

      List<TipsModel> data = datasDecoded.map((e) => TipsModel.fromJson(e)).toList();

      return data;

    } catch (e) {
      rethrow;
    }
  }

}