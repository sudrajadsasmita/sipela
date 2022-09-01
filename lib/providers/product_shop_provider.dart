import 'package:flutter/material.dart';
import 'package:layang_layang_app/models/display_model.dart';

import '../models/user_model.dart';

class ProductShopProvider with ChangeNotifier {
  DisplayModel? _display;

  DisplayModel get display => _display!;

  set setdisplay(DisplayModel newDisplay) {
    _display = newDisplay;
    notifyListeners();
  }
}
