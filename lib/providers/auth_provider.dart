import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:layang_layang_app/models/auth_model.dart';
import 'package:http/http.dart' as http;
import 'package:layang_layang_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  Future<UserModel?> register(
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
        'passwordConfirmation': passwordConfirmation,
        'name': name,
        'address': address,
        'gender': gender,
        'date_of_birth': dateOfBirth,
        'whatsapp': whatsapp,
      };
      print(body);
      var response = await http.post(
        Uri.parse(
          "https://sipela.herokuapp.com/api/register",
        ),
        headers: {
          "Accept": "application/json",
        },
        body: body,
      );
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 201) {
        UserModel user = UserModel.fromJson(
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

  Future<UserModel?> login(
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
          "https://sipela.herokuapp.com/api/login",
        ),
        headers: {
          "Accept": "application/json",
        },
        body: body,
      );
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 201) {
        return UserModel.fromJson(
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

  Future<UserModel?> logout(
    String token,
  ) async {
    try {
      var response = await http.post(
        Uri.parse(
          "https://sipela.herokuapp.com/api/logout",
        ),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 201) {
        return UserModel.fromJson(
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
