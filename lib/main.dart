import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kassual/config/theme.dart';
import 'package:kassual/ui/home/home_screen.dart';

import 'bloc/cart_bloc/cart_bloc.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartBloc>(
      create: (context) => CartBloc(),
      child: MaterialApp(
        title: "KASSUAL",
        home: HomeScreen(),
        theme: AppTheme.theme,
      ),
    );
  }
}
