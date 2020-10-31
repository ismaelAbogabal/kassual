
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_shopify/flutter_simple_shopify.dart';
import 'package:kassual/bloc/home_screen/home_screen_bloc.dart';
import 'package:kassual/bloc/user_bloc/user_bloc.dart';
import 'package:kassual/config/theme.dart';
import 'package:kassual/models/api/api.dart';
import 'package:kassual/ui/home/home_screen.dart';

import 'bloc/cart_bloc/cart_bloc.dart';

main() async {
  ShopifyConfig.setConfig(
    Api.storeFrontApi,
    "df602872e2c405e672b32937ec4ab0f9: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@overstockauthentics.myshopify.com",
    "2020-10",
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userBloc = UserBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: userBloc),
        BlocProvider.value(value: CartBloc(userBloc)),
        BlocProvider.value(value: HomeScreenBloc()),
      ],
      child: MaterialApp(
        title: "KASSUAL",
        home: HomeScreen(),
        theme: AppTheme.theme,
      ),
    );
    userBloc.close();
  }
}
