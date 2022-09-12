import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:layang_layang_app/providers/barang_provider.dart';
import 'package:layang_layang_app/providers/user_provider.dart';
import 'package:layang_layang_app/ui/pages/splash/splash_screen.dart';
import 'package:layang_layang_app/ui/widgets/custom_date_birth.dart';
import 'package:layang_layang_app/ui/widgets/custom_drop_down.dart';
import 'package:layang_layang_app/ui/widgets/custom_text_field.dart';
import 'package:layang_layang_app/ui/widgets/custom_text_field_area.dart';
import 'package:layang_layang_app/ui/widgets/show_snackbar.dart';
import 'package:provider/provider.dart';

class UpdateUserProfilePage extends StatefulWidget {
  const UpdateUserProfilePage({Key? key}) : super(key: key);

  @override
  State<UpdateUserProfilePage> createState() => _UpdateUserProfilePageState();
}

class _UpdateUserProfilePageState extends State<UpdateUserProfilePage> {
  bool isLoading = false;
  String? selectedItem = "";
  List<String> gender = [
    "",
    "Laki - Laki",
    "Perempuan",
  ];
  TextEditingController name = TextEditingController(text: '');
  TextEditingController address = TextEditingController(text: '');

  TextEditingController dateInput = TextEditingController(text: '');
  TextEditingController whatsapp = TextEditingController(text: '');
  @override
  void initState() {
    isLoading = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

    AlertDialog alert = AlertDialog(
      title:
          Text("${userProvider.user.data!.user!.profil!.name} akan di update"),
      content: Text("Apa anda yakin?"),
      actions: [
        TextButton(
          child: Text("Cancel"),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text("Continue"),
          onPressed: () async {
            setState(() {
              isLoading = true;
            });
            Navigator.pop(context);
            var response = await userProvider.updateUserProfile(
              userProvider.user.token.toString(),
              userProvider.user.data!.user!.profil!.id.toString(),
              (name.text == "" || name.text == null
                  ? userProvider.user.data!.user!.profil!.name
                  : name.text)!,
              (address.text == "" || address.text == null
                  ? userProvider.user.data!.user!.profil!.address
                  : address.text)!,
              (selectedItem == "" || selectedItem == null
                  ? userProvider.user.data!.user!.profil!.gender
                  : selectedItem)!,
              (dateInput.text == "" || dateInput.text == null
                  ? userProvider.user.data!.user!.profil!.dateOfBirth
                  : dateInput.text)!,
              (whatsapp.text == "" || whatsapp.text == null
                  ? userProvider.user.data!.user!.profil!.whatsapp
                  : whatsapp.text)!,
              userProvider.user.data!.user!.id.toString(),
            );
            var save = jsonDecode(response!.body);
            var errors = save["errors"];
            switch (response.statusCode) {
              case 422:
                setState(() {
                  isLoading = false;
                });
                if (errors.containsKey('name')) {
                  String text = "";
                  for (var element in errors["name"]) {
                    text += element + "\n";
                  }
                  GlobalSnackBar.show(context, text);
                } else if (errors.containsKey('address')) {
                  String text = "";
                  for (var element in errors["address"]) {
                    text += element + "\n";
                  }
                  GlobalSnackBar.show(context, text);
                } else if (errors.containsKey('gender')) {
                  String text = "";
                  for (var element in errors["gender"]) {
                    text += element + "\n";
                  }
                  GlobalSnackBar.show(context, text);
                } else if (errors.containsKey('date_of_birth')) {
                  String text = "";
                  for (var element in errors["date_of_birth"]) {
                    text += element + "\n";
                  }
                  GlobalSnackBar.show(context, text);
                } else if (errors.containsKey('whatsapp')) {
                  String text = "";
                  for (var element in errors["whatsapp"]) {
                    text += element + "\n";
                  }
                  GlobalSnackBar.show(context, text);
                }
                break;
              case 200:
                setState(() {
                  isLoading = false;
                });
                GlobalSnackBar.show(context, "Profil berhasil di update");
                Navigator.pop(context);
                break;
              default:
                setState(() {
                  isLoading = false;
                });
                GlobalSnackBar.show(context, "Your system is broken");
            }
          },
        ),
      ],
    );

    return WillPopScope(
      onWillPop: () async => isLoading ? false : true,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              "Update data user ${userProvider.user.data!.user!.profil!.name}"),
        ),
        bottomSheet: IgnorePointer(
          ignoring: isLoading ? true : false,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                },
                child: Text(
                  'Update',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(66),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: IgnorePointer(
            ignoring: isLoading ? true : false,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomTextField(
                          title: "Nama",
                          controller: name,
                          icon: Icon(Icons.abc),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextFieldArea(
                          title: "Alamat",
                          controller: address,
                          icon: Icon(Icons.map),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomDropDown(
                          title: "Gender",
                          list: gender,
                          onChange: (p0) {
                            selectedItem = p0;
                          },
                          icon: Icon(
                            Icons.male,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomDateBirth(
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
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
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
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          title: "WhatsApp",
                          controller: whatsapp,
                          icon: Icon(Icons.whatsapp),
                        ),
                      ],
                    ),
                  ),
                ),
                isLoading
                    ? const Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 40,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
