/*
 * @copyright whc 2019
 * http://www.apache.org/licenses/LICENSE-2.0
 * https://github.com/netyouli/whc_flutter_app
 */
class Collect {
  String messgae;
  int code;
  CollectData data;

  Collect({this.messgae, this.code, this.data});

  Collect.fromJson(Map<String, dynamic> json) {
    messgae = json['messgae'];
    code = json['code'];
    data = json['data'] != null ? new CollectData.fromJson(json['data']) : null;
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

class CollectData {
  List<CollectItem> list;

  CollectData({this.list});

  CollectData.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = new List<CollectItem>();
      json['list'].forEach((v) {
        list.add(new CollectItem.fromJson(v));
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

class CollectItem {
  String title;
  String date;
  int count;
  int focusCount;
  String author;
  String logoUrl;
  String linkUrl;

  CollectItem(
      {this.title,
      this.date,
      this.count,
      this.focusCount,
      this.author,
      this.logoUrl,
      this.linkUrl});

  CollectItem.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    date = json['date'];
    count = json['count'];
    focusCount = json['focusCount'];
    author = json['author'];
    logoUrl = json['logoUrl'];
    linkUrl = json['linkUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['date'] = this.date;
    data['count'] = this.count;
    data['focusCount'] = this.focusCount;
    data['author'] = this.author;
    data['logoUrl'] = this.logoUrl;
    data['linkUrl'] = this.linkUrl;
    return data;
  }
}