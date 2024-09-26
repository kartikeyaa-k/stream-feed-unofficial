// presentation/signup/screens/sign_up_screen.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_feed_unofficial/src/presentation/activity/activity_list_screen.dart';
import 'package:stream_feed_unofficial/src/presentation/signup/bloc/signup_cubit.dart';
import 'package:stream_feed_unofficial/src/presentation/signup/components/signup_form_component.dart';

class SignupScreen extends StatefulWidget {
  final String feedName;
  final String feedAppbarTitle;
  const SignupScreen({
    super.key,
    required this.feedName,
    required this.feedAppbarTitle,
  });

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late final SignupCubit signUpCubit;

  @override
  void initState() {
    signUpCubit = GetIt.I.get<SignupCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: BlocConsumer<SignupCubit, SignupState>(
        bloc: signUpCubit,
        listener: (context, state) {
          if (state is SignupSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Sign Up Successful')),
            );
            unawaited(
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => ActivityListScreen(
                    feedName: widget.feedName,
                    appbarTitle: widget.feedAppbarTitle,
                  ),
                ),
              ),
            );
            // Navigate to the main screen or another screen
          } else if (state is SignupFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is SignupLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SignUpFormComponent(signUpCubit: signUpCubit);
        },
      ),
    );
  }
}
