import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:layang_layang_app/models/buy_model.dart';
import 'package:layang_layang_app/models/detail_product_model.dart';
import 'package:layang_layang_app/models/display_model.dart';
import 'package:http/http.dart' as http;
import 'package:layang_layang_app/models/transaction_detail_model.dart';
import 'package:layang_layang_app/ui/widgets/static_base_url.dart';

class DisplayProvider with ChangeNotifier {
  Future<DisplayModel?> listDisplay(String token) async {
    try {
      var response = await http.get(
        Uri.parse("http://${StaticBaseUrl.baseUrl}/api/barangtoko"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        DisplayModel user = DisplayModel.fromJson(
          jsonDecode(
            response.body,
          ),
        );

        return user;
      } else {
        print('kenak prank');
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<DetailProductModel?> detailProduct(
      String token, String barangid) async {
    try {
      var response = await http.get(
        Uri.parse("http://${StaticBaseUrl.baseUrl}/api/barangtoko/$barangid"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        DetailProductModel user = DetailProductModel.fromJson(
          jsonDecode(
            response.body,
          ),
        );

        return user;
      } else {
        print('kenak prank');
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<BuyModel?> transaction(
    String? token,
    String? barangtoko_id,
    String? user_id,
    String? quantity,
  ) async {
    try {
      var body = {
        "barangtoko_id": barangtoko_id,
        "user_id": user_id,
        "quantity": quantity
      };
      print(body);
      var response = await http.post(
        Uri.parse(
          "http://${StaticBaseUrl.baseUrl}/api/newtransaction",
        ),
        headers: {
          // 'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 201) {
        return BuyModel.fromJson(
          jsonDecode(
            response.body,
          ),
        );
      } else {
        print('kenak prank');
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
