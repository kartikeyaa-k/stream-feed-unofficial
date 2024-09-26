import 'package:example/presentation/login/login_screen.dart';
import 'package:example/utils/helpers/stream_feed_helper.dart';
import 'package:example/utils/styles/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with StreamFeedHelper {
  @override
  void initState() {
    super.initState();

    initializeStreamBaseConfigurations();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Navigate after the first frame
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Theme.of(context).brightness == Brightness.dark
          ? darkStatusAndNavigationBar
          : lightStatusAndNavigationBar,
      child: const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 8),
              Text('Mock splash...'),
            ],
          ),
        ),
      ),
    );
  }
}
