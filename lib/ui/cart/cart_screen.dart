import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_shopify/flutter_simple_shopify.dart';
import 'package:kassual/bloc/cart_bloc/cart_bloc.dart';
import 'package:kassual/bloc/home_screen/home_screen_bloc.dart';
import 'package:kassual/bloc/user_bloc/user_bloc.dart';
import 'package:kassual/ui/cart/cart_empty.dart';
import 'package:kassual/ui/cart/cart_item.dart';
import 'package:kassual/ui/cart/cart_stepper_widget.dart';
import 'package:kassual/ui/widgets/app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartStateLoaded) {
          return state.cart.lineItems.lineItemList.isEmpty
              ? CartEmpty()
              : loaded(state.cart, context);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Scaffold loaded(Checkout cart, BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("KASSUAL"), toolbarHeight: 100),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [KAppBar()],
        body: ListView(
          padding: EdgeInsets.all(10),
          physics: BouncingScrollPhysics(),
          children: [
            CartStepper(currentStep: 0),
            SizedBox(height: 20),
            Center(
              child: Text("Shopping Bag"),
            ),
            SizedBox(height: 20),
            for (var p in cart.lineItems.lineItemList) CartItemWidget(item: p),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total ${cart.totalPriceV2.formattedPrice}\$"),
                Text("Drag items to remove < --"),
              ],
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: FlatButton.icon(
                label: Text("Continue Chopping"),
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () =>
                    HomeScreenBloc.of(context).add(HomeScreenSetScreen(0)),
              ),
            ),
            RaisedButton(
              onPressed: () {
                ShopifyUser user;
                final state = UserBloc.of(context).state;
                if (state is USLoaded) {
                  user = state.user;
                }
                CartBloc.of(context).add(CartEventProceed(user));
              },
              colorBrightness: Brightness.dark,
              child: Text("PROCEED CHECK OUT"),
            ),
          ],
        ),
      ),
    );
  }
}
