import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:layang_layang_app/models/toko_model.dart';

class TokoProider with ChangeNotifier {
  Future<TokoModel?> listToko(String token, String user_id) async {
    try {
      var response = await http.get(
          Uri.parse(
              "http://sipela.herokuapp.com/api/toko?filterBy=user_id&filterValue=$user_id"),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        TokoModel toko = TokoModel.fromJson(
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
