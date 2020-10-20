import 'package:flutter/material.dart';

class KAppBar extends StatelessWidget {
  final bool withIcon;
  final String title;

  const KAppBar({
    Key key,
    @required this.title,
    this.withIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      // title: Text("KASSUAL"),
      expandedHeight: 100,
      elevation: 0,
      pinned: true,
      backgroundColor: Colors.white,
      leading:
          withIcon ? Icon(Icons.ac_unit_outlined, color: Colors.black45) : null,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        centerTitle: true,
        title: Text(
          title,
          style: Theme.of(context).appBarTheme.textTheme.headline6,
        ),
      ),
    );
  }
}
