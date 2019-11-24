/*
 * @copyright whc 2019
 * http://www.apache.org/licenses/LICENSE-2.0
 * https://github.com/netyouli/whc_flutter_app
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:whc_flutter_app/app/my/love/my_love.dart';
import 'package:whc_flutter_app/app/my/love/my_love_cell.dart';
import 'package:whc_flutter_app/component/loading.dart';
import 'package:whc_flutter_app/component/whc_refresh_list_view.dart';
import 'package:whc_flutter_app/constant/api.dart';
import 'package:whc_flutter_app/constant/app_color.dart';
import 'package:whc_flutter_app/http/http.dart';

class ActivityOfflineRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ActivityOfflineRouteState();
  }
}

class _ActivityOfflineRouteState extends State<ActivityOfflineRoute> {
  List<Love> _loves;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(milliseconds: 200), (){
      _requestList();
    });
  }

  Future<void> _requestList() {
    Loading.show(context);
    return Http.get(
      path: Api.offineActivity
    ).then((res){
      Loading.close();
      MyLove love = MyLove.fromJson(res.body);
      setState(() {
        _loves = love.data?.list;
      });
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        title: Text('线下活动'),
      ),
      body: Container(
        width: double.infinity,
        color: AppColor.back,
        child: WHCRefreshListView(
          onRefresh: _requestList,
          itemCount: _loves?.length ?? 0,
          itemBuilder: (context, index) {
            return MyLoveCell(love: _loves[index],);
          },
        ),
      ),
    );
  }
}