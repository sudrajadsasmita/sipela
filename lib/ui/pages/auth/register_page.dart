import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:layang_layang_app/models/auth_model.dart';
import 'package:layang_layang_app/models/user_model.dart';
import 'package:layang_layang_app/providers/user_provider.dart';
import 'package:layang_layang_app/shared/theme.dart';
import 'package:layang_layang_app/ui/widgets/custom_date_birth.dart';
import 'package:layang_layang_app/ui/widgets/custom_text_field.dart';
import 'package:layang_layang_app/ui/widgets/custom_text_field_area.dart';
import 'package:layang_layang_app/ui/widgets/custom_drop_down.dart';
import 'package:layang_layang_app/ui/widgets/pref.dart';
import 'package:layang_layang_app/ui/widgets/show_snackbar.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController dateInput = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();
  String? selectedItem = "";
  List<String> gender = [
    "",
    "Laki - Laki",
    "Perempuan",
  ];
  bool isLoading = false;

  @override
  void initState() {
    dateInput.text = "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    Widget header() {
      return Container(
        // margin: const EdgeInsets.only(top: 30),
        child: Text(
          "Register\nMenjadi salah satu pengguna",
          style: blackTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 28,
          ),
          textAlign: TextAlign.left,
        ),
      );
    }

    void _formValidation(dynamic errors, String key) async {
      setState(() {
        isLoading = false;
      });
      String text = "";
      for (var element in errors[key]) {
        text += element + '\n';
      }
      GlobalSnackBar.show(context, text);
    }

    Widget email() {
      return Container(
        child: CustomTextField(
          controller: emailController,
          title: "Email",
          hint: "Ketikkan email anda",
          onChange: (value) {
            setState(() {});
          },
          margin: EdgeInsets.only(bottom: 20),
          icon: Icon(Icons.email),
        ),
      );
    }

    Widget password() {
      return Container(
        child: CustomTextField(
          controller: passwordController,
          title: "Password",
          hint: "Ketikkan password anda",
          obscure: true,
          onChange: (value) {
            setState(() {});
          },
          margin: EdgeInsets.only(bottom: 20),
          icon: Icon(Icons.password),
        ),
      );
    }

    Widget passwordConfirm() {
      return Container(
        child: CustomTextField(
          controller: passwordConfirmationController,
          title: "Konfirmasi Password",
          hint: "Ketikkan kembali password anda",
          obscure: true,
          onChange: (value) {
            setState(() {});
          },
          margin: EdgeInsets.only(bottom: 20),
          icon: Icon(Icons.password),
        ),
      );
    }

    Widget name() {
      return Container(
        child: CustomTextField(
          controller: nameController,
          title: "Nama",
          hint: "Ketikkan nama anda",
          onChange: (value) {
            setState(() {});
          },
          margin: EdgeInsets.only(bottom: 20),
          icon: Icon(Icons.person),
        ),
      );
    }

    Widget address() {
      return Container(
        child: CustomTextFieldArea(
          controller: addressController,
          title: "Alamat",
          hint: "Ketikkan alamat anda",
          onChange: (value) {
            setState(() {});
          },
          margin: EdgeInsets.only(bottom: 20),
          icon: Icon(Icons.map),
        ),
      );
    }

    Widget gender() {
      return CustomDropDown(
        title: "gender",
        icon: Icon(Icons.no_adult_content),
        margin: EdgeInsets.only(bottom: 20),
        list: this.gender,
        onChange: (p0) {
          setState(() {
            selectedItem = p0;
          });
        },
      );
    }

    Widget whatsapp() {
      return Container(
        child: CustomTextField(
          controller: whatsappController,
          title: "Whatsapp",
          hint: "Ketikkan nomor Whatsapp anda",
          onChange: (value) {
            setState(() {});
          },
          margin: EdgeInsets.only(bottom: 20, top: 20),
          icon: Icon(Icons.person),
        ),
      );
    }

    Widget dateBirth() {
      return CustomDateBirth(
        dateInput: dateInput,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(
                  2000), //DateTime.now() - not to allow to choose before today.
              lastDate: DateTime(2101));

          if (pickedDate != null) {
            print(pickedDate);
            //pickedDate output format => 2021-03-10 00:00:00.000
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
            print(formattedDate);
            //formatted date output using intl package =>  2021-03-16
            //you can implement different kind of Date Format here according to your requirement

            setState(() {
              dateInput.text = formattedDate;
              //set output date to TextField value.
              // GlobalSnackBar.show(context, dateInput.text);
              print(dateInput.text);
            });
          } else {
            print("Date is not selected");
          }
        },
      );
    }

    Widget submitButton() {
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.only(left: 20, right: 20),
        width: MediaQuery.of(context).size.width,
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : FloatingActionButton.extended(
                foregroundColor: Colors.white,
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  var register = await authProvider.register(
                      emailController.text,
                      passwordController.text,
                      passwordConfirmationController.text,
                      nameController.text,
                      addressController.text,
                      selectedItem,
                      dateInput.text,
                      whatsappController.text);
                  var response = jsonDecode(register!.body);
                  var errors = response["errors"];
                  if (register.statusCode == 400) {
                    if (errors.containsKey("email")) {
                      _formValidation(errors, "email");
                    } else if (errors.containsKey("password")) {
                      _formValidation(errors, 'password');
                    } else if (errors.containsKey("name")) {
                      _formValidation(errors, 'name');
                    } else if (errors.containsKey("address")) {
                      _formValidation(errors, 'address');
                    } else if (errors.containsKey("gender")) {
                      _formValidation(errors, 'gender');
                    } else if (errors.containsKey("date_of_birth")) {
                      _formValidation(errors, 'date_of_birth');
                    } else if (errors.containsKey("whatsapp")) {
                      _formValidation(errors, 'whatsapp');
                    } else {
                      GlobalSnackBar.show(context, "Your system is error");
                    }
                  } else if (register.statusCode == 201) {
                    userProvider.user = UserModel.fromJson(response!);
                    Pref.setPref(register.body);
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      "/display",
                      (route) => false,
                    );
                  }
                },
                icon: Icon(Icons.save_as),
                label: Text('Register'),
              ),
      );
    }

    return Scaffold(
      bottomSheet: submitButton(),
      body: SafeArea(
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(
              left: defaultMargin,
              right: defaultMargin,
              bottom: defaultMargin,
              top: 12,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  header(),
                  const SizedBox(
                    height: 20,
                  ),
                  email(),
                  password(),
                  passwordConfirm(),
                  name(),
                  address(),
                  gender(),
                  dateBirth(),
                  whatsapp(),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
