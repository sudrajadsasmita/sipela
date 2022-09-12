import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:layang_layang_app/models/submit_aprove_model.dart';
import 'package:layang_layang_app/providers/shop_provider.dart';
import 'package:layang_layang_app/providers/toko_provider.dart';
import 'package:layang_layang_app/providers/user_provider.dart';
import 'package:layang_layang_app/ui/pages/tranasaksi/transaction_confirm_page.dart';
import 'package:layang_layang_app/ui/widgets/custom_drop_down.dart';
import 'package:layang_layang_app/ui/widgets/custom_text_field.dart';
import 'package:layang_layang_app/ui/widgets/custom_text_field_area.dart';
import 'package:layang_layang_app/ui/widgets/show_snackbar.dart';
import 'package:provider/provider.dart';

import '../../../providers/aproved_provider.dart';

class CreateShopPage extends StatefulWidget {
  final BuildContext? context;

  const CreateShopPage({Key? key, this.context}) : super(key: key);

  @override
  State<CreateShopPage> createState() => _CreateShopPageState();
}

class _CreateShopPageState extends State<CreateShopPage> {
  TextEditingController name = TextEditingController(text: '');
  TextEditingController description = TextEditingController(text: '');
  bool isLoading = false;
  @override
  void initState() {
    isLoading = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var tokoProvider = Provider.of<TokoProvider>(context);
    AlertDialog alert = AlertDialog(
      title: Text("Toko baru akan di tambahkan"),
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
            var response = await tokoProvider.createToko(
              userProvider.user.token.toString(),
              name.text,
              description.text,
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
                } else if (errors.containsKey('description')) {
                  String text = "";
                  for (var element in errors["description"]) {
                    text += element + "\n";
                  }
                  GlobalSnackBar.show(context, text);
                }
                break;
              case 201:
                setState(() {
                  isLoading = false;
                });
                GlobalSnackBar.show(context, "Toko Baru berhasil di tambahkan");
                Navigator.pop(context);
                break;
              default:
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
          title: Text("Tambahkan Toko Baru"),
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
                  'Tambah',
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
                          image: AssetImage("assets/images/store.png"),
                          width: 250,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          title: "Nama Toko",
                          controller: name,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextFieldArea(
                          title: "Deskripsi",
                          controller: description,
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
