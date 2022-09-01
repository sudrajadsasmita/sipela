import 'dart:ffi';

import 'package:flutter/material.dart';

class AproveStockProductPage extends StatefulWidget {
  const AproveStockProductPage({Key? key}) : super(key: key);

  @override
  State<AproveStockProductPage> createState() => _AproveStockProductPageState();
}

class _AproveStockProductPageState extends State<AproveStockProductPage> {
  int stock = 0;

  // set up the AlertDialog

  // show the dialog
  @override
  void initState() {
    stock = 0;
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

  Widget submitButton() {
    AlertDialog alert = AlertDialog(
      title: Text("{nama barang} akan di tambahkan di {toko}"),
      content: Text("Apa anda yakin?"),
      actions: [
        TextButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text("Continue"),
          onPressed: () {},
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
            'Tambah',
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
        "Nama Product",
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
        "Toko Mbak Ana",
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
        "Rp 2000",
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
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
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
            image: AssetImage("assets/images/bakery.png"),
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: submitButton(),
      appBar: AppBar(
        title: Text("detail {nama barang}"),
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
        ],
      ),
    );
  }
}
