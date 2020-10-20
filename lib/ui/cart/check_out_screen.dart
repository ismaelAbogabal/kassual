import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kassual/ui/cart/Shipping_method_screen.dart';
import 'package:kassual/ui/cart/cart_stepper_widget.dart';
import 'package:kassual/ui/cart/step_widget.dart';
import 'package:kassual/ui/widgets/app_bar.dart';

class AddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("CHECK OUT")),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          KAppBar(title: "ADDRESS"),
        ],
        body: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(20),
          children: [
            CartStepper(currentStep: 1),
            paddingWidget,
            TextField(decoration: inputDecoration("Address")),
            paddingWidget,
            TextField(decoration: inputDecoration("Apartment*")),
            paddingWidget,
            TextField(decoration: inputDecoration("City")),
            paddingWidget,
            TextField(decoration: inputDecoration("Country")),
            paddingWidget,
            TextField(decoration: inputDecoration("Governorate")),
            paddingWidget,
            TextField(decoration: inputDecoration("Postal Code")),
            paddingWidget,
            TextField(decoration: inputDecoration("Phone")),
            paddingWidget,
            RaisedButton(
              child: Text("Continue to Shipping"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShippingMethodScreen()));
              },
              colorBrightness: Brightness.dark,
            ),
          ],
        ),
      ),
    );
  }

  Widget get paddingWidget => SizedBox(height: 10);

  inputDecoration(title) {
    return InputDecoration(
      border: OutlineInputBorder(),
      labelText: title,
    );
  }
}
