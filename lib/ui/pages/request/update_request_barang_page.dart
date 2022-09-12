import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:layang_layang_app/providers/request_provider.dart';
import 'package:layang_layang_app/providers/toko_provider.dart';
import 'package:layang_layang_app/providers/user_provider.dart';
import 'package:layang_layang_app/ui/widgets/custom_drop_down.dart';
import 'package:layang_layang_app/ui/widgets/custom_text_field.dart';
import 'package:layang_layang_app/ui/widgets/show_snackbar.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_text_field_area.dart';

class UpdateRequestBarangPage extends StatefulWidget {
  const UpdateRequestBarangPage({Key? key}) : super(key: key);

  @override
  State<UpdateRequestBarangPage> createState() =>
      _UpdateRequestBarangPageState();
}

class _UpdateRequestBarangPageState extends State<UpdateRequestBarangPage> {
  TextEditingController stok = TextEditingController(text: '0');
  List<String> dropDownRole = [
    "",
    "pending",
    "approved",
    "canceled",
    "rejected",
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
    var requestProvider = Provider.of<RequestProvider>(context);
    AlertDialog alert = AlertDialog(
      title: Text("Request akan di update"),
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
            var response = await requestProvider.updateStatus(
              userProvider.user.token.toString(),
              requestProvider.requestUpdate.requestId,
              requestProvider.requestUpdate.barangbaseId,
              requestProvider.requestUpdate.requestFrom,
              selectedItem == "" || selectedItem == null
                  ? userProvider.userManagement.role
                  : selectedItem,
              stok.text,
            );

            if (response!.statusCode == 200) {
              setState(() {
                isLoading = false;
              });
              Navigator.pop(context);
              GlobalSnackBar.show(context, "Status berhasil di rubah");
            } else {
              setState(() {
                isLoading = false;
              });
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
          title: Text("Request ${requestProvider.requestUpdate.name}"),
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
                  'Ubah Status',
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
                          image: NetworkImage(
                              "${requestProvider.requestUpdate.imgUrl}"),
                          width: 250,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomDropDown(
                          title: "Status",
                          list: this.dropDownRole,
                          onChange: (p0) {
                            setState(() {
                              selectedItem = p0;
                            });
                          },
                          icon: Icon(Icons.key),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          title: "Stock",
                          controller: stok,
                          icon: Icon(Icons.numbers),
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
