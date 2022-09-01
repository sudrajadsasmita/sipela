import 'package:flutter/material.dart';
import 'package:layang_layang_app/models/detail_product_model.dart';

class ProductDetailProvider with ChangeNotifier {
  DetailProductModel? _detail;

  DetailProductModel get detail => _detail!;
  set detail(DetailProductModel newDetail) {
    _detail = newDetail;
    notifyListeners();
  }
}
