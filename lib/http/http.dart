
/*
 * @copyright whc 2019
 * http://www.apache.org/licenses/LICENSE-2.0
 * https://github.com/netyouli/whc_flutter_app
 */
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class Response {
  int _statusCode = 0;
  int get statusCode => _statusCode;
  set statusCode(value) => _statusCode = value;

  dynamic _error;
  dynamic get error => _error;
  set error(value) => _error = value;

  String _text;
  String get text => _text;
  set text(value) => _text = value;

  dynamic _body;
  dynamic get body => _body;
  set body(value) => _body = value;
}

class Http {
  HttpClient _client;
  String _scheme;
  String _host;
  String _path;
  int _port;
  String baseUrl;
  String userAgent;
  bool autoUncompress = true;
  int maxConnectionsPerHost;
  Duration connectionTimeout = Duration(seconds: 30);
  Duration idleTimeout = Duration(seconds: 15);
  /// 全局默认header参数
  Map<String,String> headers = Map<String, String>();
  /// 全局默认body参数
  Map<String, dynamic> bodys = Map<String, dynamic>();

  static final Http share = Http();
  
  HttpClient _configClient() {
    _client ??= HttpClient();
    if (_scheme == null || _host == null) {
      int schemeEnd = baseUrl.indexOf('://');
      if (schemeEnd != -1) {
        _scheme = baseUrl.substring(0, schemeEnd);
        RegExp reg = RegExp(r':[0-9]+');
        Iterable<Match> matchs = reg.allMatches(baseUrl);
        if (matchs.isNotEmpty) {
          _port = int.parse(matchs.last.group(0).replaceAll(':', ''));
        }
        reg = RegExp(r'//[_.a-zA-Z0-9]+(/)?');
        matchs = reg.allMatches(baseUrl);
        if (matchs.isNotEmpty) {
          _host = matchs.last.group(0).replaceAll('/', '');
        }
        if (_scheme != null && _host != null) {
          String main = _port != null ? '$_scheme://$_host:$_port' : '$_scheme://$_host';
          _path = baseUrl.substring(main.length);
        }
      }
    }
    _client.userAgent = userAgent;
    _client.autoUncompress = autoUncompress;
    _client.maxConnectionsPerHost = maxConnectionsPerHost;
    _client.connectionTimeout = connectionTimeout;
    _client.idleTimeout = idleTimeout;
    return _client;
  }

  static dynamic _checkResult(String result) {
    if (result != null && result.length > 1) {
      int s = result.indexOf(RegExp(r'\s*(\[|\{)'));
      int e = result.lastIndexOf(RegExp(r'(\]|\})\s*'));
      if (s == 0 && e > 0 && e < result.length) {
        return json.decode(result);
      }
    }
    return result;
  }

  static String _makeUrlEncode(String name, dynamic object) {
    String kvstr = '';
    if (object is Map<String, dynamic>) {
      object.forEach((key, value){
        String curname = '$name$key';
        kvstr += _makeUrlEncode('${Uri.encodeComponent(curname)}.', value);
      });
    }else if (object is List<dynamic>) {
      for(int i = 0; i < object.length; i++) {
        String curname = (name.lastIndexOf('.') == name.length - 1) ?
         '${name.substring(0, name.length - 1)}[$i]' : '$name[$i]';
        kvstr += _makeUrlEncode('${Uri.encodeComponent(curname)}.', object[i]);
      }
    }else {
      if (name.lastIndexOf('.') == name.length - 1) {
        kvstr += '${name.substring(0, name.length - 1)}=${Uri.encodeComponent(object.toString())}&';
      }else {
        kvstr += '$name=${Uri.encodeComponent(object.toString())}&';
      }
    }
    return kvstr;
  }

  static bool _isPlainAscii(String string) => RegExp(r'^[\x00-\x7F]+$').hasMatch(string);

  static String _browserEncode(String value) {
    return value.replaceAll(RegExp(r'\r\n|\r|\n'), '%0D%0A').replaceAll('"', '%22');
  }

  static String _headerForField(String name, String value) {
    var header = 'content-disposition: form-data; name="${_browserEncode(name)}"';
    if (!_isPlainAscii(header)) {
      header = '$header\r\n'
      'content-type: text/plain; charset=utf-8\r\n'
      'content-transfer-encoding: binary';
    }
    return '$header\r\n\r\n$value';
  }

  static String _makeFromEncode(String name, dynamic object, String boundary) {
    String kvstr = '';
    if (object is Map<String, dynamic>) {
      object.forEach((key, value){
        String curname = '$name$key';
        kvstr += _makeFromEncode('$curname.', value, boundary);
      });
    }else if (object is List<dynamic>) {
      for(int i = 0; i < object.length; i++) {
        String curname = (name.lastIndexOf('.') == name.length - 1) ?
         '${name.substring(0, name.length - 1)}[$i]' : '$name[$i]';
        kvstr += _makeFromEncode('$curname.', object[i], boundary);
      }
    }else {
      const line = '\r\n';
      final separator = '--$boundary\r\n';
      kvstr += separator;
      if (name.lastIndexOf('.') == name.length - 1) {
        kvstr += _headerForField(name.substring(0, name.length - 1), object.toString());
        kvstr += line;
      }else {
        kvstr += _headerForField(name, object.toString());
        kvstr += line;
      }
    }
    return kvstr;
  }

  static Future<Response> _request({
    Future<HttpClientRequest> frequest,
    Map<String, dynamic> params,
    Map<String,String> headers,
    }) async {
      Response res = Response();
      assert(frequest != null);
      return frequest
        .then((request){
          share.headers?.forEach((key, value){
            request.headers.set(key, value);
          });
          headers?.forEach((key, value){
            request.headers.set(key, value);
          });
          var contentType = request.headers.contentType;
          if (!['GET', 'HEAD'].contains(request.method)) {
            Map<String, dynamic> map = Map<String, dynamic>();
            if (share.bodys != null) {
              map.addAll(share.bodys);
            }
            if (params != null) {
              map.addAll(params);
            }
            if (contentType.value == 'application/json') {
                request.write(json.encode(share.bodys));
            }else if (contentType.value == 'application/x-www-form-urlencoded') {
              String paramstr = _makeUrlEncode('', map);
              if (paramstr.isNotEmpty) {
                paramstr = paramstr.substring(0, paramstr.length - 1);
                request.write(paramstr);
              }
            }else if (contentType.value == 'multipart/form-data'){
              String boundary = 'whc-http-boundary-${DateTime.now().millisecondsSinceEpoch}';
              final close = '--$boundary--\r\n';
              request.headers.set('content-type', 'multipart/form-data;boundary=$boundary');
              String paramstr = _makeFromEncode('', map, boundary);
              paramstr += close;
              if (paramstr.isNotEmpty) {
                request.write(paramstr);
              }
            }else {
              throw FlutterError.fromParts(<DiagnosticsNode>[
                ErrorSummary('contentType 类型错误暂时不支持${contentType.value}'),
                ErrorDescription(
                  '目前只支持（application/json，application/x-www-form-urlencoded, multipart/form-data）类型'
                )
              ]);
            }
          }
          return request.close();
        }, onError: (error){
          print('Http request error: $error');
          res.error = error;
          return res;
        }).then((response){
          res.statusCode = response.statusCode;
          return response.transform(utf8.decoder).join();
        }, onError: (error){
          print('Http response error: $error');
          res.error = error;
          return res;
        }).then((result){
          res.text = result;
          res.body = _checkResult(result);
          return res;
        }, onError:(error) {
          print('Http response transform error: $error');
          res.error = error;
          return res;
        });
    }

  static Future<Response> get({
    String path = '',
    Map<String, dynamic> params,
    Map<String,String> headers,
    }) async {
    HttpClient client = share._configClient();
    bool hasHttpPrefix = path.indexOf(RegExp(r'http(s)?://')) == 0;
    Uri uri = hasHttpPrefix ? 
    Uri.parse(path) : 
    Uri(
      scheme: share._scheme, 
      host: share._host, 
      port: share._port, 
      path: share._path + path, 
      queryParameters: params
    );
    return _request(
      frequest: client.getUrl(uri),
      params: params,
      headers: headers
    );
  }

  static Future<Response> post({
    String path = '',
    Map<String, dynamic> params,
    Map<String,String> headers,
    }) async {
    HttpClient client = share._configClient();
    bool hasHttpPrefix = path.indexOf(RegExp(r'http(s)?://')) == 0;
    Uri uri = hasHttpPrefix ? Uri.parse(path) : Uri.parse(share.baseUrl + path);
    return _request(
      frequest: client.postUrl(uri),
      headers: headers,
      params: params,
    );
  }

  static Future<Response> put({
    String path = '',
    Map<String, dynamic> params,
    Map<String,String> headers,
    }) async {
    HttpClient client = share._configClient();
    bool hasHttpPrefix = path.indexOf(RegExp(r'http(s)?://')) == 0;
    Uri uri = hasHttpPrefix ? Uri.parse(path) : Uri.parse(share.baseUrl + path);
    return _request(
      frequest: client.putUrl(uri),
      headers: headers,
      params: params,
    );
  }

  static Future<Response> delete({
    String path = '',
    Map<String, dynamic> params,
    Map<String,String> headers,
    }) async {
    HttpClient client = share._configClient();
    bool hasHttpPrefix = path.indexOf(RegExp(r'http(s)?://')) == 0;
    Uri uri = hasHttpPrefix ? Uri.parse(path) : Uri.parse(share.baseUrl + path);
    return _request(
      frequest: client.deleteUrl(uri),
      headers: headers,
      params: params,
    );
  }

  static Future<Response> patch({
    String path = '',
    Map<String, dynamic> params,
    Map<String,String> headers,
    }) async {
    HttpClient client = share._configClient();
    bool hasHttpPrefix = path.indexOf(RegExp(r'http(s)?://')) == 0;
    Uri uri = hasHttpPrefix ? Uri.parse(path) : Uri.parse(share.baseUrl + path);
    return _request(
      frequest: client.patchUrl(uri),
      headers: headers,
      params: params,
    );
  }

  static Future<Response> head({
    String path = '',
    Map<String,String> headers,
    }) async {
    HttpClient client = share._configClient();
    bool hasHttpPrefix = path.indexOf(RegExp(r'http(s)?://')) == 0;
    Uri uri = hasHttpPrefix ? Uri.parse(path) : Uri.parse(share.baseUrl + path);
    return _request(
      frequest: client.headUrl(uri),
      headers: headers,
    );
  }
}