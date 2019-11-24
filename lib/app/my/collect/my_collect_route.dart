/*
 * @copyright whc 2019
 * http://www.apache.org/licenses/LICENSE-2.0
 * https://github.com/netyouli/whc_flutter_app
 */
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:whc_flutter_app/app/my/collect/collect.dart';
import 'package:whc_flutter_app/app/my/collect/my_collect_cell.dart';
import 'package:whc_flutter_app/component/loading.dart';
import 'package:whc_flutter_app/component/whc_refresh_list_view.dart';
import 'package:whc_flutter_app/constant/api.dart';
import 'package:whc_flutter_app/constant/app_color.dart';
import 'package:whc_flutter_app/http/http.dart';

class MyCollectRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyCollectRouteState();
  }
}

class _MyCollectRouteState extends State<MyCollectRoute> {
  List<CollectItem> _collects;
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
      path: Api.myCollect
    ).then((res){
      Loading.close();
      Collect collect = Collect.fromJson(res.body);
      setState(() {
        _collects = collect.data?.list;
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
        title: Text('我的收藏集'),
      ),
      body: Container(
        width: double.infinity,
        color: AppColor.back,
        child: WHCRefreshListView(
          onRefresh: _requestList,
          itemCount: _collects?.length ?? 0,
          itemBuilder: (context, index) {
            return MyCollectCell(collect: _collects[index],);
          },
        ),
      ),
    );
  }
}