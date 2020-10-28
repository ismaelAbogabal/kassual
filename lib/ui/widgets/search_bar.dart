import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchBar extends StatelessWidget {
  final Function(String) search;

  const SearchBar({Key key, @required this.search}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: search,
      decoration: InputDecoration(
        hintText: "Search Here",
        suffixIcon: Container(
          width: 40,
          alignment: Alignment.center,
          child: SvgPicture.asset(
            "assets/images/search_black.svg",
            width: 20,
            height: 20,
          ),
        ),
      ),
    );
  }
}
