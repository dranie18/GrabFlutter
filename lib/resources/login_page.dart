import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:grab_demo/resources/register_page.dart';

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginPageState();
  }

}
class _LoginPageState extends State<StatefulWidget>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        padding: EdgeInsets.fromLTRB(30, 0, 30,0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Image.asset('logo.png'),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                child: Text('Chào mừng trở lại!',style: TextStyle(fontSize: 22),),
              ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Tài khoản',
                    prefixIcon: Icon(Icons.account_circle,color: Color(0xff289245),),
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 1),borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu',
                    prefixIcon: Icon(Icons.lock,color: Color(0xff289245),),
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 1),borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: RaisedButton(
                  onPressed: (){},
                  child: Text("Đăng nhập",style: TextStyle(fontSize: 20,color: Colors.white),),
                  color: Color(0xff289245),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: FlatButton(
                  child: Text('Đăng kí',style: TextStyle(fontSize: 18,color: Color(0xff289245), ),),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context)=>RegisterPage()
                    ));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
