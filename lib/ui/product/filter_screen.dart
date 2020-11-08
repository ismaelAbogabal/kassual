import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kassual/models/product/filter.dart';
import 'package:kassual/ui/widgets/app_bar.dart';

class FilterScreen extends StatefulWidget {
  final Filter filter;

  const FilterScreen({Key key, @required this.filter}) : super(key: key);
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

const List<String> ShopifyBrands = [
  "Calvin Klein",
  "Carrera",
  "Dolce & Gabbana",
  "Emporio Armina",
  "John Varvatos",
  "Kenneth Cole New York",
  "Pholippe Charriol",
  "Prada",
  "Salvatore Ferragamo",
  "Tom Ford",
];

class _FilterScreenState extends State<FilterScreen> {
  final TextEditingController controller = TextEditingController();

  List<String> selectedBrands = [];

  RangeValues rangeValues = RangeValues(0, 1000);

  @override
  void initState() {
    super.initState();

    controller.text = widget.filter.title;
    selectedBrands = widget.filter.brande?.split(",") ?? [];
    rangeValues = RangeValues(
      widget.filter.minimumPrice ?? 0,
      widget.filter.maximumPrice ?? 1000,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [KAppBar()],
        body: ListView(
          children: [
            ExpansionTile(
              title: Text("Title"),
              initiallyExpanded: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 20),
                      hintText: "Product Title",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text("Brands"),
              initiallyExpanded: true,
              children: [
                for (var b in ShopifyBrands)
                  CheckboxListTile(
                    title: Text(b),
                    value: selectedBrands.contains(b),
                    onChanged: (c) {
                      setState(() {
                        if (!selectedBrands.remove(b)) {
                          selectedBrands.add(b);
                        }
                      });
                    },
                  ),
              ],
            ),
            ExpansionTile(
              title: Text("Price"),
              initiallyExpanded: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(rangeValues.start.toStringAsFixed(0) + "\$"),
                      Text(rangeValues.end.toStringAsFixed(0) + "\$"),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(r"0 $"),
                    ),
                    Expanded(
                      child: RangeSlider(
                        min: 0,
                        max: 1000,
                        activeColor: Colors.black87,
                        values: rangeValues,
                        onChanged: (s) {
                          setState(() {
                            rangeValues = s;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(r"1000 $"),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.pop(
                      context,
                      Filter(
                        title: controller.text,
                        brande: selectedBrands.fold(
                          "",
                          (previousValue, element) =>
                              previousValue + "," + element,
                        ),
                        minimumPrice: rangeValues.start,
                        maximumPrice: rangeValues.end,
                      ));
                },
                child: Text("Filter"),
                colorBrightness: Brightness.dark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
