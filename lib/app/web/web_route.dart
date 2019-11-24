/*
 * @copyright whc 2019
 * http://www.apache.org/licenses/LICENSE-2.0
 * https://github.com/netyouli/whc_flutter_app
 */
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:whc_flutter_app/component/loading.dart';
import 'package:whc_flutter_app/component/whc_inherited_widget.dart';
import 'package:whc_flutter_app/constant/app_color.dart';

class _WebTitle extends ListenChange {
  String _title;
  String get title => _title;
  set title(value) {
    _title = value;
    this.updateChange();
  }
}

class WebRoute extends StatefulWidget {
  WebRoute({Key key, @required this.url, @required this.title}) : super(key:key);
  final String url;
  final String title;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WebRouteState();
  }
}

class _WebRouteState extends State<WebRoute> {
  String _url;
  WebViewController _controller;
  _WebTitle _titleState = _WebTitle();
  bool _loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleState.title = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WHCInheritedWidget(
      data: _titleState,
      child: Scaffold(
        appBar: AppBar(
          title: WHCInheritedData<_WebTitle>(
            builder: (context, value){
              return Text(value.title);
            },
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            bool back = await _controller.canGoBack();
            if (back) {
              _controller.goBack();
              return false;
            }
            return true;
          },
          child: Container(
            color: AppColor.back,
            child: WebView(
              navigationDelegate: (request) {
                if (request.url != _url && !_loading) {
                  _loading = true;
                  Loading.show(context);
                }
                return NavigationDecision.navigate;
              },
              onWebViewCreated: (controller) {
                _controller = controller;
              },
              onPageFinished: (url) {
                _controller.evaluateJavascript("document.title").then((result){
                  _url = url;
                  Loading.close();
                  //_loading = false;
                  _titleState.title = result;
                });
              },
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
        ),
      ),
    );
  }
}