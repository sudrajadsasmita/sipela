import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:layang_layang_app/models/toko_model.dart';
import 'package:layang_layang_app/models/toko_update_model.dart';
import 'package:layang_layang_app/ui/widgets/static_base_url.dart';

class TokoProvider with ChangeNotifier {
  TokoUpdateModel? _toko;

  TokoUpdateModel get toko => _toko!;

  set toko(TokoUpdateModel newToko) {
    _toko = newToko;
    notifyListeners();
  }

  Future<TokoModel?> listToko(String token, String user_id) async {
    try {
      var response = await http.get(
          Uri.parse(
              "http://${StaticBaseUrl.baseUrl}/api/toko?filterBy=user_id&filterValue=$user_id"),
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

  Future<http.Response?> createToko(
    String token,
    String name,
    String description,
    String userId,
  ) async {
    try {
      var body = {
        "name": name,
        "description": description,
        "user_id": userId,
      };
      var response = await http.post(
        Uri.parse(
          "http://${StaticBaseUrl.baseUrl}/api/toko",
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

  Future<http.Response?> deleteToko(
    String token,
    String tokoId,
  ) async {
    try {
      var response = await http.delete(
        Uri.parse(
          "http://${StaticBaseUrl.baseUrl}/api/toko/${tokoId}",
        ),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
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
