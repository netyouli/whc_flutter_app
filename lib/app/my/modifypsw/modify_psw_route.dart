
/*
 * @copyright whc 2019
 * http://www.apache.org/licenses/LICENSE-2.0
 * https://github.com/netyouli/whc_flutter_app
 */
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:whc_flutter_app/app/my/register/register.dart';
import 'package:whc_flutter_app/app/user/user.dart';
import 'package:whc_flutter_app/component/alert.dart';
import 'package:whc_flutter_app/component/loading.dart';
import 'package:whc_flutter_app/constant/api.dart';
import 'package:whc_flutter_app/constant/app_color.dart';
import 'package:whc_flutter_app/http/http.dart';

class ModifyPswRoute extends StatefulWidget {

  ModifyPswRoute({Key key}):super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ModifyPswRouteState();
  }
}

class _ModifyPswRouteState extends State<ModifyPswRoute> {

  TextEditingController _oldpsw = TextEditingController();
  TextEditingController _newpsw = TextEditingController();
  TextEditingController _renewpsw = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _clickCommit() async {
    if (_oldpsw.text.isEmpty) {
      Alert.show(context, title: '旧密码不能为空！');
      return;
    }
    if (_newpsw.text.isEmpty) {
      Alert.show(context, title: '新密码不能为空！');
      return;
    }
    if (_newpsw.text != _renewpsw.text) {
      Alert.show(context, title: '新密码两次不一致！');
      return;
    }
    Loading.show(context);
    final res = await Http.post(path: Api.modityPsw, params: {
        'username': User.login.username,
        'password': _oldpsw.text,
        'newpassword': _newpsw.text,
      }
    );
    Loading.close();
    Register register = Register.fromJson(res.body);
    if (register.code == 0) {
      Alert.show(context, title:'修改成功');
    }else {
      Alert.show(context, title:register.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('修改密码'),
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
                controller: _oldpsw,
                decoration: InputDecoration(
                  labelText: '当前密码: ',
                  hintText: '请输入当前密码',
                  prefixIcon: Icon(Icons.lock),
                  border: InputBorder.none,
                ),
                obscureText: true,
              ),
              Divider(height: 5, color: Colors.grey,),
              TextField(
                controller: _newpsw,
                decoration: InputDecoration(
                  labelText: '新密码: ',
                  hintText: '请输入新密码',
                  prefixIcon: Icon(Icons.lock),
                  border: InputBorder.none,
                ),
                obscureText: true,
              ),
              Divider(height: 5, color: Colors.grey,),
              TextField(
                controller: _renewpsw,
                decoration: InputDecoration(
                  labelText: '确认新密码: ',
                  hintText: '请再次输入新密码',
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