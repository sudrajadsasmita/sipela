import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:layang_layang_app/models/shop_model.dart';
import 'package:http/http.dart' as http;

class ShopProvider with ChangeNotifier {
  Future<ShopModel?> listToko(String token, String user_id) async {
    try {
      var response = await http.get(
          Uri.parse(
              "http://sipela.herokuapp.com/api/requestbarang?filterBy=request_from&filterValue=$user_id"),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        ShopModel toko = ShopModel.fromJson(
          jsonDecode(response.body),
        );
        return toko;
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
