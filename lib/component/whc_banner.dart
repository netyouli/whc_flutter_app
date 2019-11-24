/*
 * @copyright whc 2019
 * http://www.apache.org/licenses/LICENSE-2.0
 * https://github.com/netyouli/whc_flutter_app
 */
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:whc_flutter_app/component/whc_inherited_widget.dart';
import 'package:whc_flutter_app/constant/app_color.dart';

class _BannertIndexState extends ListenChange {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  set currentIndex(value) {
    _currentIndex = value;
    this.updateChange();
  }
}

class WHCBanner extends StatefulWidget {
  WHCBanner({
    Key key,
    @required this.images,
    this.height = 200,
    this.curve = Curves.linear,
    this.duration,
    this.pointNormalColor = Colors.white,
    this.pointSelectedColor = AppColor.theme,
  }): assert(images != null) ,super();

  final double height;
  final List<Widget> images;
  final Curve curve;
  final Duration duration;
  final Color pointNormalColor;
  final Color pointSelectedColor;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WHCBannerState();
  }
}

class _WHCBannerState extends State<WHCBanner> {
  PageController _pageController;
  int _currentIndex = 0;
  Timer _timer;
  _BannertIndexState _indexState = _BannertIndexState();

  void _initTimer() {
    if (widget.duration != null && _timer == null) {
      _timer = Timer.periodic(widget.duration, (timer){
        _currentIndex += 1;
        _indexState.currentIndex = _currentIndex;
        _pageController.animateToPage(_currentIndex, duration: Duration(milliseconds: 300), curve: widget.curve);
      });
    }
  }

  void _initPageController() {
    if (_pageController == null && widget.images.isNotEmpty) {
      _currentIndex = widget.images.length;
      _indexState._currentIndex = _currentIndex;
      _pageController = PageController(initialPage: widget.images.length);
      _initTimer();
    }
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
    _initTimer();
  }

  @override
  void initState() {
    // TODO: implement initState    
    super.initState();
    _initPageController();
  }

  @override
  void didUpdateWidget(WHCBanner oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    _initPageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement buill
    return WHCInheritedWidget(
      data: _indexState,
      child: Container(
        height: widget.height,
        child: widget.images.isEmpty ? null :
        GestureDetector(
          onPanDown: (detail) {
            _cancelTimer();
          },
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              PageView.builder(
                controller: _pageController,
                onPageChanged: (index){
                  _currentIndex = index;
                  if (index == 0) {
                    _currentIndex = widget.images.length; 
                    _pageController.jumpToPage(_currentIndex);
                  }
                  _indexState.currentIndex = _currentIndex;
                },
                itemBuilder: (context, index) {
                  _currentIndex = index;
                  return widget.images[index % widget.images.length];
                },
              ),
              WHCInheritedData<_BannertIndexState>(
                builder: (context, index){
                  return Positioned(
                    bottom: 15,
                    child: Row(
                      children: widget.images.map<Widget>((item){
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: ClipOval(
                            child: Container(
                              color: item == widget.images[index.currentIndex % widget.images.length] ? widget.pointSelectedColor : widget.pointNormalColor,
                              height: 8,
                              width: 8,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}