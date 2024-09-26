import 'package:example/presentation/feed_selector_screen/feed_selector_screen.dart';
import 'package:example/presentation/login/bloc/mock_login_cubit.dart';
import 'package:example/presentation/signup/bloc/signup_cubit.dart';
import 'package:example/presentation/signup/signup_screen.dart';
import 'package:example/utils/constants/app_text_constants.dart';
import 'package:example/utils/constants/hero_tag_constants.dart';
import 'package:example/utils/constants/mock_stream_feed_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_feed_unofficial/stream_feed_unofficial.dart'
    as stream_feed_unofficial;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late final MockAuthCubit mockAuthCubit;
  late final SignupCubit signupCubit;

  @override
  void initState() {
    mockAuthCubit = GetIt.I.get<MockAuthCubit>();
    signupCubit = GetIt.I.get<SignupCubit>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppTextConstants.mockLoginTitle,
        ),
        centerTitle: false,
      ),
      body: BlocListener<MockAuthCubit, MockAuthState>(
        bloc: mockAuthCubit,
        listener: (context, state) async {
          if (state is Authenticated) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (_) => FeedSelectionScreen(
                      username: mockCurrentUsername,
                    )));
          } else if (state is AuthError) {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  AppTextConstants.loginDescription,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(height: 48),
                TextField(
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: AppTextConstants.usernameLabel,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: AppTextConstants.passwordLabel,
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 32),
                BlocBuilder<MockAuthCubit, MockAuthState>(
                    bloc: mockAuthCubit,
                    builder: (context, state) {
                      if (state is! Authenticated) {
                        return stream_feed_unofficial.AppPrimaryButton(
                            isLoading: state is AuthLoading,
                            text: AppTextConstants.loginCta,
                            onPressed: () {
                              mockAuthCubit.performedMockAuthentication();
                            });
                      }
                      return const SizedBox.shrink();
                    }),
                Hero(
                  flightShuttleBuilder: flightShuttleBuilder,
                  tag: AppHeroConstants.createNewAccountHero,
                  child: TextButton(
                    onPressed: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const SignupScreen(
                            feedName: MockStreamFeedConstants.feedName,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      AppTextConstants.createNewAccountCta,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
