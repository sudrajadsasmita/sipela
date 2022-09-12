import 'package:flutter/material.dart';
import 'package:layang_layang_app/models/barang_model.dart';
import 'package:layang_layang_app/models/barang_update_model.dart';
import 'package:layang_layang_app/models/shop_model.dart';
import 'package:layang_layang_app/models/toko_model.dart';
import 'package:layang_layang_app/models/toko_update_model.dart';
import 'package:layang_layang_app/providers/barang_provider.dart';
import 'package:layang_layang_app/providers/shop_provider.dart';
import 'package:layang_layang_app/providers/toko_provider.dart';
import 'package:layang_layang_app/ui/widgets/nav_drawer.dart';
import 'package:layang_layang_app/ui/widgets/show_snackbar.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

class BarangPage extends StatefulWidget {
  const BarangPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<BarangPage> createState() => _BarangPageState();
}

class _BarangPageState extends State<BarangPage> {
  late Future<BarangModel?> _initData;
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var barangProvider = Provider.of<BarangProvider>(context);
    _initData = barangProvider.getAllBarang(userProvider.user.token.toString());
    return Scaffold(
      drawer: const NavDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pushNamed(
            context,
            '/createbarangpage',
          ).then((_) => setState(() {}));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: InkWell(
              child: const Icon(Icons.person),
              onTap: () async {
                Navigator.pushNamed(context, '/updateuserprofilepage')
                    .then((_) => setState(() {}));
              },
            ),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: 100,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(25),
                ),
                color: Colors.blue),
          ),
          Container(
            child: FutureBuilder<BarangModel?>(
              future: _initData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView(
                    children: snapshot.data!.data!.map((e) {
                      return InkWell(
                        onTap: () async {
                          barangProvider.barangUpdate = BarangUpdateModel(
                            barangId: e.id.toString(),
                            name: e.name,
                            description: e.description,
                            price: e.price.toString(),
                            pictureLink: e.pictureLink,
                          );
                          Navigator.pushNamed(
                            context,
                            '/updatebarangpage',
                          ).then((_) => setState(() {}));
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(12, 2, 12, 2),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Card(
                            elevation: 16,
                            shadowColor: Colors.black,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image(
                                    image: NetworkImage("${e.pictureLink}"),
                                    height: 100,
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${e.name}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 40,
                                        ),
                                        Text(
                                          "${e.description}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black38,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      IconButton(
                                        onPressed: () async {
                                          var result = await showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text(
                                                  "Toko ${e.name} akan di hapus"),
                                              content: Text("Apa anda yakin?"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                      context,
                                                      false,
                                                    );
                                                  },
                                                  child: Text("Cancel"),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    var response =
                                                        await barangProvider
                                                            .deleteBarang(
                                                      userProvider.user.token
                                                          .toString(),
                                                      e.id.toString(),
                                                    );
                                                    Navigator.pop(
                                                      context,
                                                      true,
                                                    );
                                                  },
                                                  child: Text("Delete"),
                                                ),
                                              ],
                                            ),
                                          );
                                          if (result) {
                                            setState(() {
                                              _initData;
                                            });
                                          }
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.blue,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
