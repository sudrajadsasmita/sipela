import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:layang_layang_app/models/aproved_model.dart';
import 'package:layang_layang_app/models/submit_aprove_model.dart';
import 'package:http/http.dart' as http;
import 'package:layang_layang_app/ui/pages/tranasaksi/update_transaction_status_page.dart';
import 'package:layang_layang_app/ui/widgets/static_base_url.dart';

class AprovedProvider with ChangeNotifier {
  AprovedModel? _aprove;

  AprovedModel get aprove => _aprove!;

  set aprove(AprovedModel newAprove) {
    _aprove = newAprove;
    notifyListeners();
  }

  Future<SubmitAproveModel?> updateTransactionStatus(
    String? token,
    String? transaction_id,
    String? transactionStatus,
    String? shipmentStatus,
  ) async {
    try {
      var body = {
        'status_transaksi': transactionStatus,
        'status_pengiriman': shipmentStatus,
      };
      print(body);
      var response = await http.put(
        Uri.parse(
          "http://${StaticBaseUrl.baseUrl}/api/transaction/$transaction_id",
        ),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: body,
      );
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        return SubmitAproveModel.fromJson(
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
