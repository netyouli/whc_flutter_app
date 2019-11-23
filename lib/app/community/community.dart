import 'package:whc_flutter_app/app/my/love/my_love.dart';

class Community {
  String messgae;
  int code;
  CommunityData data;

  Community({this.messgae, this.code, this.data});

  Community.fromJson(Map<String, dynamic> json) {
    messgae = json['messgae'];
    code = json['code'];
    data = json['data'] != null ? new CommunityData.fromJson(json['data']) : null;
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

class CommunityData {
  List<BannerItem> banner;
  List<Love> hotArticle;

  CommunityData({this.banner, this.hotArticle});

  CommunityData.fromJson(Map<String, dynamic> json) {
    if (json['banner'] != null) {
      banner = new List<BannerItem>();
      json['banner'].forEach((v) {
        banner.add(new BannerItem.fromJson(v));
      });
    }
    if (json['hot_article'] != null) {
      hotArticle = new List<Love>();
      json['hot_article'].forEach((v) {
        hotArticle.add(new Love.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.banner != null) {
      data['banner'] = this.banner.map((v) => v.toJson()).toList();
    }
    if (this.hotArticle != null) {
      data['hot_article'] = this.hotArticle.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannerItem {
  String imageUrl;
  String linkUrl;

  BannerItem({this.imageUrl, this.linkUrl});

  BannerItem.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
    linkUrl = json['link_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_url'] = this.imageUrl;
    data['link_url'] = this.linkUrl;
    return data;
  }
}

