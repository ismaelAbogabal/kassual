import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchBar extends StatelessWidget {
  final Function(String) search;

  SearchBar({Key key, @required this.search}) : super(key: key);

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      onSubmitted: search,
      decoration: InputDecoration(
        hintText: "Search Here",
        suffixIcon: Container(
          width: 40,
          alignment: Alignment.center,
          child: IconButton(
            icon: SvgPicture.asset(
              "assets/images/search_black.svg",
              width: 20,
              height: 20,
            ),
            onPressed: () => search?.call(_searchController.text),
          ),
        ),
      ),
    );
  }
}
