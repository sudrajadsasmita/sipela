import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:layang_layang_app/models/request_barang_model.dart';
import 'package:layang_layang_app/models/request_update_model.dart';
import 'package:layang_layang_app/models/user_management_model.dart';
import 'package:layang_layang_app/models/user_management_update_model.dart';
import 'package:layang_layang_app/providers/request_provider.dart';
import 'package:layang_layang_app/providers/user_provider.dart';
import 'package:layang_layang_app/ui/pages/splash/splash_screen.dart';
import 'package:layang_layang_app/ui/widgets/nav_drawer.dart';
import 'package:provider/provider.dart';

class RequestBarangPage extends StatefulWidget {
  const RequestBarangPage({Key? key}) : super(key: key);

  @override
  State<RequestBarangPage> createState() => _RequestBarangPageState();
}

class _RequestBarangPageState extends State<RequestBarangPage> {
  late Future<RequestBarangModel?> _initData;
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var requestProvider = Provider.of<RequestProvider>(context);
    _initData =
        requestProvider.getAllRequest(userProvider.user.token.toString());

    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("List Request Barang"),
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
            decoration: const BoxDecoration(color: Colors.blue),
          ),
          Container(
            child: FutureBuilder<RequestBarangModel?>(
              future: _initData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView(
                    children: snapshot.data!.data!.map(
                      (e) {
                        return InkWell(
                          onTap: () async {
                            requestProvider.requestUpdate = RequestUpdateModel(
                              requestId: e.id.toString(),
                              name: e.barangbase!.name,
                              barangbaseId: e.barangbase!.id.toString(),
                              requestFrom: e.requestFrom!.id.toString(),
                              requestStatus: e.requestStatus,
                              imgUrl: e.barangbase!.pictureLink,
                            );
                            Navigator.pushNamed(
                                    context, '/updaterequestbarangpage')
                                .then((_) => setState(() {}));
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(12, 2, 12, 2),
                            decoration: const BoxDecoration(
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
                                          "${e.barangbase!.pictureLink}"),
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
                                          "${e.barangbase!.name}",
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
                                          "Dari : ${e.requestFrom!.email}",
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
                                          children: [
                                            Text(
                                              "Status : ",
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
                                                "${e.requestStatus}",
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
