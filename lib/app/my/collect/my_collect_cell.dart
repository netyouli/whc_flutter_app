/*
 * @copyright whc 2019
 * http://www.apache.org/licenses/LICENSE-2.0
 * https://github.com/netyouli/whc_flutter_app
 */
import 'package:flutter/material.dart';
import 'package:whc_flutter_app/app/my/collect/collect.dart';
import 'package:whc_flutter_app/constant/app_color.dart';
import 'package:whc_flutter_app/http/http.dart';

class MyCollectCell extends StatelessWidget {
  MyCollectCell({Key key, @required this.collect}): super(key: key);
  final CollectItem collect;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FlatButton(
      padding: EdgeInsets.all(0),
      onPressed: () {
        Navigator.of(context).pushNamed('web', arguments: {
          'title': collect.title,
          'url': collect.linkUrl,
        });
      },
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: Divider.createBorderSide(context, width: 0.5, color: AppColor.line)
          )
        ),
        child: Row(
          children: <Widget>[
            (collect.logoUrl?.isNotEmpty ?? false) ? Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.topLeft,
                child: Image.network(Http.share.baseUrl + collect.logoUrl, width: 50, height: 50, fit: BoxFit.fill,),
              ),
            ) : Container(),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(collect.title, style: TextStyle(fontSize: 18, color: AppColor.black),),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text('${collect.focusCount}人关注 * ${collect.author} * ${collect.date}', style: TextStyle(color: AppColor.deepGray, fontSize: 13),),
                  )
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Image.asset('images/right_arrow_icon.png', width: 20, height: 20,),
              ),
            )
          ],
        ),
      ),
    );
  }
}