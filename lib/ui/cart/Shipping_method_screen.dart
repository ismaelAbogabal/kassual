import 'package:flutter/material.dart';
import 'package:kassual/models/cart/shipping_method.dart';
import 'package:kassual/samples/shipping_methods_samples.dart';
import 'package:kassual/ui/cart/cart_stepper_widget.dart';

class ShippingMethodScreen extends StatelessWidget {
  final List<ShippingMethod> methods = shippingList;
  get selected => methods.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shipping method"), toolbarHeight: 100),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          CartStepper(currentStep: 2),
          SizedBox(height: 20),
          for (var m in methods)
            RadioListTile(
              value: selected == m,
              groupValue: true,
              onChanged: (e) {},
              title: Text(m.name),
              subtitle: Text(m.days),
              secondary: Text(m.price > 0 ? "${m.price} \$" : "Free"),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              colorBrightness: Brightness.dark,
              child: Text("Continue To Payment"),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
