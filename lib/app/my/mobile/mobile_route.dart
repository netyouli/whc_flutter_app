

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:whc_flutter_app/app/my/register/register.dart';
import 'package:whc_flutter_app/app/user/user.dart';
import 'package:whc_flutter_app/component/alert.dart';
import 'package:whc_flutter_app/component/loading.dart';
import 'package:whc_flutter_app/constant/api.dart';
import 'package:whc_flutter_app/constant/app_color.dart';
import 'package:whc_flutter_app/http/http.dart';

class MobileRoute extends StatefulWidget {

  MobileRoute({Key key}):super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MobileRouteState();
  }
}

class _MobileRouteState extends State<MobileRoute> {

  TextEditingController _mobile = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _clickCommit() async {
    if (_mobile.text.isEmpty) {
      Alert.show(context, title: '手机号不能为空！');
      return;
    }
    Loading.show(context);
    final res = await Http.post(path: Api.modifyMobile, params: {
        'username': User.login.username,
        'mobile': _mobile.text,
      }
    );
    Loading.close();
    Register register = Register.fromJson(res.body);
    if (register.code == 0) {
      User.login.mobile = _mobile.text;
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
        title: Text('修改手机号'),
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
                controller: _mobile,
                decoration: InputDecoration(
                  labelText: '手机号: ',
                  hintText: '请输入手机号',
                  prefixIcon: Icon(Icons.phone),
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
