import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:layang_layang_app/models/toko_model.dart';
import 'package:layang_layang_app/providers/toko_detail_provider.dart';
import 'package:layang_layang_app/providers/toko_provider.dart';
import 'package:layang_layang_app/providers/user_provider.dart';
import 'package:layang_layang_app/ui/widgets/static_base_url.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/nav_drawer.dart';

class ReportTokoPage extends StatefulWidget {
  const ReportTokoPage({Key? key}) : super(key: key);

  @override
  State<ReportTokoPage> createState() => _ReportTokoPageState();
}

class _ReportTokoPageState extends State<ReportTokoPage> {
  @override
  Widget build(BuildContext context) {
    var tokoProvider = Provider.of<TokoProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: Text("Cetak Laporan Toko"),
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
            child: FutureBuilder<TokoModel?>(
              future: tokoProvider.listToko(userProvider.user.token.toString(),
                  userProvider.user.data!.user!.id.toString()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return GridView.count(
                    crossAxisCount: 2,
                    children: snapshot.data!.data!.map((e) {
                      return InkWell(
                        onTap: () async {
                          String url =
                              "http://${StaticBaseUrl.baseUrl}/laporantoko/${e.id}";
                          if (await canLaunchUrl(Uri.parse(url))) {
                            await launchUrl(
                              Uri.parse(url),
                              mode: LaunchMode.externalApplication,
                            );
                          } else {
                            throw "Could not launch $url";
                          }
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
                                    image:
                                        AssetImage("assets/images/store.png"),
                                    height: 100,
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    e.name.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Expanded(
                                    child: Text(
                                      e.description.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black38,
                                      ),
                                    ),
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
