import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:layang_layang_app/models/submit_aprove_model.dart';
import 'package:layang_layang_app/providers/barang_provider.dart';
import 'package:layang_layang_app/providers/shop_provider.dart';
import 'package:layang_layang_app/providers/toko_provider.dart';
import 'package:layang_layang_app/providers/user_provider.dart';
import 'package:layang_layang_app/ui/pages/splash/splash_screen.dart';
import 'package:layang_layang_app/ui/pages/tranasaksi/transaction_confirm_page.dart';
import 'package:layang_layang_app/ui/widgets/custom_drop_down.dart';
import 'package:layang_layang_app/ui/widgets/custom_text_field.dart';
import 'package:layang_layang_app/ui/widgets/custom_text_field_area.dart';
import 'package:layang_layang_app/ui/widgets/show_snackbar.dart';
import 'package:provider/provider.dart';

import '../../../providers/aproved_provider.dart';

class UpdateBarangPage extends StatefulWidget {
  final BuildContext? context;

  const UpdateBarangPage({Key? key, this.context}) : super(key: key);

  @override
  State<UpdateBarangPage> createState() => _UpdateBarangPageState();
}

class _UpdateBarangPageState extends State<UpdateBarangPage> {
  bool isLoading = false;
  @override
  void initState() {
    isLoading = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var barangProvider = Provider.of<BarangProvider>(context);
    TextEditingController name =
        TextEditingController(text: '${barangProvider.barangUpdate.name}');
    TextEditingController description = TextEditingController(
        text: '${barangProvider.barangUpdate.description}');
    TextEditingController price =
        TextEditingController(text: '${barangProvider.barangUpdate.price}');
    TextEditingController pictureLink = TextEditingController(
        text: '${barangProvider.barangUpdate.pictureLink}');
    AlertDialog alert = AlertDialog(
      title: Text("${barangProvider.barangUpdate.name} akan di update"),
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
            var response = await barangProvider.updateBarang(
                userProvider.user.token.toString(),
                barangProvider.barangUpdate.barangId,
                name.text,
                description.text,
                price.text,
                pictureLink.text);
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
                } else if (errors.containsKey('price')) {
                  String text = "";
                  for (var element in errors["price"]) {
                    text += element + "\n";
                  }
                  GlobalSnackBar.show(context, text);
                } else if (errors.containsKey('picture_link')) {
                  String text = "";
                  for (var element in errors["picture_link"]) {
                    text += element + "\n";
                  }
                  GlobalSnackBar.show(context, text);
                }
                break;
              case 200:
                setState(() {
                  isLoading = false;
                });
                GlobalSnackBar.show(context, "Toko Baru berhasil di update");
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
          title: Text("Update Barang ${barangProvider.barangUpdate.name}"),
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
                          title: "Nama Barang",
                          controller: name,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextFieldArea(
                          title: "Deskripsi",
                          controller: description,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          title: "Price",
                          controller: price,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          title: "Link Gambar",
                          controller: pictureLink,
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
