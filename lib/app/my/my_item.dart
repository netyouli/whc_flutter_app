/*
 * @copyright whc 2019
 * http://www.apache.org/licenses/LICENSE-2.0
 * https://github.com/netyouli/whc_flutter_app
 */
import 'package:flutter/material.dart';
import 'package:whc_flutter_app/app/my/login/login.dart';
import 'package:whc_flutter_app/component/whc_inherited_widget.dart';
import 'package:whc_flutter_app/constant/app_color.dart';

class MyItem extends StatelessWidget {
  MyItem({
      Key key, 
      @required this.title,
      this.value,
      this.iconPath,
      this.onPressed,
    }): super(key: key);
  
  final String title;
  final String value;
  final String iconPath;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<Widget> views = List<Widget>();
    if (iconPath != null) {
      views.add(Image.asset(iconPath, width: 20, height: 20,));
      views.add(Padding(padding: EdgeInsets.only(left: 20),));
    }
    views.add(Text(title));
    views.add(Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: value != null ? Text(value) :
        WHCInheritedData<Login>(
          builder: (context, info) {
            String value = '';
            switch(title) {
              case '我喜欢的':
              value = info.lovenum?.toString();
              break;
              case '我的收藏集':
              value = info.collectnum?.toString();
              break;
              case '阅读过的文章':
              value = info.readnum?.toString();
              break;
            }
            return Text(value ?? '');
          },
        ),
      ),
    ));
    return Column(
      children: <Widget>[
        FlatButton(
          onPressed: onPressed,
          color: Colors.white,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: views,
            ),
          ),
        ),
        Divider(height: 0.5, color: AppColor.line,)
      ],
    );
  }
}