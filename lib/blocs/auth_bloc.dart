import 'dart:async';

import 'package:grab_demo/firebase/fb_auth.dart';

class AuthBloc {
  var _fbAuth=FbAuth();
  StreamController _usernameController = StreamController();
  StreamController _passwordController = StreamController();
  StreamController _emailController = StreamController();
  StreamController _phoneController = StreamController();

  Stream get usernameStream => _usernameController.stream;

  Stream get passwordStream => _passwordController.stream;

  Stream get emailStream => _emailController.stream;

  Stream get phoneStream => _phoneController.stream;

  bool isValid(String username, String password, String email, String phone) {
    if (username == null || username.length == 0) {
      _usernameController.sink.addError("Tên không được để trống");
      return false;
    }
    _usernameController.sink.add("");
    if (password == null || password.length < 6) {
      _passwordController.sink.addError("Mật khẩu ít nhất 6 kí tự");
      return false;
    }
    _passwordController.sink.add("");
    if (email == null || !email.contains("@")) {
      _emailController.sink.addError("Email không hợp lệ");
      return false;
    }
    _emailController.sink.add("");
    if (phone == null || phone.length < 10) {
      _phoneController.sink.addError("Số điện thoại phải ít nhất 10 chữ số");
      return false;
    }
    _phoneController.sink.add("");
    return true;
  }


  void signUp(String email,String password,String username,String phone,Function onSuccess){
    _fbAuth.signUp(email, password, username, phone, onSuccess);
  }

  void signIn(String email,String password,Function onSuccess){
    _fbAuth.signIn(email, password, onSuccess);
  }
  void dispose() {
    _usernameController.close();
    _passwordController.close();
    _emailController.close();
    _phoneController.close();
  }
}
