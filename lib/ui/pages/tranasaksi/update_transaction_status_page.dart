import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:layang_layang_app/models/submit_aprove_model.dart';
import 'package:layang_layang_app/providers/user_provider.dart';
import 'package:layang_layang_app/ui/pages/tranasaksi/transaction_confirm_page.dart';
import 'package:layang_layang_app/ui/widgets/custom_drop_down.dart';
import 'package:layang_layang_app/ui/widgets/show_snackbar.dart';
import 'package:provider/provider.dart';

import '../../../providers/aproved_provider.dart';

class UpdateTransactionStatus extends StatefulWidget {
  final BuildContext? context;

  const UpdateTransactionStatus({Key? key, this.context}) : super(key: key);

  @override
  State<UpdateTransactionStatus> createState() =>
      _UpdateTransactionStatusState();
}

class _UpdateTransactionStatusState extends State<UpdateTransactionStatus> {
  bool isLoading = false;
  String selectedItemTransactionStatus = "";
  String selectedItemDeliverStatus = "pending";
  List<String> transactionStatus = [
    "pending",
    "approved",
    "canceled",
    "rejected",
    "waiting payment",
  ];
  List<String> deliverStatus = [
    "pending",
    "delivered",
    "sent",
  ];
  @override
  void initState() {
    isLoading = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var aproveProvider = Provider.of<AprovedProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    Widget selectTransactionStatus() {
      return CustomDropDown(
        title: "Status Transaksi",
        list: transactionStatus,
        icon: Icon(Icons.money),
        margin: EdgeInsets.only(bottom: 20),
        onChange: (p0) {
          setState(() {
            selectedItemTransactionStatus = p0.toString();
          });
        },
      );
    }

    Widget selectedDeliverStatus() {
      return CustomDropDown(
        title: "Status Pengiriman",
        list: deliverStatus,
        icon: Icon(Icons.delivery_dining),
        onChange: (p0) {
          setState(() {
            selectedItemDeliverStatus = p0.toString();
          });
        },
      );
    }

    AlertDialog alert = AlertDialog(
      title: Text("status ${aproveProvider.aprove.namaBarang} akan di ubah"),
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
            SubmitAproveModel? submit =
                await aproveProvider.updateTransactionStatus(
              userProvider.user.token,
              aproveProvider.aprove.transactionId,
              selectedItemTransactionStatus == ""
                  ? aproveProvider.aprove.statusTransaksi!
                  : selectedItemTransactionStatus,
              selectedItemDeliverStatus == ""
                  ? aproveProvider.aprove.statusPengiriman
                  : selectedItemDeliverStatus,
            );
            setState(() {
              isLoading = false;
            });
            GlobalSnackBar.show(context, "Data Transaksi berhasil di update");
            Navigator.pop(context);
          },
        ),
      ],
    );

    return WillPopScope(
      onWillPop: () async => isLoading ? false : true,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Updata Status Transaksi"),
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
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nama Barang : ",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Email Pemesan : ",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${aproveProvider.aprove.namaBarang}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "${aproveProvider.aprove.emailUser}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      selectTransactionStatus(),
                      selectedDeliverStatus()
                    ],
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
