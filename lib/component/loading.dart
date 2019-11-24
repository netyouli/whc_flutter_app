/*
 * @copyright whc 2019
 * http://www.apache.org/licenses/LICENSE-2.0
 * https://github.com/netyouli/whc_flutter_app
 */
import 'package:flutter/material.dart';

class Loading {

  static BuildContext _context;

  static void close([BuildContext context]) {
    if (context != null) {
      Navigator.of(context).pop();
    }
    if (_context != null) {
      Navigator.of(_context).pop();
      _context = null;
    }
  }

  static void show(BuildContext context, {
    bool barrierDismissible = false,
  }) {
    assert(context != null);
    _context = context;
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return UnconstrainedBox(
          constrainedAxis: Axis.vertical,
          child: Container(
            width: 180,
            child: AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircularProgressIndicator(
                    strokeWidth: 4.0,
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}