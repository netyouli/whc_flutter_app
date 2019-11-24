
/*
 * @copyright whc 2019
 * http://www.apache.org/licenses/LICENSE-2.0
 * https://github.com/netyouli/whc_flutter_app
 */
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:whc_flutter_app/app/my/login/login.dart';
import 'package:whc_flutter_app/app/store/store.dart';
import 'package:whc_flutter_app/app/user/user.dart';
import 'package:whc_flutter_app/component/alert.dart';
import 'package:whc_flutter_app/component/loading.dart';
import 'package:whc_flutter_app/constant/api.dart';
import 'package:whc_flutter_app/constant/app_color.dart';
import 'package:whc_flutter_app/http/http.dart';

class LoginRoute extends StatefulWidget {

  LoginRoute({Key key}):super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginRouteState();
  }
}

class _LoginRouteState extends State<LoginRoute> {

  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /** 登录测试账号
     * _username.text = '111';
      _password.text = '123456';
     */
    () async {
      _username.text = await Store.get<String>('username');
      _password.text = await Store.get<String>('password');
    }();
  }

  void _clickLogin() async {
    if (_username.text.isEmpty) {
      Alert.show(context, title: '用户名不能为空！');
      return;
    }
    if (_password.text.isEmpty) {
      Alert.show(context, title: '密码不能为空！');
      return;
    }
    Loading.show(context);
    final res = await Http.post(path: Api.login, params: {
        'username': _username.text,
        'password': _password.text,
      }
    );
    Loading.close();
    Login login = Login.fromJson(res.body);
    if (login.code == 0) {
      Store.save('username', _username.text);
      Store.save('password', _password.text);
      User.saveLogin(login);
      Navigator.of(context).pop(login);
    }else {
      Alert.show(context, title:login.message);
    }
  }

  void _clickForget() {
    Navigator.of(context).pushNamed('forget');
  }

  void _clickRegister() {
    Navigator.of(context).pushNamed('register');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
        actions: <Widget>[
          FlatButton(
            onPressed: _clickRegister,
            child: Text('注册', style: TextStyle(color: Colors.white),),
          )
        ],
      ),
      backgroundColor: AppColor.back,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 40),
                child: ClipOval(
                  child: Image.asset('images/tmp_user_icon3.png', width: 100, height: 100,),
                ),
              ),
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
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: FlatButton(
                    color: AppColor.theme,
                    onPressed: _clickLogin,
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      height: 44,
                      child: Text('登录', style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: _clickForget,
                  child: Text('忘记密码', style: TextStyle(color: AppColor.black),),
                ),
              )
            ],
          ),
        ),
      ), 
    );
  }
}