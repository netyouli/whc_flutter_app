import 'package:flutter/material.dart';
import 'package:whc_flutter_app/component/whc_inherited_widget.dart';

class _WHCRefreshListViewLoadingMore extends ListenChange {
  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;
  set loadingMore(bool value) {
    _loadingMore = true;
    this.updateChange();
  }
}

class WHCRefreshListView extends StatefulWidget {

  WHCRefreshListView({
    Key key,
    this.onRefresh,
    this.onLoadingMore,
    @required this.itemCount,
    @required this.itemBuilder,
  }): super(key: key);

  final Future<void> Function() onRefresh;
  final Future<void> Function() onLoadingMore;
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;

  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WHCRefreshListViewState();
  }
}

class _WHCRefreshListViewState extends State<WHCRefreshListView> {
  ScrollController _controller;
  _WHCRefreshListViewLoadingMore _loadingMore;

  @override
  void initState() {
    super.initState();
    if (widget.onLoadingMore != null) {
      _loadingMore = _WHCRefreshListViewLoadingMore();
      _controller = ScrollController();
      _controller.addListener((){
        if (_controller.position.pixels == _controller.position.maxScrollExtent) {
          _loadingMore.loadingMore = true;
          widget.onLoadingMore().then((v) {
            _loadingMore.loadingMore = false;  
          });
        }else {
          _loadingMore.loadingMore = false;
        }
      });
    }
  }

  Widget _itemBuilder(BuildContext context, int index) {
    if (widget.itemCount > index) {
      return widget.itemBuilder(context,index);
    }
    return Builder(
      builder: (context){
        return WHCInheritedData<_WHCRefreshListViewLoadingMore>(
          builder: (context, state) {
            return state.loadingMore ?
            Container(
              height: 44,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(strokeWidth: 3,),
                  )
                ],
              ),
            ) : Container();
          },
        );
      },
    );
  }

  Widget _makeList() {
    return ListView.builder(
      controller: _controller,
      padding: EdgeInsets.all(0),
      itemCount: widget.itemCount + (widget.onLoadingMore != null ? 1 : 0),
      itemBuilder: _itemBuilder,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WHCInheritedWidget(
      data: _loadingMore,
      child: widget.onRefresh != null ?
       RefreshIndicator(
        onRefresh: widget.onRefresh,
        child: _makeList(),
       ) : 
       _makeList(),
    );
  }
}