
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

class EmailRoute extends StatefulWidget {

  EmailRoute({Key key}):super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EmailRouteState();
  }
}

class _EmailRouteState extends State<EmailRoute> {

  TextEditingController _email = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _clickCommit() async {
    if (_email.text.isEmpty) {
      Alert.show(context, title: '邮箱不能为空！');
      return;
    }
    Loading.show(context);
    final res = await Http.post(path: Api.modifyEmail, params: {
        'username': User.login.username,
        'email': _email.text,
      }
    );
    Loading.close();
    Register register = Register.fromJson(res.body);
    if (register.code == 0) {
      User.login.email = _email.text;
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
        title: Text('修改邮箱'),
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
