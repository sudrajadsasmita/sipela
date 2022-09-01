import 'package:flutter/material.dart';
import 'package:layang_layang_app/providers/auth_provider.dart';
import 'package:layang_layang_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var authProvider = Provider.of<AuthProvider>(context);

    Widget _drawerHeader() {
      return UserAccountsDrawerHeader(
        currentAccountPicture: ClipOval(
          child: Image(
            image: AssetImage("assets/images/user.png"),
            fit: BoxFit.cover,
          ),
        ),
        accountName: Text("${userProvider.user.data?.user?.profil?.name}"),
        accountEmail: Text("${userProvider.user.data?.user?.email}"),
      );
    }

    Widget _drawerItem({
      IconData? icon,
      String? text,
      GestureTapCallback? onTap,
    }) {
      return ListTile(
        title: Row(
          children: [
            Icon(icon),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                text!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        onTap: onTap,
      );
    }

    List<Widget> _menuCustomer = [
      _drawerHeader(),
      _drawerItem(
        icon: Icons.smart_display,
        text: "Etalase",
        onTap: () async {
          var name = ModalRoute.of(context)!.settings.name;
          if (name == "/display") {
            Navigator.pop(context);
          } else {
            Navigator.pushNamedAndRemoveUntil(
              context,
              "/display",
              (route) => false,
            );
          }
        },
      ),
      // _drawerItem(
      //   icon: Icons.shop_2,
      //   text: "Daftar Toko",
      //   onTap: () async {
      //     Navigator.pushNamedAndRemoveUntil(
      //       context,
      //       "/shop",
      //       (route) => false,
      //     );
      //   },
      // ),
      _drawerItem(
        icon: Icons.money,
        text: "Transaksi",
        onTap: () async {
          Navigator.pushNamedAndRemoveUntil(
            context,
            "/transactionconfirm",
            (route) => false,
          );
        },
      ),
      const Divider(
        height: 25,
        thickness: 1,
      ),
      const Padding(
        padding: EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
        child: Text(
          "Label",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
      ),
      _drawerItem(
        icon: Icons.logout,
        text: "Logout",
        onTap: () async {
          var ress = await authProvider.logout(userProvider.user.token!);

          Navigator.pushNamedAndRemoveUntil(
            context,
            "/login",
            (route) => false,
          );
        },
      ),
    ];
    List<Widget> _menuDistributor = [
      _drawerHeader(),
      _drawerItem(
        icon: Icons.list,
        text: "List Barang",
        onTap: () async {
          Navigator.pushNamedAndRemoveUntil(
            context,
            "/requestitempage",
            (route) => false,
          );
        },
      ),
      _drawerItem(
        icon: Icons.money,
        text: "List Penjualan",
        onTap: () async {
          Navigator.pushNamedAndRemoveUntil(
            context,
            "/toko",
            (route) => false,
          );
        },
      ),
      _drawerItem(
        icon: Icons.bookmark,
        text: "Laporan Toko",
        onTap: () async {
          String url = "https://sipela.herokuapp.com/laporantoko";
          if (await canLaunchUrl(Uri.parse(url)))
            await launchUrl(
              Uri.parse(url),
              mode: LaunchMode.externalApplication,
            );
          else
            throw "Could not launch $url";
        },
      ),
      _drawerItem(
        icon: Icons.bookmark,
        text: "Laporan Rekap",
        onTap: () async {
          String url = "https://sipela.herokuapp.com/laporanrekap";
          if (await canLaunchUrl(Uri.parse(url)))
            await launchUrl(
              Uri.parse(url),
              mode: LaunchMode.externalApplication,
            );
          else
            throw "Could not launch $url";
        },
      ),
      const Divider(
        height: 25,
        thickness: 1,
      ),
      const Padding(
        padding: EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
        child: Text(
          "Label",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
      ),
      _drawerItem(
        icon: Icons.logout,
        text: "Logout",
        onTap: () async {
          var ress = await authProvider.logout(userProvider.user.token!);

          Navigator.pushNamedAndRemoveUntil(
            context,
            "/login",
            (route) => false,
          );
        },
      ),
    ];
    List<Widget> _menuAdmin = [
      _drawerHeader(),
      _drawerItem(
        icon: Icons.list,
        text: "User Management",
        onTap: () async {
          Navigator.pushNamedAndRemoveUntil(
            context,
            "/shop",
            (route) => false,
          );
        },
      ),
      _drawerItem(
        icon: Icons.money,
        text: "Request Stok Barang",
        onTap: () async {
          Navigator.pushNamedAndRemoveUntil(
            context,
            "/transactionconfirm",
            (route) => false,
          );
        },
      ),
      const Divider(
        height: 25,
        thickness: 1,
      ),
      const Padding(
        padding: EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
        child: Text(
          "Label",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
      ),
      _drawerItem(
        icon: Icons.logout,
        text: "Logout",
        onTap: () async {
          var ress = await authProvider.logout(userProvider.user.token!);

          Navigator.pushNamedAndRemoveUntil(
            context,
            "/login",
            (route) => false,
          );
        },
      ),
    ];
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: userProvider.user.data!.user!.role == "pembeli"
            ? _menuCustomer
            : userProvider.user.data!.user!.role == "distributor"
                ? _menuDistributor
                : userProvider.user.data!.user!.role == "admin"
                    ? _menuAdmin
                    : [],
      ),
    );
  }
}
