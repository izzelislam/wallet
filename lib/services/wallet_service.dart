import 'dart:convert';

import 'package:bank_sha/services/auth_service.dart';
import 'package:bank_sha/shared/values.dart';
import 'package:http/http.dart' as http;

class WalletService {

  Future<void> updatePin(String newPin, String oldPin) async{
    try {
        final token = await AuthService().getToken();
        Uri url = Uri.parse('$baseUrl/wallets');
        final res = await http.put(
          url,
          body: {
            "previous_pin": oldPin,
            "new_pin": newPin
          },
          headers: {'Authorization' : token}
        );

        if (res.statusCode != 200){
          throw jsonDecode(res.body)["message"];
        }

    } catch (e) {
      rethrow;
    }
  }

}