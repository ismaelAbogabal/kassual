import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kassual/models/home_screen/home_screen_bloc.dart';
import 'package:kassual/ui/authentication/login_screen.dart';
import 'package:kassual/ui/cart/cart_screen.dart';
import 'package:kassual/ui/home/ols_home_screen.dart';
import 'package:kassual/ui/search_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  body(int _index) {
    switch (_index) {
      case 0:
        return OldHomeScreen();
        break;
      case 1:
        return SearchScreen();
        break;
      case 2:
        return CartScreen();
        break;
      case 3:
        return LoginScreen();
        break;
      default:
    }
  }

  //todo will pop scope
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeScreenBloc(),
      child: Builder(
        builder: (context) {
          return BlocBuilder<HomeScreenBloc, HomeScreenLoaded>(
            builder: (context, state) {
              return WillPopScope(
                onWillPop: () async {
                  if (state.index == 0) {
                    return true;
                  } else {
                    HomeScreenBloc.of(context).add(HomeScreenSetIndex(0));
                    return false;
                  }
                },
                child: Scaffold(
                  body: body(state.index),
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: state.index,
                    onTap: (value) => HomeScreenBloc.of(context).add(
                      HomeScreenSetIndex(value),
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
