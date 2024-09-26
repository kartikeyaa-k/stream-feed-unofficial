import 'package:flutter/material.dart';

class AppHeroConstants {
  static const String loginCtaHero = 'login_hero';
  static const String createNewAccountHero = 'create_new_account_hero';
}

Widget flightShuttleBuilder(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  return DefaultTextStyle(
    style: DefaultTextStyle.of(toHeroContext).style,
    child: toHeroContext.widget,
  );
}
