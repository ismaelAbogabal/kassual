import 'package:flutter/material.dart';
import 'package:kassual/bloc/home_screen/home_screen_bloc.dart';
import 'package:kassual/ui/widgets/app_bar.dart';

class CartEmpty extends StatelessWidget {
  const CartEmpty({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [KAppBar()],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/cart_empty.png",
                fit: BoxFit.fitWidth,
                color: Colors.black54,
              ),
              SizedBox(height: 50),
              Text("Cart Empty"),
              FlatButton.icon(
                icon: Icon(Icons.arrow_back_ios),
                label: Text("Continue Shopping"),
                onPressed: () =>
                    HomeScreenBloc.of(context).add(HomeScreenSetScreen(0)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
