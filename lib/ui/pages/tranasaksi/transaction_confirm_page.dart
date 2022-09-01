import 'package:flutter/material.dart';
import 'package:layang_layang_app/models/aproved_model.dart';
import 'package:layang_layang_app/models/transaction_model.dart';
import 'package:layang_layang_app/providers/aproved_provider.dart';
import 'package:layang_layang_app/providers/toko_detail_provider.dart';
import 'package:layang_layang_app/providers/transaction_provider.dart';
import 'package:layang_layang_app/ui/widgets/nav_drawer.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

class TransactionConfirmPage extends StatelessWidget {
  const TransactionConfirmPage({Key? key, required this.title})
      : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var transationProvider = Provider.of<TransactionProvider>(context);
    var aproveProvider = Provider.of<AprovedProvider>(context);
    var tokoDetailProvider = Provider.of<TokoDetailProvider>(context);
    return Scaffold(
      drawer: userProvider.user.data!.user!.role == "distributor"
          ? null
          : NavDrawer(),
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: InkWell(
              child: const Icon(Icons.settings),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Settings')),
                );
              },
            ),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(color: Colors.blue),
          ),
          Container(
            child: FutureBuilder<TransactionModel?>(
              future: userProvider.user.data!.user!.role == "pembeli"
                  ? transationProvider.listTransactionByUser(
                      userProvider.user.token.toString(),
                      userProvider.user.data!.user!.id.toString(),
                    )
                  : transationProvider.listTransactionByToko(
                      userProvider.user.token.toString(),
                      tokoDetailProvider.tokoId.toString()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView(
                    children: snapshot.data!.data!.map(
                      (e) {
                        return InkWell(
                          onTap: () async {
                            userProvider.user.data!.user!.role == "distributor"
                                ? aproveProvider.aprove = AprovedModel(
                                    userId: e.cutomer!.id.toString(),
                                    namaBarang:
                                        e.transactiondetails!.barangbase!.name,
                                    emailUser: e.cutomer!.email,
                                    statusPengiriman: e.statusPengiriman,
                                    statusTransaksi: e.statusTransaksi,
                                    transactionId: e.id.toString())
                                : null;
                            userProvider.user.data!.user!.role == "distributor"
                                ? Navigator.pushNamed(
                                    context, "/updatetransaction")
                                : null;
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(12, 2, 12, 2),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Card(
                              elevation: 16,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              shadowColor: Colors.black,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image(
                                      image: NetworkImage(
                                        e.transactiondetails!.barangbase!
                                            .pictureLink!,
                                      ),
                                      width: 100,
                                      height: 100,
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${e.transactiondetails!.barangbase!.name!}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Text(
                                          userProvider.user.data!.user!.role ==
                                                  "pembeli"
                                              ? "${e.transactiondetails!.toko!.name!}"
                                              : "${e.cutomer!.email}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black38,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Rp. ${e.transactiondetails!.subtotal}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black38,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              "Jumlah: ${e.transactiondetails!.quantity}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black38,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Transaksi : ",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black38,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    width: 1,
                                                    color: Colors.blue,
                                                    style: BorderStyle.solid,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.blue),
                                              child: Text(
                                                "${e.statusTransaksi!}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Pengiriman : ",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black38,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    width: 1,
                                                    color: Colors.blue,
                                                    style: BorderStyle.solid,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.blue),
                                              child: Text(
                                                "${e.statusPengiriman!}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
