import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pref {
  final String user;

  const Pref({
    required this.user,
  });

  static setPref(
    String user,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("user", user);
  }

  static Future<String?> getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? user = pref.getString("user");
    return user;
  }

  static destroy() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("user");
  }
}
