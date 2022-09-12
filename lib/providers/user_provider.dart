import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:layang_layang_app/models/user_management_model.dart';
import 'package:layang_layang_app/models/user_management_update_model.dart';
import 'package:layang_layang_app/ui/widgets/static_base_url.dart';

import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  UserManagementUpdateModel? _userManagement;

  UserModel get user => _user!;
  UserManagementUpdateModel get userManagement => _userManagement!;

  set user(UserModel newUser) {
    _user = newUser;
    notifyListeners();
  }

  set userManagement(UserManagementUpdateModel newUserManagement) {
    _userManagement = newUserManagement;
    notifyListeners();
  }

  Future<UserManagementModel?> getAllUser(String token) async {
    try {
      var response = await http.get(
        Uri.parse(
          "http://${StaticBaseUrl.baseUrl}/api/profil",
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
        return UserManagementModel.fromJson(
          jsonDecode(response.body),
        );
      } else {
        print(response.statusCode);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<http.Response?> updateRole(String token, userId, email, role) async {
    try {
      var body = {
        "email": email,
        "role": role,
      };
      var response = await http.put(
        Uri.parse(
          "http://${StaticBaseUrl.baseUrl}/api/user/${userId}",
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

  Future<http.Response?> updateUserProfile(
    String token,
    String profileId,
    String name,
    String address,
    String gender,
    String dateOfBirth,
    String whatsapp,
    String userId,
  ) async {
    try {
      var body = {
        "name": name,
        "address": address,
        "gender": gender,
        "date_of_birth": dateOfBirth,
        "whatsapp": whatsapp,
        "user_id": userId,
      };
      var response = await http.put(
        Uri.parse(
          "http://${StaticBaseUrl.baseUrl}/api/profil/${profileId}",
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
