/*
 * @copyright whc 2019
 * http://www.apache.org/licenses/LICENSE-2.0
 * https://github.com/netyouli/whc_flutter_app
 */
import 'package:whc_flutter_app/app/my/login/login.dart';
import 'package:whc_flutter_app/app/store/store.dart';
import 'package:whc_flutter_app/constant/api.dart';
import 'package:whc_flutter_app/http/http.dart';

class User {
  static Login login;
  static bool didLogin() => Http.share.bodys['token'] != null;

  static saveLogin(Login login) {
    User.login = login;
    Http.share.bodys['token'] = login.token;
  }

  static exitLogin() {
    Http.share.bodys['token'] = null;
  }

  static autoLogin() async {
    String username = await Store.get('username');
    String password = await Store.get('password');
    if (username != null && password != null) {
      Http.post(
        path: Api.login,
        params: {
          'username': username,
          'password': password,
        }
      ).then((res) {
        login = Login.fromJson(res.body);
        Http.share.bodys['token'] = login.token;
      });
    }
  }
}