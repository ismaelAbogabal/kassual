import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TopBanner extends StatefulWidget {
  final List<String> images;

  const TopBanner({Key key, @required this.images}) : super(key: key);

  @override
  _TopBannerState createState() => _TopBannerState();
}

class _TopBannerState extends State<TopBanner> {
  PageController controller;
  StreamSubscription stream;

  bool _autoMovementKeepPeriod = false;

  @override
  void initState() {
    controller = PageController();

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
    stream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images == null || widget.images.isEmpty) {
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SmoothPageIndicator(
                controller: controller,
                count: widget.images.length,
                effect: ScrollingDotsEffect(
                  fixedCenter: true,
                  radius: 5,
                  dotColor: Colors.black38,
                  activeDotColor: Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
