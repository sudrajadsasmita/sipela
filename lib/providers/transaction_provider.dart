import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:layang_layang_app/models/transaction_model.dart';
import 'package:http/http.dart' as http;

class TransactionProvider with ChangeNotifier {
  Future<TransactionModel?> listTransactionByUser(
      String token, String user_id) async {
    try {
      var response = await http.get(
          Uri.parse(
              "http://sipela.herokuapp.com/api/transaction?filterBy=user_id&filterValue=$user_id"),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        return TransactionModel.fromJson(
          jsonDecode(response.body),
        );
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<TransactionModel?> listTransactionByToko(
      String token, String user_id) async {
    try {
      var response = await http.get(
          Uri.parse(
              "http://sipela.herokuapp.com/api/transaction?filterBy=toko_id&filterValue=$user_id"),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        TransactionModel transaksi = TransactionModel.fromJson(
          jsonDecode(response.body),
        );
        return transaksi;
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
