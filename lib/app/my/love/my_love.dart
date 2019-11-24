/*
 * @copyright whc 2019
 * http://www.apache.org/licenses/LICENSE-2.0
 * https://github.com/netyouli/whc_flutter_app
 */
class MyLove {
  String messgae;
  int code;
  LoveData data;

  MyLove({this.messgae, this.code, this.data});

  MyLove.fromJson(Map<String, dynamic> json) {
    messgae = json['messgae'];
    code = json['code'];
    data = json['data'] != null ? new LoveData.fromJson(json['data']) : null;
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

class LoveData {
  List<Love> list;

  LoveData({this.list});

  LoveData.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = new List<Love>();
      json['list'].forEach((v) {
        list.add(new Love.fromJson(v));
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

class Love {
  String title;
  String image;
  int loveNum;
  String time;
  String organizeName;
  String linkUrl;

  Love(
      {this.title,
      this.image,
      this.loveNum,
      this.time,
      this.organizeName,
      this.linkUrl});

  Love.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    loveNum = json['loveNum'];
    time = json['time'];
    organizeName = json['organizeName'];
    linkUrl = json['linkUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['image'] = this.image;
    data['loveNum'] = this.loveNum;
    data['time'] = this.time;
    data['organizeName'] = this.organizeName;
    data['linkUrl'] = this.linkUrl;
    return data;
  }
}