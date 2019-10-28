import 'package:flutter/material.dart';
import 'package:grab_demo/blocs/auth_bloc.dart';
import 'package:grab_demo/resources/home_page.dart';
import 'package:grab_demo/resources/login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<StatefulWidget> {
  AuthBloc authBloc = AuthBloc();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    authBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Image.asset('logo.png'),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                child: Text(
                  'Đăng kí nhanh chỉ 5 phút!',
                  style: TextStyle(fontSize: 22),
                ),
              ),
              StreamBuilder<Object>(
                  stream: authBloc.usernameStream,
                  builder: (context, snapshot) {
                    return TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        errorText: snapshot.hasError ? snapshot.error : null,
                        labelText: 'Tên người dùng',
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xff289245),
                        ),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                      ),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: StreamBuilder<Object>(
                    stream: authBloc.passwordStream,
                    builder: (context, snapshot) {
                      return TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          errorText: snapshot.hasError ? snapshot.error : null,
                          labelText: 'Mật khẩu',
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color(0xff289245),
                          ),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                        ),
                      );
                    }),
              ),
              StreamBuilder<Object>(
                  stream: authBloc.emailStream,
                  builder: (context, snapshot) {
                    return TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        errorText: snapshot.hasError ? snapshot.error : null,
                        labelText: 'Email',
                        prefixIcon: Icon(
                          Icons.email,
                          color: Color(0xff289245),
                        ),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                      ),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: StreamBuilder<Object>(
                    stream: authBloc.phoneStream,
                    builder: (context, snapshot) {
                      return TextField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          errorText: snapshot.hasError ? snapshot.error : null,
                          labelText: 'Số điện thoại',
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Color(0xff289245),
                          ),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                        ),
                      );
                    }),
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: RaisedButton(
                  onPressed: _onSignUpClick,
                  child: Text(
                    "Đăng kí",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  color: Color(0xff289245),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: FlatButton(
                  child: Text(
                    'Đăng nhập',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff289245),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  _onSignUpClick() {
    bool isValid = authBloc.isValid(_usernameController.text,
        _passwordController.text, _emailController.text, _phoneController.text);
    if(isValid){
      authBloc.signUp(_emailController.text, _passwordController.text, _usernameController.text, _phoneController.text, (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
      });
    }
  }
}


