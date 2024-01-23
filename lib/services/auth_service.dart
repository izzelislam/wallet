import 'dart:convert';

import 'package:bank_sha/models/sign_in_form_model.dart';
import 'package:bank_sha/models/sign_up_form_model.dart';
import 'package:bank_sha/models/user_model.dart';
import 'package:bank_sha/shared/values.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http; 

class AuthService{

  Future<bool> checkEmail(String email) async {
    try {
      Uri url = Uri.parse('$baseUrl/is-email-exist');
      final res = await http.post(
        url,
        body: {'email' : email}
      );

      if (res.statusCode == 200){
        return jsonDecode(res.body)["is_email_exist"];
      }else{
        return jsonDecode(res.body)["errors"];
      }

    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> register(SignUpFormModel data) async {
    try {
      Uri url = Uri.parse('$baseUrl/register');
      final res = await http.post(url, 
        body: data.toJson()
      );

      if (res.statusCode == 200){
        UserModel user = UserModel.fromjson(jsonDecode(res.body)); 
        user  = user.copyWith(password: data.password);

        await storeCredentialToLocal(user);

        return user;
      }else{
        throw jsonDecode(res.body)["message"];
      }

    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> login(SignInFormModel data) async {
    try {
      Uri url = Uri.parse('$baseUrl/login');
      final res = await http.post(url, body: data.toJson());

      if (res.statusCode == 200){
          UserModel user =  UserModel.fromjson(jsonDecode(res.body));
          user = user.copyWith(password: data.password);

          await storeCredentialToLocal(user);

          return user;
      }else{
        throw jsonDecode(res.body)["message"];
      }

    } catch (e) {
      rethrow; 
    }
  }

  Future<void> storeCredentialToLocal(UserModel data) async {
    try {
      const storage = FlutterSecureStorage();
      await storage.write(key: "email", value: data.email);
      await storage.write(key: "password", value: data.password);
      await storage.write(key: "token", value: data.token);
    } catch (e) {
        rethrow;
    }
  }

  Future<SignInFormModel> getCredentialFromLocal() async {
      const storage = FlutterSecureStorage();
      
      Map<String, String> valuee = await storage.readAll();
      print(valuee);
      print(valuee["email"]);
      print(valuee["password"]);
    try {

      if (valuee["email"] == null || valuee["password"] == null){
        throw "unauthenticated";
      }
        final SignInFormModel data  = SignInFormModel(email: valuee["email"], password: valuee["password"]);
      
      return data;

    } catch (e) {
      rethrow;
    }
  }

  Future<String> getToken() async {
    try {
      String token = '';
      const storage = FlutterSecureStorage();
      
      String? value = await storage.read(key: 'token');

      if (value != null){
        token = 'Bearer $value';
      }
      
      return token;
      
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearLocalStorage() async {
    try {
      const storage = FlutterSecureStorage();
      await storage.delete(key: "email");
      await storage.delete(key: "password");
      await storage.delete(key: "token");

    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      final token = await getToken();
      final Uri url = Uri.parse('$baseUrl/logout');

      final res  = await http.post(
        url,
        headers: {'Authorization' : token}
      );

      if (res.statusCode != 200){
        throw jsonDecode(res.body)["message"];
      }

    } catch (e) {
      rethrow ;
    }
  }

}