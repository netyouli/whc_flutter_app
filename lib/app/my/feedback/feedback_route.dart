
/*
 * @copyright whc 2019
 * http://www.apache.org/licenses/LICENSE-2.0
 * https://github.com/netyouli/whc_flutter_app
 */
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:whc_flutter_app/app/my/register/register.dart';
import 'package:whc_flutter_app/component/alert.dart';
import 'package:whc_flutter_app/component/loading.dart';
import 'package:whc_flutter_app/constant/api.dart';
import 'package:whc_flutter_app/constant/app_color.dart';
import 'package:whc_flutter_app/http/http.dart';

class FeedbackRoute extends StatefulWidget {

  FeedbackRoute({Key key}):super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FeedbackRouteRouteState();
  }
}

class _FeedbackRouteRouteState extends State<FeedbackRoute> {

  TextEditingController _feedback = TextEditingController();
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _clickRegister() async {
    if (_feedback.text.isEmpty) {
      Alert.show(context, title: '请输入要反馈的内容！');
      return;
    }
    Loading.show(context);
    final res = await Http.post(path: Api.feedback, params: {
        'content': _feedback.text,
      }
    );
    Loading.close();
    Register register = Register.fromJson(res.body);
    if (register.code == 0) {
      Alert.show(context, title:'意见反馈成功');
    }else {
      Alert.show(context, title:register.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('意见反馈'),
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
                controller: _feedback,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: '请输入要反馈的内容',
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
                    onPressed: _clickRegister,
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