import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:layang_layang_app/models/user_model.dart';
import 'package:layang_layang_app/providers/aproved_provider.dart';
import 'package:layang_layang_app/providers/auth_provider.dart';
import 'package:layang_layang_app/providers/barang_provider.dart';
import 'package:layang_layang_app/providers/display_provider.dart';
import 'package:layang_layang_app/providers/product_detail_provider.dart';
import 'package:layang_layang_app/providers/request_provider.dart';
import 'package:layang_layang_app/providers/shop_provider.dart';
import 'package:layang_layang_app/providers/toko_detail_provider.dart';
import 'package:layang_layang_app/providers/toko_provider.dart';
import 'package:layang_layang_app/providers/transaction_provider.dart';
import 'package:layang_layang_app/providers/user_provider.dart';
import 'package:layang_layang_app/ui/pages/auth/login_page.dart';
import 'package:layang_layang_app/ui/pages/auth/register_page.dart';
import 'package:layang_layang_app/ui/pages/barang/barang_page.dart';
import 'package:layang_layang_app/ui/pages/barang/create_barang_page.dart';
import 'package:layang_layang_app/ui/pages/barang/update_barang_page.dart';
import 'package:layang_layang_app/ui/pages/request/request_barang_page.dart';
import 'package:layang_layang_app/ui/pages/request/update_request_barang_page.dart';
import 'package:layang_layang_app/ui/pages/shop/create_shop_page.dart';
import 'package:layang_layang_app/ui/pages/shop/detail_product_page.dart';
import 'package:layang_layang_app/ui/pages/shop/report_toko_page.dart';
import 'package:layang_layang_app/ui/pages/shop/request_item_page.dart';
import 'package:layang_layang_app/ui/pages/shop/shop_page.dart';
import 'package:layang_layang_app/ui/pages/shop/display_page.dart';
import 'package:layang_layang_app/ui/pages/splash/splash_screen.dart';
import 'package:layang_layang_app/ui/pages/tranasaksi/toko_page.dart';
import 'package:layang_layang_app/ui/pages/tranasaksi/transaction_confirm_page.dart';
import 'package:layang_layang_app/ui/pages/tranasaksi/update_transaction_status_page.dart';
import 'package:layang_layang_app/ui/pages/user/update_user_profile_page.dart';
import 'package:layang_layang_app/ui/pages/user/update_user_role_page.dart';
import 'package:layang_layang_app/ui/pages/user/user_management_page.dart';
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
          create: (context) => ProductDetailProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AprovedProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TokoProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TokoDetailProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ShopProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RequestProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BarangProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (context) => const SpalshScreen(),
          "/login": (context) => const LoginPage(),
          "/register": (context) => const RegisterPage(),
          "/shop": (context) => const ShopPage(title: "Daftar Toko"),
          "/display": (context) => const DisplayPage(title: "SIPELA"),
          "/detailproduct": (context) => const DetailProductPage(),
          "/transactionconfirm": (context) =>
              const TransactionConfirmPage(title: "List Transaksi"),
          "/requestitempage": (context) =>
              const RequestItemPage(title: "List Request Barang"),
          "/updatetransaction": (context) => const UpdateTransactionStatus(),
          "/toko": (context) => const TokoPage(),
          "/reporttoko": (context) => const ReportTokoPage(),
          "/createshop": (context) => const CreateShopPage(),
          "/usermanagement": (context) => const UserManagementPage(),
          "/updateuserrolepage": (context) => const UpdateUserRolePage(),
          "/requestbarangpage": (context) => const RequestBarangPage(),
          "/updaterequestbarangpage": (context) =>
              const UpdateRequestBarangPage(),
          "/barangpage": (context) => const BarangPage(
                title: 'List Barang',
              ),
          "/createbarangpage": (context) => const CreateBarangPage(),
          "/updatebarangpage": (context) => const UpdateBarangPage(),
          "/updateuserprofilepage": (context) => const UpdateUserProfilePage(),
        },
      ),
    );
  }
}
