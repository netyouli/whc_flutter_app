
/*
 * @copyright whc 2019
 * http://www.apache.org/licenses/LICENSE-2.0
 * https://github.com/netyouli/whc_flutter_app
 */
import 'package:flutter/material.dart';
import 'package:whc_flutter_app/app/my/login/login.dart';
import 'package:whc_flutter_app/app/my/my_item.dart';
import 'package:whc_flutter_app/app/user/user.dart';
import 'package:whc_flutter_app/component/whc_inherited_widget.dart';
import 'package:whc_flutter_app/constant/app_color.dart';
import 'package:whc_flutter_app/http/http.dart';

class MyRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyRouteState();
  }
}

class _MyRouteState extends State<MyRoute> {
  Login _userInfo = Login();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (User.didLogin()) {
      _userInfo.copySelf(User.login);
    }
  }

  void _goLogin([void Function(bool) callback]) {
    if (!User.didLogin()) {
      /**
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context){
            return LoginRoute();
          }
        ));
       */
      Navigator.of(context).pushNamed('login').then<Login>((login) {
        _userInfo.copySelf(login);
        if (callback != null) {
          callback(login != null);
        }
        return login;
      });
      if (callback != null) {
        callback(false);
      }
    }else {
      if (callback != null) {
          callback(true);
        }
    }
  }
  Widget _header() {
    return WHCInheritedData<Login>(
      builder: (context, info){
        return FlatButton(
          onPressed: () {
            _goLogin();
          },
          padding: EdgeInsets.all(0),
          child: Container(
            height: 100,
            width: double.infinity,
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                ClipOval(
                  child: info.image != null ? Image.network(Http.share.baseUrl + info.image, width: 70, height: 70) : Image.asset('images/default_icon.png', width: 70, height: 70),
                ),
                Padding(padding: EdgeInsets.only(left: 20),),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(info.username ?? '游客', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    Padding(padding: EdgeInsets.only(top: 10),),
                    Text(info.detail ?? 'www.wuhaichao.com')
                  ],
                ),
                Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset('images/right_arrow_icon.png', width: 20, height: 20),
                    )
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WHCInheritedWidget(
      data: _userInfo,
      child: Scaffold(
        appBar: AppBar(
          title: Text('个人中心'),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: AppColor.back,
            padding: EdgeInsets.only(top: 20),
            child: Column(
              children: <Widget>[
                _header(),
                Padding(padding: EdgeInsets.only(top: 20),),
                MyItem(title: '我喜欢的', iconPath: 'images/my_love_icon.png', onPressed: (){
                  _goLogin((ok){
                    if (ok) {
                      Navigator.of(context).pushNamed('mylike');
                    }
                  });
                },),
                MyItem(title: '我的收藏集', iconPath: 'images/my_collect_icon.png', onPressed: (){
                  _goLogin((ok){
                    if (ok) {
                      Navigator.of(context).pushNamed('mycollect');
                    }
                  });
                },),
                MyItem(title: '阅读过的文章', iconPath: 'images/my_read_icon.png', onPressed: (){
                  _goLogin((ok){
                    if (ok) {
                      Navigator.of(context).pushNamed('didread');
                    }
                  });
                },),
                Padding(padding: EdgeInsets.only(top: 20),),
                MyItem(title: '意见反馈', iconPath: 'images/my_suggest_icon.png', onPressed: (){
                  _goLogin((ok){
                    if (ok) {
                      Navigator.of(context).pushNamed('feedback');
                    }
                  });
                },),
                MyItem(title: '设置', iconPath: 'images/my_set_icon.png', onPressed: (){
                  _goLogin((ok){
                    if (ok) {
                      Navigator.of(context).pushNamed('set').then((isexit){
                        if (isexit = true) {
                          _userInfo.copySelf(Login());
                        }
                      });
                    }
                  });
                },),
              ],
            ),
          )
        )
      ),
    );
  }
}