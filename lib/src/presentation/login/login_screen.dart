import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_feed_unofficial/src/presentation/activity/activity_list_screen.dart';
import 'package:stream_feed_unofficial/src/presentation/core/blocs/auth/auth_cubit.dart';
import 'package:stream_feed_unofficial/src/presentation/login/bloc/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    required this.userName,
    required this.feedName,
    required this.feedAppbarTitle,
    this.isGlobalFeed = false,
    this.globalUsername = 'global',
  });
  final String userName;
  final String feedName;
  final String feedAppbarTitle;
  final bool isGlobalFeed;
  final String globalUsername;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final AuthCubit authCubit;
  late final LoginCubit loginCubit;

  @override
  void initState() {
    authCubit = GetIt.I.get<AuthCubit>();
    loginCubit = GetIt.I.get<LoginCubit>();

    unawaited(loginCubit.login(widget.userName));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      bloc: loginCubit,
      listener: (context, state) {
        if (state is LoginSuccess) {
          // Mark user as authenticated
          // The usecase of user being authenticated
          // will be utilised later in the next versions
          unawaited(authCubit.userAuthenticated(state.user));
        } else if (state is LoginFailure) {
          // Show error message
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        bloc: authCubit,
        builder: (context, authState) {
          return BlocBuilder<AuthCubit, AuthState>(
            bloc: authCubit,
            builder: (context, authState) {
              if (authState is AuthAuthenticated) {
                return ActivityListScreen(
                  feedName: widget.feedName,
                  appbarTitle: widget.feedAppbarTitle,
                  isGlobalFeed: widget.isGlobalFeed,
                  globalUsername: widget.globalUsername,
                );
              }
              return Scaffold(
                appBar: AppBar(
                  centerTitle: false,
                  title: Text(widget.feedAppbarTitle),
                ),
                body: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
