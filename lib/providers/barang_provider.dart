import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:layang_layang_app/models/barang_model.dart';
import 'package:http/http.dart' as http;
import 'package:layang_layang_app/models/barang_update_model.dart';
import 'package:layang_layang_app/ui/widgets/static_base_url.dart';

class BarangProvider with ChangeNotifier {
  BarangUpdateModel? _barangUpdate;

  BarangUpdateModel get barangUpdate => _barangUpdate!;
  set barangUpdate(BarangUpdateModel newBarangUpdate) {
    _barangUpdate = newBarangUpdate;
    notifyListeners();
  }

  Future<BarangModel?> getAllBarang(String token) async {
    try {
      var response = await http.get(
        Uri.parse(
          "http://${StaticBaseUrl.baseUrl}/api/barangbase",
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        return BarangModel.fromJson(
          jsonDecode(response.body),
        );
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<http.Response?> createBarang(
      String token, name, description, price, pictureLink) async {
    try {
      var body = {
        "name": name,
        "description": description,
        "price": price,
        "picture_link": pictureLink,
      };

      var response = await http.post(
        Uri.parse(
          "http://${StaticBaseUrl.baseUrl}/api/barangbase",
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

  Future<http.Response?> updateBarang(
      String token, barangId, name, description, price, pictureLink) async {
    try {
      var body = {
        "name": name,
        "description": description,
        "price": price,
        "picture_link": pictureLink,
      };

      var response = await http.put(
        Uri.parse(
          "http://${StaticBaseUrl.baseUrl}/api/barangbase/${barangId}",
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

  Future<http.Response?> deleteBarang(
    String token,
    String barangId,
  ) async {
    try {
      var response = await http.delete(
        Uri.parse(
          "http://${StaticBaseUrl.baseUrl}/api/barangbase/${barangId}",
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
