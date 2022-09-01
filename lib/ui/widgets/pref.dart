import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pref {
  final String token;

  const Pref({
    required this.token,
  });

  static setPref(
    String token,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("token", token);
  }

  static getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  }

  static destroy() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("token");
  }
}
