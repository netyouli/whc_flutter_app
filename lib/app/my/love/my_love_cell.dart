/*
 * @copyright whc 2019
 * http://www.apache.org/licenses/LICENSE-2.0
 * https://github.com/netyouli/whc_flutter_app
 */
import 'package:flutter/material.dart';
import 'package:whc_flutter_app/app/my/love/my_love.dart';
import 'package:whc_flutter_app/constant/app_color.dart';
import 'package:whc_flutter_app/http/http.dart';

class MyLoveCell extends StatelessWidget {
  MyLoveCell({Key key, @required this.love}): super(key: key);
  final Love love;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FlatButton(
      padding: EdgeInsets.all(0),
      onPressed: () {
        Navigator.of(context).pushNamed('web', arguments: {
          'title': love.title,
          'url': love.linkUrl,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(love.title, style: TextStyle(fontSize: 18, color: AppColor.black),),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text('${love.loveNum}人喜欢 * ${love.organizeName} * ${love.time}', style: TextStyle(color: AppColor.deepGray, fontSize: 13),),
                  )
                ],
              ),
            ),
            (love.image?.isNotEmpty ?? false) ? Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.topRight,
                child: Image.network(Http.share.baseUrl + love.image, width: 50, height: 50, fit: BoxFit.fill,),
              ),
            ) : Container(),
          ],
        ),
      ),
    );
  }
}