// presentation/signup/screens/sign_up_screen.dart
import 'package:example/presentation/feed_selector_screen/feed_selector_screen.dart';
import 'package:example/presentation/signup/bloc/signup_cubit.dart';
import 'package:example/presentation/signup/components/signup_form_component.dart';
import 'package:example/utils/constants/app_text_constants.dart';
import 'package:example/utils/constants/hero_tag_constants.dart';
import 'package:example/utils/helpers/stream_feed_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SignupScreen extends StatefulWidget {
  final String feedName;

  const SignupScreen({
    super.key,
    required this.feedName,
  });

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with StreamFeedHelper {
  late final SignupCubit signUpCubit;

  @override
  void initState() {
    signUpCubit = GetIt.I.get<SignupCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Hero(
          flightShuttleBuilder: flightShuttleBuilder,
          tag: AppHeroConstants.createNewAccountHero,
          child: Text(AppTextConstants.mockSignupTitle),
        ),
      ),
      body: BlocConsumer<SignupCubit, SignupState>(
        bloc: signUpCubit,
        listener: (context, state) {
          if (state is SignupSuccess) {
            if (state.user.id != null) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (_) =>
                        FeedSelectionScreen(username: state.user.id!)),
              );
            }
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
