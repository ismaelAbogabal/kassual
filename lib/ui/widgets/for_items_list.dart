import 'package:flutter/material.dart';

class ForItemsList extends StatelessWidget {
  final List<Item> children;
  final double padding;

  const ForItemsList({
    Key key,
    @required this.children,
    this.padding = 20.0,
  })  : assert(children?.length == 4),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: AspectRatio(
        aspectRatio: 1,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: children[0].getWidget(0, padding),
                  ),
                  Expanded(
                    child: children[1].getWidget(1, padding),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: children[2].getWidget(2, padding),
                  ),
                  Expanded(
                    child: children[3].getWidget(3, padding),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Item {
  final String title;
  final String data;
  final Widget image;

  Item({
    @required this.title,
    @required this.data,
    @required this.image,
  });

  Widget getWidget(int index, [double padding = 20.0]) {
    return Card(
      margin: EdgeInsets.only(
        bottom: index == 0 ? padding : 0.0,
        left: index == 1 ? padding : 0.0,
        right: index == 2 ? padding : 0.0,
        top: index == 3 ? padding : 0.0,
      ),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(child: Container()),
            AspectRatio(
              aspectRatio: 4,
              child: image,
            ),
            SizedBox(height: 15),
            Expanded(
              child: Column(
                children: [
                  Text(title),
                  Text(
                    data,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
