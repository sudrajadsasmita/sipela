import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:layang_layang_app/providers/toko_provider.dart';
import 'package:layang_layang_app/providers/user_provider.dart';
import 'package:layang_layang_app/ui/widgets/custom_drop_down.dart';
import 'package:layang_layang_app/ui/widgets/custom_text_field.dart';
import 'package:layang_layang_app/ui/widgets/show_snackbar.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_text_field_area.dart';

class UpdateUserRolePage extends StatefulWidget {
  const UpdateUserRolePage({Key? key}) : super(key: key);

  @override
  State<UpdateUserRolePage> createState() => _UpdateUserRolePageState();
}

class _UpdateUserRolePageState extends State<UpdateUserRolePage> {
  TextEditingController name = TextEditingController(text: '');
  List<String> dropDownRole = [
    "",
    "pembeli",
    "distributor",
  ];
  String? selectedItem = "";
  bool isLoading = false;
  @override
  void initState() {
    isLoading = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    AlertDialog alert = AlertDialog(
      title: Text("Role user akan di update"),
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
            var response = await userProvider.updateRole(
              userProvider.user.token.toString(),
              userProvider.userManagement.userId,
              userProvider.userManagement.email,
              selectedItem == "" || selectedItem == null
                  ? userProvider.userManagement.role
                  : selectedItem,
            );

            if (response!.statusCode == 200) {
              setState(() {
                isLoading = false;
              });
              Navigator.pop(context);
              GlobalSnackBar.show(context, "Role berhasil di rubah");
            } else {
              GlobalSnackBar.show(context, "Terjadi kesalahan inputan");
            }
          },
        ),
      ],
    );

    return WillPopScope(
      onWillPop: () async => isLoading ? false : true,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Update Role User"),
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
                  'Ubah Role',
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
                        Image(
                          image: AssetImage("assets/images/user.png"),
                          width: 250,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "${userProvider.userManagement.email}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomDropDown(
                          title: "Role",
                          list: this.dropDownRole,
                          onChange: (p0) {
                            setState(() {
                              selectedItem = p0;
                            });
                          },
                          icon: Icon(Icons.key),
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
