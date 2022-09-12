import 'package:flutter/material.dart';
import 'package:layang_layang_app/models/shop_model.dart';
import 'package:layang_layang_app/providers/shop_provider.dart';
import 'package:layang_layang_app/providers/user_provider.dart';
import 'package:layang_layang_app/ui/widgets/nav_drawer.dart';
import 'package:layang_layang_app/ui/widgets/show_snackbar.dart';
import 'package:provider/provider.dart';

class RequestItemPage extends StatefulWidget {
  const RequestItemPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<RequestItemPage> createState() => _RequestItemPageState();
}

class _RequestItemPageState extends State<RequestItemPage> {
  bool isLoading = false;
  @override
  void initState() {
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var shopProvider = Provider.of<ShopProvider>(context);

    return IgnorePointer(
      ignoring: isLoading ? true : false,
      child: Scaffold(
        drawer: const NavDrawer(),
        body: Stack(
          children: <Widget>[
            Container(
              height: 200.0,
              child: AppBar(
                title: Text(widget.title),
                centerTitle: true,
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(25),
                  ),
                ),
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
            ),
            Container(
              margin: const EdgeInsets.only(top: 80),
              child: FutureBuilder<ShopModel?>(
                future: shopProvider.listToko(userProvider.user.token!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView(
                      children: snapshot.data!.data!.map((e) {
                        return InkWell(
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Akan request barang ${e.name}"),
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
                                        var response =
                                            await shopProvider.requestBarang(
                                          userProvider.user.token,
                                          e.id.toString(),
                                          userProvider.user.data!.user!.id
                                              .toString(),
                                        );
                                        if (response!.statusCode == 400) {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          Navigator.pop(context);
                                          GlobalSnackBar.show(context,
                                              "Failed to request item");
                                        } else if (response.statusCode == 201) {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          Navigator.pop(context);
                                          GlobalSnackBar.show(context,
                                              "Success to request item");
                                        }
                                      },
                                    ),
                                  ],
                                );
                              },
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
                                      image: NetworkImage(
                                          e.pictureLink.toString()),
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
    );
  }
}
