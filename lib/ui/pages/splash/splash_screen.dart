import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:layang_layang_app/models/user_model.dart';
import 'package:layang_layang_app/providers/user_provider.dart';
import 'package:layang_layang_app/shared/theme.dart';
import 'package:layang_layang_app/ui/widgets/pref.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

String? ress;
UserModel? user;
UserProvider? userProvider;

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({Key? key}) : super(key: key);

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void initState() {
    _countDownStart();
    super.initState();
  }

  void _countDownStart() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      userProvider = Provider.of<UserProvider>(context, listen: false);
    });
    ress = await Pref.getPref();
    if (ress == null) {
      Timer(
        const Duration(seconds: 5),
        () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            "/login",
            (route) => false,
          );
        },
      );
    } else {
      user = UserModel.fromJson(
        jsonDecode(
          ress!,
        ),
      );
      userProvider!.user = user!;
      if (user!.data!.user!.role == "pembeli") {
        Timer(
          const Duration(seconds: 5),
          () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              "/display",
              (route) => false,
            );
          },
        );
      } else if (user!.data!.user!.role == "distributor") {
        Timer(
          const Duration(seconds: 5),
          () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              "/shop",
              (route) => false,
            );
          },
        );
      } else {
        Timer(
          const Duration(seconds: 5),
          () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              "/usermanagement",
              (route) => false,
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                height: 300,
                child: Lottie.asset("assets/json/market.json"),
              ),
              Text(
                'SIPELA',
                style: whiteTextStyle.copyWith(
                  fontSize: 32,
                  fontWeight: medium,
                  letterSpacing: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
