

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:whc_flutter_app/app/home/home.dart';
import 'package:whc_flutter_app/app/home/home_cell.dart';
import 'package:whc_flutter_app/component/loading.dart';
import 'package:whc_flutter_app/component/whc_refresh_list_view.dart';
import 'package:whc_flutter_app/constant/api.dart';
import 'package:whc_flutter_app/constant/app_color.dart';
import 'package:whc_flutter_app/http/http.dart';

class ColumnRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ColumnRouteState();
  }
}

class _ColumnRouteState extends State<ColumnRoute> {

  List<HomeItem> _homes;

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
      path: Api.specialColumn
    ).then((res){
      Loading.close();
      if (res.body != null) {
        setState(() {
          _homes = Home.fromJson(res.body)?.data?.list;
        });
      }
      return;
    });
  }

  Widget _itemBuilder(BuildContext context, int index) {
    HomeItem item = _homes[index];
    return HomeCell(item: item);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        title: Text('专栏'),
      ),
      body: Container(
        width: double.infinity,
        color: AppColor.back,
        child: WHCRefreshListView(
          onRefresh: _requestList,
          itemCount: _homes?.length ?? 0,
          itemBuilder: _itemBuilder,
        ),
      ),
    );
  }
}