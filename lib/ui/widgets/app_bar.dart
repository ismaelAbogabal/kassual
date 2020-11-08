import 'package:flutter/material.dart';

class KAppBar extends StatelessWidget {
  final PreferredSizeWidget bottom;
  final Widget action;
  final bool pinned;

  KAppBar({this.bottom, this.pinned = true, this.action});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 100,
      pinned: pinned,
      backgroundColor: Colors.white,
      bottom: bottom,
      actions: [action ?? Container()],
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        centerTitle: true,
        title: Image.asset(
          "assets/images/Kassual.png",
          height: 24,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
