import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:layang_layang_app/models/request_barang_model.dart';
import 'package:layang_layang_app/models/request_update_model.dart';
import 'package:layang_layang_app/ui/widgets/static_base_url.dart';

class RequestProvider with ChangeNotifier {
  RequestUpdateModel? _requestUpdate;

  RequestUpdateModel get requestUpdate => _requestUpdate!;
  set requestUpdate(RequestUpdateModel newRequestUpdate) {
    _requestUpdate = newRequestUpdate;
    notifyListeners();
  }

  Future<RequestBarangModel?> getAllRequest(String token) async {
    try {
      var response = await http.get(
        Uri.parse(
          "http://${StaticBaseUrl.baseUrl}/api/requestbarang",
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
        return RequestBarangModel.fromJson(
          jsonDecode(response.body),
        );
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<http.Response?> updateStatus(String token, requestId, barangbaseId,
      requestFrom, requestStatus, stock) async {
    try {
      var body = {
        "barangbase_id": barangbaseId,
        "request_from": requestFrom,
        "request_status": requestStatus,
        "stock": stock
      };
      var response = await http.put(
        Uri.parse(
          "http://${StaticBaseUrl.baseUrl}/api/requestbarang/${requestId}",
        ),
        headers: {
          "Accept": "application/json",
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
