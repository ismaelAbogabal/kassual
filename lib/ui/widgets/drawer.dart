// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:kassual/samples/product_list_sample.dart';
// import 'package:kassual/ui/product/product_list_screen.dart';
// import 'package:kassual/ui/widgets/search_bar.dart';
//
// class KDrawer extends StatefulWidget {
//   @override
//   _KDrawerState createState() => _KDrawerState();
// }
//
// class _KDrawerState extends State<KDrawer> with SingleTickerProviderStateMixin {
//   AnimationController _controller;
//   bool searching = false;
//
//   @override
//   void initState() {
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 300),
//       lowerBound: 0.0,
//       upperBound: 1.0,
//       value: .5,
//     );
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Padding(
//         padding: const EdgeInsets.all(30.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             SearchBar(search: (v) => v),
//             backButton(),
//             images(),
//             buttons(),
//             Expanded(child: SizedBox()),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void openProductsListScreen() {
//     Navigator.pop(context);
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ProductLisScreen(
//             collection: [...list1, ...list2],
//           ),
//         ));
//   }
//
//   AnimatedBuilder buttons() {
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (context, child) => Opacity(
//         opacity: ((_controller.value * 2) - 1).abs(),
//         child: Column(
//           children: [
//             Transform.scale(
//               scale: ((_controller.value * 2) - 1).abs(),
//               child: FlatButton(
//                 onPressed: () => openProductsListScreen(),
//                 child: Text("Sun Glasses"),
//               ),
//             ),
//             Transform.scale(
//               scale: ((_controller.value * 2) - 1).abs(),
//               child: FlatButton(
//                 onPressed: () => openProductsListScreen(),
//                 child: Text("Eye Glasses"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   AnimatedBuilder backButton() {
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (context, child) => Align(
//         alignment: Alignment.centerLeft,
//         child: Transform.scale(
//           scale: ((_controller.value * 2) - 1).abs(),
//           child: TextButton.icon(
//             onPressed: () {
//               _controller.animateTo(
//                 .5,
//                 duration: Duration(milliseconds: 300),
//                 curve: Curves.easeInOut,
//               );
//             },
//             icon: Icon(Icons.arrow_back_ios),
//             label: Text("Back"),
//           ),
//         ),
//       ),
//     );
//   }
//
//   int get animationVal => (_controller.value * 100).ceil();
//
//   images() {
//     return AspectRatio(
//       aspectRatio: 1.5,
//       child: LayoutBuilder(
//         builder: (context, constraints) => AnimatedBuilder(
//           animation: _controller,
//           builder: (context, child) {
//             return Stack(
//               children: [
//                 Positioned(
//                   left: (_controller.value - .5) * constraints.maxWidth / 2,
//                   width: constraints.maxWidth / 2,
//                   height: constraints.maxHeight,
//                   child: Transform.scale(
//                     scale: min((_controller.value + .5), 1.0),
//                     child: GestureDetector(
//                       onTap: () {
//                         _controller.forward();
//                       },
//                       child: Column(
//                         children: [
//                           Expanded(
//                             child: Image.asset(
//                               "assets/images/woman.jpg",
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text("WOMEN"),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   left: (_controller.value + .5) * constraints.maxWidth / 2,
//                   width: constraints.maxWidth / 2,
//                   height: constraints.maxHeight,
//                   child: Transform.scale(
//                     scale: min((1.5 - _controller.value), 1.0),
//                     child: GestureDetector(
//                       onTap: () {
//                         _controller.reverse();
//                       },
//                       child: Column(
//                         children: [
//                           Expanded(
//                             child: Image.asset(
//                               "assets/images/man.jpg",
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text("MEN"),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
