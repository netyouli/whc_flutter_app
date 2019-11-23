

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:whc_flutter_app/app/my/register/register.dart';
import 'package:whc_flutter_app/component/alert.dart';
import 'package:whc_flutter_app/component/loading.dart';
import 'package:whc_flutter_app/constant/api.dart';
import 'package:whc_flutter_app/constant/app_color.dart';
import 'package:whc_flutter_app/http/http.dart';

class ForgetRoute extends StatefulWidget {

  ForgetRoute({Key key}):super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ForgetRouteState();
  }
}

class _ForgetRouteState extends State<ForgetRoute> {

  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _clickCommit() async {
    if (_username.text.isEmpty) {
      Alert.show(context, title: '用户名不能为空！');
      return;
    }
    if (_email.text.isEmpty) {
      Alert.show(context, title: '邮箱不能为空！');
      return;
    }
    Loading.show(context);
    final res = await Http.post(path: Api.forgetPsw, params: {
        'username': _username.text,
        'email': _email.text,
      }
    );
    Loading.close();
    Register register = Register.fromJson(res.body);
    if (register.code == 0) {
      Alert.show(context, title:'提交成功，请软件作者审核');
    }else {
      Alert.show(context, title:register.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('忘记密码'),
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
                controller: _email,
                decoration: InputDecoration(
                  labelText: '邮箱: ',
                  hintText: '请输入邮箱地址',
                  prefixIcon: Icon(Icons.email),
                  border: InputBorder.none,
                ),
              ),
              Divider(height: 5, color: Colors.grey,),
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: FlatButton(
                    color: AppColor.theme,
                    onPressed: _clickCommit,
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