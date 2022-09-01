import 'package:flutter/material.dart';
import 'package:layang_layang_app/models/user_model.dart';
import 'package:layang_layang_app/providers/auth_provider.dart';
import 'package:layang_layang_app/providers/user_provider.dart';
import 'package:layang_layang_app/shared/theme.dart';
import 'package:layang_layang_app/ui/widgets/pref.dart';
import 'package:provider/provider.dart';

import '../../widgets/show_snackbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sign In',
              style: greyTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              'Login Pengguna',
              style: blackTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
          ],
        ),
      );
    }

    Widget illustration() {
      return Container(
        margin: EdgeInsets.only(top: 40),
        child: Center(
            child: Image(
          image: AssetImage("assets/images/image_sign_in.png"),
          width: 230,
        )),
      );
    }

    Widget inputEmail() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email Address',
              style: greyTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              width: double.infinity,
              height: 45,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: inputFieldColor,
              ),
              child: Center(
                child: TextFormField(
                  controller: emailController,
                  cursorColor: primaryColor,
                  onChanged: (value) {
                    setState(() {});
                  },
                  style: purpleTextStyle.copyWith(),
                  decoration: InputDecoration.collapsed(
                    hintText: '',
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget inputPassword() {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password',
              style: greyTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              width: double.infinity,
              height: 45,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: inputFieldColor,
              ),
              child: Center(
                child: TextFormField(
                  controller: passwordController,
                  cursorColor: primaryColor,
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {});
                  },
                  style: purpleTextStyle.copyWith(),
                  decoration: InputDecoration.collapsed(
                    hintText: '',
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget signInButton() {
      return Container(
        height: 45,
        width: double.infinity,
        margin: EdgeInsets.only(top: 40),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : TextButton(
                onPressed: () async {
                  if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    GlobalSnackBar.show(
                        context, "Field email dan password tidak boleh kosong");
                    print("kosong");
                  } else {
                    setState(() {
                      isLoading = true;
                    });
                    print("bablas");
                    UserModel? login = await authProvider.login(
                        emailController.text, passwordController.text);
                    userProvider.user = login!;
                    Pref.setPref(login.token!);
                    if (login.data?.user?.role == "pembeli") {
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        "/display",
                        (route) => false,
                      );
                    } else if (login.data?.user?.role == "distributor") {
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        "/requestitempage",
                        (route) => false,
                      );
                    } else {
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        "/display",
                        (route) => false,
                      );
                    }
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(66),
                  ),
                ),
                child: Text(
                  'Sign In',
                  style: whiteTextStyle.copyWith(
                    fontWeight: medium,
                  ),
                ),
              ),
      );
    }

    Widget signUpButton() {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
          bottom: 20,
        ),
        child: Center(
          child: TextButton(
            onPressed: () async {
              Navigator.pushNamed(context, '/register');
            },
            child: Text(
              'Create New Account',
              style: greyTextStyle.copyWith(
                fontWeight: light,
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header(),
                illustration(),
                inputEmail(),
                inputPassword(),
                signInButton(),
                signUpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
