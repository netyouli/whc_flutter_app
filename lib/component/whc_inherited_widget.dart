/*
 * @copyright whc 2019
 * http://www.apache.org/licenses/LICENSE-2.0
 * https://github.com/netyouli/whc_flutter_app
 */
import 'package:flutter/material.dart';

class ListenChange {
  final List<VoidCallback> callbacks = List<VoidCallback>();

  void add(VoidCallback callback) {
    callbacks.add(callback);
  }

  void remove(VoidCallback callback) {
    callbacks.remove(callback);
  }

  void updateChange() {
    callbacks.forEach((callback) {
      callback();
    });
  }
}

class _InheritedWidget<T extends ListenChange> extends InheritedWidget {
  _InheritedWidget({
    Key key, 
    @required this.data, 
    @required Widget child
    }):super(key: key, child: child);

  final T data;

  @override
  bool updateShouldNotify(_InheritedWidget<T> oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }
}

class WHCInheritedData<T extends ListenChange> extends StatelessWidget {
  WHCInheritedData({Key key, @required this.builder}): assert(builder != null), super(key: key);
  final Widget Function(BuildContext context, T data) builder;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    T value = WHCInheritedWidget.of<T>(context, listen: true);
    return builder(context, value);
  }
}

class WHCInheritedWidget<T extends ListenChange> extends StatefulWidget {
  WHCInheritedWidget({
    Key key,
    @required this.child,
    @required this.data,
  }):super(key: key);

  final T data;
  final Widget child;

  static Type _typeOf<T>() => T;

  static T of<T extends ListenChange>(BuildContext context, {bool listen = false}) {
    final type = _typeOf<_InheritedWidget<T>>();
    _InheritedWidget<T> widget;
    if (listen) {
      widget = context.inheritFromWidgetOfExactType(type) as _InheritedWidget<T>;
    }else {
      widget = context.ancestorInheritedElementForWidgetOfExactType(type)?.widget as _InheritedWidget<T>;
    }
    assert((){
      if (widget == null) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('context listen error'),
          ErrorDescription(
            '当前context的父context不存在InheritedWidget组件'
          ),
          ErrorHint(
            '请提供子context对象来访问InheritedWidget组件'
          )
        ]);
      }
      return true;
    }());
    return widget.data;
  }

  @override
  _WHCInheritedWidgetState<T> createState() {
    // TODO: implement createState
    return _WHCInheritedWidgetState<T>();
  }
}

class _WHCInheritedWidgetState<T extends ListenChange> extends State<WHCInheritedWidget<T>> {
  void updateWidget() {
    try {
        if (this.context.size != null) {
          setState(() {});
        }
      } catch (e) {
        print(e);
      }
  }

  @override
  void initState() {
    // TODO: implement initState
    widget.data?.add(updateWidget);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget.data?.remove(updateWidget);
    super.dispose();
  }

  @override
  void didUpdateWidget(WHCInheritedWidget<T> oldWidget) {
    // TODO: implement didUpdateWidget
    if (oldWidget.data != widget.data) {
      oldWidget.data?.remove(updateWidget);
      widget.data?.add(updateWidget);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _InheritedWidget<T>(
      data: widget.data,
      child: widget.child,
    );
  }
}