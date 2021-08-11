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
      selectedIndex: selectedIndex,
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
