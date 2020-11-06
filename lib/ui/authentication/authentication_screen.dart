import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kassual/bloc/user_bloc/user_bloc.dart';
import 'package:kassual/ui/authentication/login_screen.dart';
import 'package:kassual/ui/authentication/profile_screen.dart';
import 'package:kassual/ui/widgets/loading_widget.dart';

class AuthenticationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is USEmpty) {
          return LoginScreen(error: state.error);
        } else if (state is USLoaded) {
          return ProfileScreen(user: state.user);
        } else if (state is USLoading) {
          return LoadingWidget();
        }
        return Text(state.runtimeType.toString());
      },
    );
  }
}
