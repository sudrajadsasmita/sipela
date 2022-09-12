import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:layang_layang_app/models/shop_model.dart';
import 'package:http/http.dart' as http;
import 'package:layang_layang_app/ui/widgets/static_base_url.dart';

class ShopProvider with ChangeNotifier {
  Future<ShopModel?> listToko(String token) async {
    try {
      var response = await http.get(
          Uri.parse("http://${StaticBaseUrl.baseUrl}/api/barangbase"),
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

  Future<http.Response?> requestBarang(
    String? token,
    String? barangbase_id,
    String? user_id,
  ) async {
    try {
      var body = {
        "barangbase_id": barangbase_id,
        "request_from": user_id,
      };
      var response = await http.post(
        Uri.parse(
          "http://${StaticBaseUrl.baseUrl}/api/requestbarang",
        ),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );
      print(response.statusCode);
      print(response.body);
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
