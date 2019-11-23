
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Alert {
  static Alert _share = Alert();
  BuildContext _context;
  Timer _timer;

  void _initTimer(int sec) {
    _timer?.cancel();
    _timer = Timer(Duration(seconds: sec), () {
      _dismissOldAlert();
    });
  }

  void _dismissOldAlert() {
    if (_context != null) {
      Navigator.of(_context).pop();
      _context = null;
    }
  }

  static Future<int> show(
    BuildContext context, {
      String title, 
      String content, 
      List<String> btnTitles, 
      bool barrierDismissible = false,
      int seconds = 3,
      void Function(int index) block,
    }) {
      if (btnTitles == null) {
        _share._dismissOldAlert();
        _share._context = context;
        _share._initTimer(seconds);
      }
      return showDialog<int>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          List<Widget> actions = <Widget>[];
          if (btnTitles != null) {
            for (var i = 0; i < btnTitles.length; i++) {
              actions.add(FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(i);
                  if (block != null) {
                    block(i);
                  }
                },
                child: Text(btnTitles[i]),
              )); 
            }
          }
          return CupertinoAlertDialog(
            title: title != null ? Text(title) : null,
            content: content != null ? Text(content) : null,
            actions: actions,
          );
        }
      );
  }

}