import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:layang_layang_app/models/detail_product_model.dart';
import 'package:layang_layang_app/models/display_model.dart';
import 'package:layang_layang_app/providers/display_provider.dart';
import 'package:layang_layang_app/providers/product_detail_provider.dart';
import 'package:layang_layang_app/providers/product_shop_provider.dart';
import 'package:layang_layang_app/ui/widgets/nav_drawer.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

class DisplayPage extends StatelessWidget {
  const DisplayPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    var displayProvider = Provider.of<DisplayProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    var productShopProvider = Provider.of<ProductShopProvider>(context);
    var productDetailProvider = Provider.of<ProductDetailProvider>(context);
    var token = userProvider.user.token;
    return Scaffold(
      drawer: const NavDrawer(),
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
            height: 200.0,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(25),
              ),
              color: Colors.blue,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 12,
            ),
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
              bottom: 8,
            ),
            child: FutureBuilder<DisplayModel?>(
              future: displayProvider.listDisplay(token!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return GridView.count(
                    crossAxisCount: 2,
                    children: snapshot.data!.data!.map(
                      (e) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/detailproduct");
                            var detail =
                                DetailProductModel.fromJson(e.toJson());
                            print(detail.barangbase?.name);
                            productDetailProvider.detail = detail;
                          },
                          child: Container(
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
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image(
                                      image: NetworkImage(
                                          e.barangbase!.pictureLink!),
                                      height: 100,
                                    ),
                                    Text(
                                      e.barangbase!.name!,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    Text(
                                      e.toko!.name!,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black38,
                                      ),
                                    ),
                                    Text("Rp." +
                                        e.barangbase!.price!.toString()),
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
