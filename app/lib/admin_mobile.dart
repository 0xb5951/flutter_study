import 'package:flutter/material.dart';

class AdminMobilePage extends StatefulWidget {
  @override
  _AdminMobilePageState createState() => _AdminMobilePageState();
}

class _AdminMobilePageState extends State<AdminMobilePage> {
  @override
  Widget build(Object context) {
    return Scaffold(
      body: Row(
        children: [SideBar()],
      ),
    );
  }
}

class SideBar extends StatefulWidget {
  @override
  _SideBar createState() => _SideBar();
}

class _SideBar extends State<SideBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      // 現在選択されている要素のインデックス
      selectedIndex: selectedIndex,
      // 要素がタップされたときに呼び出される
      onDestinationSelected: (index) {
        selectedIndex = index;
      },
      destinations: [
        NavigationRailDestination(
            icon: Icon(Icons.people), label: Text("People")),
        NavigationRailDestination(
            icon: Icon(Icons.thumbs_up_down), label: Text("Thunb up down")),
        NavigationRailDestination(icon: Icon(Icons.face), label: Text("Face")),
        NavigationRailDestination(
            icon: Icon(Icons.bookmark), label: Text("bookmark")),
      ],
    );
  }
}

class _PostHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 要素にぶつかるまでいっぱいに広げる。Row, Columnで使う
        Expanded(
          flex: 1,
          child: ListTile(
            title: Text("Post"),
            subtitle: Text("20 Post"),
            leading: ClipOval(
              //子要素をくり抜く
              child: Container(
                color: Colors.grey[300],
                width: 48,
                height: 48,
                child: Icon(
                  Icons.storage,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: ListTile(
            title: Text("ALL types"),
            subtitle: Text(""),
            leading: ClipOval(
              //子要素をくり抜く
              child: Container(
                color: Colors.grey[300],
                width: 48,
                height: 48,
                child: Icon(
                  Icons.style,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
