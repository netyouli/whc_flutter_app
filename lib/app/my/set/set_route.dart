/*
 * @copyright whc 2019
 * http://www.apache.org/licenses/LICENSE-2.0
 * https://github.com/netyouli/whc_flutter_app
 */
import 'package:flutter/material.dart';
import 'package:whc_flutter_app/app/my/set/set_item.dart';
import 'package:whc_flutter_app/app/user/user.dart';
import 'package:whc_flutter_app/component/whc_inherited_widget.dart';
import 'package:whc_flutter_app/constant/app_color.dart';

class SetRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
      ),
      body: Container(
        color: AppColor.back,
        child: WHCInheritedWidget(
          data: User.login,
          child: Column(
            children: <Widget>[
              SetItem(title: '邮箱'),
              SetItem(title: '手机号'),
              SetItem(title: '修改账号密码'),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: FlatButton(
                    color: AppColor.theme,
                    onPressed: () {
                      User.exitLogin();
                      Navigator.of(context).pop(true);
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      height: 44,
                      child: Text('退出登录', style: TextStyle(color: Colors.white),),
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