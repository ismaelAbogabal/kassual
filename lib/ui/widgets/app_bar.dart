import 'package:flutter/material.dart';

class KAppBar extends StatelessWidget {
  final PreferredSizeWidget bottom;

  final bool pinned;

  KAppBar({this.bottom, this.pinned = true});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 100,
      pinned: pinned,
      backgroundColor: Colors.white,
      bottom: bottom,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        centerTitle: true,
        // title: Text(
        //   title,
        //   style: Theme.of(context).appBarTheme.textTheme.headline6,
        // ),
        title: Image.asset(
          "assets/images/Kassual.png",
          height: 24,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
