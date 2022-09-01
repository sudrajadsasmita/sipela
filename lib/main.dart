import 'package:flutter/material.dart';
import 'package:layang_layang_app/providers/aproved_provider.dart';
import 'package:layang_layang_app/providers/auth_provider.dart';
import 'package:layang_layang_app/providers/display_provider.dart';
import 'package:layang_layang_app/providers/product_detail_provider.dart';
import 'package:layang_layang_app/providers/product_shop_provider.dart';
import 'package:layang_layang_app/providers/shop_provider.dart';
import 'package:layang_layang_app/providers/toko_detail_provider.dart';
import 'package:layang_layang_app/providers/toko_provider.dart';
import 'package:layang_layang_app/providers/transaction_provider.dart';
import 'package:layang_layang_app/providers/user_provider.dart';
import 'package:layang_layang_app/ui/pages/auth/login_page.dart';
import 'package:layang_layang_app/ui/pages/auth/register_page.dart';
import 'package:layang_layang_app/ui/pages/shop/detail_product_page.dart';
import 'package:layang_layang_app/ui/pages/shop/request_item_page.dart';
import 'package:layang_layang_app/ui/pages/shop/shop_page.dart';
import 'package:layang_layang_app/ui/pages/shop/display_page.dart';
import 'package:layang_layang_app/ui/pages/splash/splash_screen.dart';
import 'package:layang_layang_app/ui/pages/tranasaksi/toko_page.dart';

import 'package:layang_layang_app/ui/pages/tranasaksi/transaction_confirm_page.dart';
import 'package:layang_layang_app/ui/pages/tranasaksi/update_transaction_status_page.dart';
import 'package:layang_layang_app/ui/widgets/pref.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DisplayProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductShopProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductDetailProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AprovedProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TokoProider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TokoDetailProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ShopProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (context) => const SpalshScreen(),
          "/login": (context) => const LoginPage(),
          "/register": (context) => const RegisterPage(),
          "/shop": (context) => const ShopPage(title: "Daftar Distributor"),
          "/display": (context) => const DisplayPage(title: "SIPELA"),
          "/detailproduct": (context) => const DetailProductPage(),
          "/transactionconfirm": (context) =>
              const TransactionConfirmPage(title: "List Transaksi"),
          "/requestitempage": (context) =>
              const RequestItemPage(title: "List Barang"),
          "/updatetransaction": (context) => const UpdateTransactionStatus(),
          "/toko": (context) => const TokoPage(),
        },
      ),
    );
  }
}
