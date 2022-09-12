import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:layang_layang_app/models/auth_model.dart';
import 'package:http/http.dart' as http;
import 'package:layang_layang_app/models/user_model.dart';
import 'package:layang_layang_app/ui/widgets/static_base_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  Future<http.Response?> register(
    String? email,
    String? password,
    String? passwordConfirmation,
    String? name,
    String? address,
    String? gender,
    String? dateOfBirth,
    String? whatsapp,
  ) async {
    try {
      var body = {
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'name': name,
        'address': address,
        'gender': gender,
        'date_of_birth': dateOfBirth,
        'whatsapp': whatsapp,
      };
      print(body);
      var response = await http.post(
        Uri.parse(
          "http://${StaticBaseUrl.baseUrl}/api/register",
        ),
        headers: {
          "Accept": "application/json",
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

  Future<http.Response?> login(
    String? email,
    String? password,
  ) async {
    try {
      var body = {
        'email': email,
        'password': password,
      };
      print(body);
      var response = await http.post(
        Uri.parse(
          "http://${StaticBaseUrl.baseUrl}/api/login",
        ),
        headers: {
          "Accept": "application/json",
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

  Future<http.Response?> logout(
    String token,
  ) async {
    try {
      var response = await http.post(
        Uri.parse(
          "http://${StaticBaseUrl.baseUrl}/api/logout",
        ),
        headers: {
          "Accept": "application/json",
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
