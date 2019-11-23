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
              SetItem(title: '修改账号密码')
            ],
          ),
        ),
      ),
    );
  }
}