import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_shopify/flutter_simple_shopify.dart';
import 'package:kassual/bloc/home_screen/home_screen_bloc.dart';
import 'package:kassual/bloc/user_bloc/user_bloc.dart';
import 'package:kassual/ui/authentication/authentication_screen.dart';
import 'package:kassual/ui/cart/cart_screen.dart';
import 'package:kassual/ui/home/home_screen_content.dart';
import 'package:kassual/ui/search_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  body(int _index, Product card) {
    switch (_index) {
      case 0:
        return HomeScreenContent(card: card);
        break;
      case 1:
        return SearchScreen();
        break;
      case 2:
        return CartScreen();
        break;
      case 3:
        return AuthenticationScreen();
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeScreenBloc(),
      child: Builder(
        builder: (context) {
          return BlocBuilder<HomeScreenBloc, HomeScreenState>(
            builder: (context, state) {
              /// remove the error in the login screen
              UserBloc.of(context).add(UERemoveError());
              return WillPopScope(
                onWillPop: () async {
                  if (state.index == 0) {
                    return true;
                  } else {
                    HomeScreenBloc.of(context).add(HomeScreenSetScreen(0));
                    return false;
                  }
                },
                child: state.card == null
                    ? Material(
                        child: Center(
                          child: Image.asset(
                            "assets/images/Kassual.png",
                            height: 50,
                          ),
                        ),
                      )
                    : Scaffold(
                        body: body(state.index, state.card),
                        bottomNavigationBar: BottomNavigationBar(
                          currentIndex: state.index,
                          onTap: (value) => HomeScreenBloc.of(context).add(
                            HomeScreenSetScreen(value),
                          ),
                          items: [
                            BottomNavigationBarItem(
                              icon: Icon(Icons.home_filled),
                              label: "a",
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(Icons.search),
                              label: "a",
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(Icons.shopping_bag_outlined),
                              label: "a",
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(Icons.person_outline),
                              label: "a",
                            ),
                          ],
                        ),
                      ),
              );
            },
          );
        },
      ),
    );
  }
}
