/*
 * @copyright whc 2019
 * http://www.apache.org/licenses/LICENSE-2.0
 * https://github.com/netyouli/whc_flutter_app
 */
import 'package:whc_flutter_app/component/whc_inherited_widget.dart';

class Login extends ListenChange{
  String token;
  String message;
  int code;
  String image;
  String username;
  String detail;
  int lovenum;
  int collectnum;
  int readnum;
  String email;
  String mobile;

  Login(
      {this.token,
      this.message,
      this.code,
      this.image,
      this.username,
      this.detail,
      this.lovenum,
      this.collectnum,
      this.readnum,
      this.email,
      this.mobile});

  Login.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    message = json['message'];
    code = json['code'];
    image = json['image'];
    username = json['username'];
    detail = json['detail'];
    lovenum = json['lovenum'];
    collectnum = json['collectnum'];
    readnum = json['readnum'];
    email = json['email'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['message'] = this.message;
    data['code'] = this.code;
    data['image'] = this.image;
    data['username'] = this.username;
    data['detail'] = this.detail;
    data['lovenum'] = this.lovenum;
    data['collectnum'] = this.collectnum;
    data['readnum'] = this.readnum;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    return data;
  }

  void copySelf(Login login) {
    if (login != null) {
      this.token = login.token;
      this.message = login.message;
      this.code = login.code;
      this.image = login.image;
      this.username = login.username;
      this.detail = login.detail;
      this.lovenum = login.lovenum;
      this.collectnum = login.collectnum;
      this.readnum = login.readnum;
      this.email = login.email;
      this.mobile = login.mobile;
      updateChange();
    }
  }
}