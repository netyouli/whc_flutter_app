import 'package:flutter/material.dart';
import 'package:whc_flutter_app/app/home/home.dart';
import 'package:whc_flutter_app/component/whc_inherited_widget.dart';
import 'package:whc_flutter_app/constant/app_color.dart';
import 'package:whc_flutter_app/http/http.dart';

class HomeCell extends StatelessWidget {
  HomeCell({Key key, @required this.item}) : 
  assert(item != null) , 
  super(key: key);

  final HomeItem item;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WHCInheritedWidget(
      data: item,
      child: FlatButton(
        padding: EdgeInsets.all(0),
        onPressed: (){
          Navigator.of(context).pushNamed('web', arguments: {
            'title': item.title,
            'url': item.linkUrl,
          });
        },
        child: Column(
          children: <Widget>[
            Divider(
              height: 20,
              color: Colors.transparent,
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      ClipOval(
                        child: Image.network(Http.share.baseUrl + item.userIcon, width: 35, height: 35,),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(item.author, style: TextStyle(color: AppColor.deepGray),),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('发布日期：${item.date}', style: TextStyle(color: AppColor.deepGray),),
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 20, color: Colors.transparent,),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(item.title, maxLines: 1, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                            Divider(height: 10, color: Colors.transparent,),
                            Text(item.detail, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColor.deepGray),)
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(Http.share.baseUrl + item.logoUrl, width: 100, height: 100, fit: BoxFit.fill,),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Builder(builder: (context){
                        return FlatButton.icon(
                          onPressed: (){
                            HomeItem item = WHCInheritedWidget.of<HomeItem>(context);
                            item.collectionCount += 1;
                            item.updateChange();
                          },
                          padding: EdgeInsets.all(0),
                          icon: Image.asset('images/collection_icon.png', width: 20, height: 20,),
                          label: WHCInheritedData<HomeItem>(
                            builder: (context, value){
                              return Text(value.collectionCount.toString(), style: TextStyle(color: AppColor.deepGray));
                            },
                          )
                        );
                      }),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                      ),
                      Builder(builder: (context){
                        return FlatButton.icon(
                          onPressed: (){
                            HomeItem item = WHCInheritedWidget.of<HomeItem>(context);
                            item.msgCount += 1;
                            item.updateChange();
                          },
                          padding: EdgeInsets.all(0),
                          icon: Image.asset('images/msg_icon.png', width: 20, height: 20,),
                          label: WHCInheritedData<HomeItem>(builder: (context, value){
                            return Text(value.msgCount.toString(), style: TextStyle(color: AppColor.deepGray),);
                          }),
                        );
                      })
                    ],
                  ),
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}