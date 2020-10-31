import 'dart:async';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class TopBanner extends StatefulWidget {
  final List<String> images;

  const TopBanner({Key key, @required this.images}) : super(key: key);

  @override
  _TopBannerState createState() => _TopBannerState();
}

class _TopBannerState extends State<TopBanner> {
  PageController controller;
  double position = 0;
  StreamSubscription stream;

  bool _autoMovementKeepPeriod = false;

  void changeListener() {
    setState(() {
      position = controller.page;
    });
  }

  @override
  void initState() {
    controller = PageController();
    controller.addListener(changeListener);

    stream = Stream.periodic(Duration(seconds: 5)).listen((event) {
      if (_autoMovementKeepPeriod) {
        _autoMovementKeepPeriod = false;
        return;
      }

      int next = controller.page.ceil() + 1;
      if (next >= widget.images.length) next = 0;
      controller.animateToPage(next,
          duration: Duration(seconds: 1), curve: Curves.easeInOut);
      // controller.jumpToPage(next);
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(dispose);
    stream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.images == null || widget.images.isEmpty){
      return Text("");
    }
    return AspectRatio(
      aspectRatio: 1.6,
      child: Stack(
        fit: StackFit.expand,
        children: [
          PageView(
            controller: controller,
            children: widget.images
                .map((e) => Image.network(e, fit: BoxFit.cover))
                .toList(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: DotsIndicator(
              dotsCount: widget.images.length,
              position: position,
              onTap: (val) {
                _autoMovementKeepPeriod = true;
                controller.animateToPage(
                  val.ceil(),
                  duration: Duration(seconds: 1),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
