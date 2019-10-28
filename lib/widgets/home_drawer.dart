import 'package:flutter/material.dart';

class HomeDrawer extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeDrawerState();
  }

}
class HomeDrawerState extends State<StatefulWidget>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text("Tài khoản"),
        ),
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text("Thông báo"),
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text("Cài đặt"),
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text("Đăng xuất"),
        )
      ],
    );
  }
}