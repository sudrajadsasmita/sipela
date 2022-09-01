import 'package:flutter/material.dart';
import 'package:layang_layang_app/models/shop_model.dart';
import 'package:layang_layang_app/providers/shop_provider.dart';
import 'package:layang_layang_app/ui/widgets/nav_drawer.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var shopProvider = Provider.of<ShopProvider>(context);

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
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(25),
                ),
                color: Colors.blue),
          ),
          Container(
            child: FutureBuilder<ShopModel?>(
              future: shopProvider.listToko(userProvider.user.token!,
                  userProvider.user.data!.user!.id.toString()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView(
                    children: snapshot.data!.data!.map((e) {
                      return InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Tiaraa"),
                            ),
                          );
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image(
                                    image:
                                        AssetImage("assets/images/store.png"),
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
                                        "${e.barangbase!.name}",
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
                                        "${e.barangbase!.description}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black38,
                                        ),
                                      ),
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
