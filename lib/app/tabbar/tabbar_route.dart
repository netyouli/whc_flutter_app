
/*
 * @copyright whc 2019
 * http://www.apache.org/licenses/LICENSE-2.0
 * https://github.com/netyouli/whc_flutter_app
 */
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:whc_flutter_app/app/community/community_route.dart';
import 'package:whc_flutter_app/app/home/home_route.dart';
import 'package:whc_flutter_app/app/my/my_route.dart';

class TabbarRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TabbarRouteState();
  }
}

class _TabbarRouteState extends State<TabbarRoute> {

  int _currentIndex = 0;
  final List<StatefulWidget> _routes = [HomeRoute(), CommunityRoute(), MyRoute()];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
          BottomNavigationBarItem(icon: Image.asset('images/community_normal_icon.png',width: 24,height: 24,fit: BoxFit.scaleDown,), activeIcon: Image.asset('images/community_selected_icon.png',width: 24,height: 24,fit: BoxFit.scaleDown,), title: Text('社区')),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('我的')),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
      ),
      body: _routes[_currentIndex],
    );
  }
}