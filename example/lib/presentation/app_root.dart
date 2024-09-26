import 'package:example/presentation/login/bloc/mock_login_cubit.dart';
import 'package:example/presentation/splash/splash_screen.dart';
import 'package:example/utils/styles/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream Feed Unofficial Example',
      debugShowCheckedModeBanner: false,
      theme: appDarkTheme,
      home: MultiBlocProvider(providers: [
        BlocProvider(
          create: (context) => GetIt.I.get<MockAuthCubit>(),
        ),
      ], child: const SplashScreen()),
    );
  }
}
