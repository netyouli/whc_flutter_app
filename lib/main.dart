import 'package:flutter/material.dart';
import 'package:whc_flutter_app/app/community/activity/activity_offlin_route.dart';
import 'package:whc_flutter_app/app/community/collect/collect_set_route.dart';
import 'package:whc_flutter_app/app/community/column/column_route.dart';
import 'package:whc_flutter_app/app/community/week/week_route.dart';
import 'package:whc_flutter_app/app/my/collect/my_collect_route.dart';
import 'package:whc_flutter_app/app/my/email/email_route.dart';
import 'package:whc_flutter_app/app/my/feedback/feedback_route.dart';
import 'package:whc_flutter_app/app/my/forget/forget_route.dart';
import 'package:whc_flutter_app/app/my/login/login_route.dart';
import 'package:whc_flutter_app/app/my/love/my_love_route.dart';
import 'package:whc_flutter_app/app/my/mobile/mobile_route.dart';
import 'package:whc_flutter_app/app/my/modifypsw/modify_psw_route.dart';
import 'package:whc_flutter_app/app/my/read/read_route.dart';
import 'package:whc_flutter_app/app/my/register/register_route.dart';
import 'package:whc_flutter_app/app/my/set/set_route.dart';
import 'package:whc_flutter_app/app/tabbar/tabbar_route.dart';
import 'package:whc_flutter_app/app/user/user.dart';
import 'package:whc_flutter_app/app/web/web_route.dart';
import 'package:whc_flutter_app/constant/app_color.dart';
import 'package:whc_flutter_app/http/http.dart';

void main() {
  Http.share.baseUrl = 'http://www.wuhaichao.com/app/';
  Http.share.headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/x-www-form-urlencoded',
  };
  User.autoLogin();
  runApp(WHCApp());
}

class WHCApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WHC Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: AppColor.theme,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => TabbarRoute(),
        'login': (context) => LoginRoute(),
        'register': (context) => RegisterRoute(),
        'forget': (context) => ForgetRoute(),
        'mylike': (context) => MyLoveRoute(),
        'didread': (context) => ReadRoute(),
        'mycollect': (context) => MyCollectRoute(),
        'feedback': (context) => FeedbackRoute(),
        'set': (context) => SetRoute(),
        'email': (context) => EmailRoute(),
        'mobile': (context) => MobileRoute(),
        'modifypsw': (context) => ModifyPswRoute(),
        'weekhot': (context) => WeekRoute(),
        'collectset': (context) => CollectSetRoute(),
        'activityoffline': (context) => ActivityOfflineRoute(),
        'column': (context) => ColumnRoute(),
        'web': (context, ) {
          var args = ModalRoute.of(context).settings.arguments as Map<String, String>;
          return WebRoute(title: args['title'], url: args['url'],);
        },
      },
      onGenerateRoute: (setting) {
        return MaterialPageRoute(builder: (context){
          if (setting.name == 'name') {
            return LoginRoute(); 
          }
        });
      },
    );
  }
}

