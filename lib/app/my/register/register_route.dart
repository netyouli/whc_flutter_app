

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:whc_flutter_app/app/my/register/register.dart';
import 'package:whc_flutter_app/component/alert.dart';
import 'package:whc_flutter_app/component/loading.dart';
import 'package:whc_flutter_app/constant/api.dart';
import 'package:whc_flutter_app/constant/app_color.dart';
import 'package:whc_flutter_app/http/http.dart';

class RegisterRoute extends StatefulWidget {

  RegisterRoute({Key key}):super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RegisterRouteRouteState();
  }
}

class _RegisterRouteRouteState extends State<RegisterRoute> {

  TextEditingController _username = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _repassword = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _clickRegister() async {
    if (_username.text.isEmpty) {
      Alert.show(context, title: '用户名不能为空！');
      return;
    }
    if (_password.text.isEmpty) {
      Alert.show(context, title: '密码不能为空！');
      return;
    }
    if (_mobile.text.isEmpty) {
      Alert.show(context, title: '手机号不能为空！');
      return;
    }
    if (_email.text.isEmpty) {
      Alert.show(context, title: '邮箱不能为空！');
      return;
    }
    if (_password.text != _repassword.text) {
      Alert.show(context, title: '两次密码不一致！');
      return;
    }
    Loading.show(context);
    final res = await Http.post(path: Api.register, params: {
        'username': _username.text,
        'password': _password.text,
        'mobile': _mobile.text,
        'email': _email.text,
      }
    );
    Loading.close();
    Register register = Register.fromJson(res.body);
    if (register.code == 0) {
      Navigator.of(context).pop();
    }else {
      Alert.show(context, title:register.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('注册'),
      ),
      backgroundColor: AppColor.back,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _username,
                decoration: InputDecoration(
                  labelText: '用户名: ',
                  hintText: '请输入用户名',
                  prefixIcon: Icon(Icons.person),
                  border: InputBorder.none,
                ),
              ),
              Divider(height: 5, color: Colors.grey,),
              TextField(
                controller: _mobile,
                decoration: InputDecoration(
                  labelText: '手机号: ',
                  hintText: '请输入手机号',
                  prefixIcon: Icon(Icons.phone),
                  border: InputBorder.none,
                ),
              ),
              Divider(height: 5, color: Colors.grey,),
              TextField(
                controller: _email,
                decoration: InputDecoration(
                  labelText: '邮箱: ',
                  hintText: '请输入邮箱地址',
                  prefixIcon: Icon(Icons.email),
                  border: InputBorder.none,
                ),
              ),
              Divider(height: 5, color: Colors.grey,),
              TextField(
                controller: _password,
                decoration: InputDecoration(
                  labelText: '密码: ',
                  hintText: '请输入密码',
                  prefixIcon: Icon(Icons.lock),
                  border: InputBorder.none,
                ),
                obscureText: true,
              ),
              Divider(height: 5, color: Colors.grey,),
              TextField(
                controller: _repassword,
                decoration: InputDecoration(
                  labelText: '确认密码: ',
                  hintText: '请再次输入密码',
                  prefixIcon: Icon(Icons.lock),
                  border: InputBorder.none,
                ),
                obscureText: true,
              ),
              Divider(height: 5, color: Colors.grey,),
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: FlatButton(
                    color: AppColor.theme,
                    onPressed: _clickRegister,
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      height: 44,
                      child: Text('提交', style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ), 
    );
  }
}