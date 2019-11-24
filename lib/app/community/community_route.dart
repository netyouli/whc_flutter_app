/*
 * @copyright whc 2019
 * http://www.apache.org/licenses/LICENSE-2.0
 * https://github.com/netyouli/whc_flutter_app
 */

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whc_flutter_app/app/community/community.dart';
import 'package:whc_flutter_app/app/my/love/my_love_cell.dart';
import 'package:whc_flutter_app/component/loading.dart';
import 'package:whc_flutter_app/component/whc_banner.dart';
import 'package:whc_flutter_app/constant/api.dart';
import 'package:whc_flutter_app/constant/app_color.dart';
import 'package:whc_flutter_app/http/http.dart';

class CommunityRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CommunityRouteState();
  }
}

class _CommunityRouteState extends State<CommunityRoute> {

  Community _community;

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
      path: Api.community,
    ).then((res){
      Loading.close();
      if (res.body != null) {
        setState(() {
          _community = Community.fromJson(res.body);
        });
      }
      return;
    });
  }

  List<Widget> _makeMenu() {
    var list = List<Widget>();
    var titles = ['本周最热', '收藏集', '线下活动', '专栏'];
    var images = ['images/community_hot_icon.png', 'images/community_collect_icon.png', 'images/community_active_icon.png', 'images/community_column_icon.png'];
    for(int i = 0; i < titles.length; i++) {
      var title = titles[i];
      var image = images[i];
      list.add(
        Expanded(
          child: FlatButton(
            onPressed: (){
              switch (i) {
                case 0: // 本周最热
                    Navigator.of(context).pushNamed('weekhot');
                  break;
                case 1: // 收藏集
                    Navigator.of(context).pushNamed('collectset');
                  break;
                case 2: // 线下活动
                    Navigator.of(context).pushNamed('activityoffline');
                  break;
                case 3: // 专栏
                  Navigator.of(context).pushNamed('column');
                  break;
              }
            },
            child: Column(
              children: <Widget>[
                Image.asset(image, width: 30, height: 30, fit: BoxFit.cover,),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(title, style: TextStyle(fontSize: 13),),
                )
              ],
            ),
          ),
        )
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('社区'),
      ),
      body: RefreshIndicator(
        onRefresh: _requestList,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: WHCBanner(
                height: 200,
                duration: Duration(seconds: 3),
                images: (_community?.data?.banner ?? List<Widget>()).map<Image>((item){
                  var it = item as BannerItem;
                  return Image.network(Http.share.baseUrl + it.imageUrl, fit: BoxFit.fill,); 
                }).toList(),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: _makeMenu(),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 20,
                color: AppColor.line,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Row(
                  children: <Widget>[
                    Image.asset('images/community_hot_section_icon.png', width: 20, height: 20,),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text('热门文章'),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Image.asset('images/community_set_icon.png', width: 15, height: 15, fit: BoxFit.fill,),
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text('定制热门', style: TextStyle(color: AppColor.gray),),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return MyLoveCell(love: _community.data.hotArticle[index],);
                },
                childCount: _community?.data?.hotArticle?.length ?? 0
              ),
            )
          ],
        ),
      )
    );
  }
}