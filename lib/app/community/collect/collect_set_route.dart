import 'dart:async';

import 'package:flutter/material.dart';
import 'package:whc_flutter_app/app/my/collect/collect.dart';
import 'package:whc_flutter_app/app/my/collect/my_collect_cell.dart';
import 'package:whc_flutter_app/component/loading.dart';
import 'package:whc_flutter_app/component/whc_refresh_list_view.dart';
import 'package:whc_flutter_app/constant/api.dart';
import 'package:whc_flutter_app/constant/app_color.dart';
import 'package:whc_flutter_app/http/http.dart';

class CollectSetRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CollectSetRouteState();
  }
}

class _CollectSetRouteState extends State<CollectSetRoute> {
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
      path: Api.collect
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
        title: Text('收藏集'),
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