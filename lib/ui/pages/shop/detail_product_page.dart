import 'package:flutter/material.dart';
import 'package:layang_layang_app/models/buy_model.dart';
import 'package:layang_layang_app/models/transaction_detail_model.dart';
import 'package:layang_layang_app/providers/display_provider.dart';
import 'package:layang_layang_app/providers/product_detail_provider.dart';
import 'package:layang_layang_app/providers/user_provider.dart';
import 'package:layang_layang_app/ui/widgets/show_snackbar.dart';
import 'package:provider/provider.dart';

class DetailProductPage extends StatefulWidget {
  const DetailProductPage({Key? key}) : super(key: key);

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  int stock = 0;
  bool isLoading = false;
  // set up the AlertDialog

  // show the dialog
  @override
  void initState() {
    stock = 0;
    isLoading = false;
    super.initState();
  }

  Widget stockProduct() {
    return FractionallySizedBox(
      widthFactor: 0.5,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 50,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(30),
              right: Radius.circular(30),
            ),
            color: Colors.black38),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  if (stock == 0) {
                    stock = 0;
                  } else {
                    stock--;
                  }
                });
              },
              child: Text(
                "-",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              stock.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  stock++;
                });
              },
              child: Text(
                "+",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var productDetailProvider = Provider.of<ProductDetailProvider>(context);
    var displayProvider = Provider.of<DisplayProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    Widget submitButton() {
      AlertDialog alert = AlertDialog(
        title: Text(
            "${productDetailProvider.detail.barangbase?.name} akan di checkout"),
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
              if (stock == 0) {
                setState(() {
                  isLoading = false;
                });
                Navigator.pop(context);

                GlobalSnackBar.show(context, "Tambahkan jumlah barang");
              } else {
                Navigator.pop(context);
                BuyModel? buy = await displayProvider.transaction(
                    userProvider.user.token.toString(),
                    productDetailProvider.detail.id.toString(),
                    userProvider.user.data!.user?.id.toString(),
                    stock.toString());
                setState(() {
                  isLoading = false;
                });
                GlobalSnackBar.show(context, "Barang berhasil di beli");
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  "/display",
                  (route) => false,
                );
              }
            },
          ),
        ],
      );
      return Padding(
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
              'Beli',
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
      );
    }

    Widget title() {
      return Container(
        child: Text(
          "${productDetailProvider.detail.barangbase?.name}",
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      );
    }

    Widget shopName() {
      return Container(
        margin: EdgeInsets.only(top: 12),
        child: Text(
          "${productDetailProvider.detail.toko?.name}",
          style: TextStyle(
            color: Colors.black45,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    Widget price() {
      return Container(
        margin: EdgeInsets.only(top: 12),
        child: Text(
          "Rp ${productDetailProvider.detail.barangbase!.price}",
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
      );
    }

    Widget description() {
      return Container(
        margin: EdgeInsets.only(top: 12),
        child: Text(
          "${productDetailProvider.detail.barangbase?.description}",
          style: TextStyle(
            color: Colors.black54,
          ),
          textAlign: TextAlign.justify,
        ),
      );
    }

    Widget imageProduct() {
      return Container(
        child: Card(
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(
              image: NetworkImage(
                  "${productDetailProvider.detail.barangbase?.pictureLink}"),
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async => isLoading ? false : true,
      child: Scaffold(
        bottomSheet: IgnorePointer(
          ignoring: isLoading ? true : false,
          child: submitButton(),
        ),
        appBar: AppBar(
          title:
              Text("detail ${productDetailProvider.detail.barangbase?.name}"),
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
        body: IgnorePointer(
          ignoring: isLoading ? true : false,
          child: Stack(
            children: <Widget>[
              Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(300),
                  ),
                  color: Colors.blue,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 12,
                  right: 12,
                  bottom: 8,
                ),
                child: ListView(
                  children: <Widget>[
                    imageProduct(),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            title(),
                            shopName(),
                            price(),
                            description(),
                          ],
                        ),
                      ),
                    ),
                    stockProduct(),
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
    );
  }
}
