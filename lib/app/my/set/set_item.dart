import 'package:flutter/material.dart';
import 'package:whc_flutter_app/app/my/login/login.dart';
import 'package:whc_flutter_app/app/user/user.dart';
import 'package:whc_flutter_app/component/whc_inherited_widget.dart';
import 'package:whc_flutter_app/constant/app_color.dart';

class SetItem extends StatelessWidget {
  SetItem({Key key, @required this.title}): assert(title != null) , super(key:key);
  final String title;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget value = Container();
    switch(title) {
      case '邮箱':
      case '手机号':
      value = Expanded(
        child: WHCInheritedData<Login>(
          builder: (context, login){
            return Text(title == '邮箱' ? login.email : login.mobile, style: TextStyle(color: AppColor.deepGray),textAlign: TextAlign.right,);
          },
        ),
      );
      break;
    }
    return FlatButton(
      padding: EdgeInsets.all(0),
      onPressed: () async {
        if (title == '邮箱') {
          await Navigator.of(context).pushNamed('email');
          User.login.updateChange();
        }else if (title == '手机号') {
          await Navigator.of(context).pushNamed('mobile');
          User.login.updateChange();
        }else {
          Navigator.of(context).pushNamed('modifypsw');
        }
      },
      child: Container(
        height: 50,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: Divider.createBorderSide(context, color: AppColor.line, width: 0.5)
          )
        ),
        child: Row(
          children: <Widget>[
            Text(title, style: TextStyle(color: AppColor.deepGray),),
            value
          ],
        ),
      )
    );
  }
}