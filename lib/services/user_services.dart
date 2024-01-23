import 'dart:convert';

import 'package:bank_sha/models/user_edit_form_model.dart';
import 'package:bank_sha/models/user_model.dart';
import 'package:bank_sha/services/auth_service.dart';
import 'package:bank_sha/shared/values.dart';
import 'package:http/http.dart' as http;

class  UserService{

  Future<void> updateUser(UserEditFormModel data) async {
    try {
      final token = await AuthService().getToken();
      
      Uri url = Uri.parse('$baseUrl/users');
      final res = await http.put(url,
        body: data.toJson(),
        headers: {'Authorization' : token}
      );

      if (res.statusCode != 200){
        throw jsonDecode(res.body)["message"] ;
      }

    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserModel>> getRecentUsers() async{
    try {
      final token = await AuthService().getToken();
      final Uri url = Uri.parse('$baseUrl/transfer_histories');
      final headers = {'Authorization' : token};

      final res = await http.get(url, headers: headers);

      if (res.statusCode != 200){
        throw jsonDecode(res.body)["message"];
      }

      List<dynamic> datasDecoded = jsonDecode(res.body)["data"];

      List<UserModel> data = datasDecoded.map((e) => UserModel.fromjson(e)).toList();

      return data;

    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserModel>> getUserByUsername(String param)async{
    try {
      final token = await AuthService().getToken();
      final Uri url = Uri.parse('$baseUrl/users/$param');
      final headers = {'Authorization' : token};

      final res = await http.get(url, headers: headers);

      if (res.statusCode != 200){
        throw jsonDecode(res.body)["message"];
      }

      List<dynamic> datasDecoded = jsonDecode(res.body);

      List<UserModel> data = datasDecoded.map((e) => UserModel.fromjson(e)).toList();
      
      return data;
    } catch (e) {
      rethrow;
    }
  }

}