/*
 * @copyright whc 2019
 * http://www.apache.org/licenses/LICENSE-2.0
 * https://github.com/netyouli/whc_flutter_app
 */
import 'package:whc_flutter_app/component/whc_inherited_widget.dart';

class Home {
  String messgae;
  int code;
  HomeData data;

  Home({this.messgae, this.code, this.data});

  Home.fromJson(Map<String, dynamic> json) {
    messgae = json['messgae'];
    code = json['code'];
    data = json['data'] != null ? new HomeData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messgae'] = this.messgae;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class HomeData {
  List<HomeItem> list;

  HomeData({this.list});

  HomeData.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = new List<HomeItem>();
      json['list'].forEach((v) {
        list.add(new HomeItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HomeItem extends ListenChange {
  String title;
  String author;
  String date;
  String detail;
  String logoUrl;
  String userIcon;
  int msgCount;
  String linkUrl;
  int collectionCount;

  HomeItem(
      {this.title,
      this.author,
      this.date,
      this.detail,
      this.logoUrl,
      this.userIcon,
      this.msgCount,
      this.linkUrl,
      this.collectionCount});

  HomeItem.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    author = json['author'];
    date = json['date'];
    detail = json['detail'];
    logoUrl = json['logoUrl'];
    userIcon = json['userIcon'];
    msgCount = json['msgCount'];
    linkUrl = json['linkUrl'];
    collectionCount = json['collectionCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['author'] = this.author;
    data['date'] = this.date;
    data['detail'] = this.detail;
    data['logoUrl'] = this.logoUrl;
    data['userIcon'] = this.userIcon;
    data['msgCount'] = this.msgCount;
    data['linkUrl'] = this.linkUrl;
    data['collectionCount'] = this.collectionCount;
    return data;
  }
}