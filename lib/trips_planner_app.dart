import 'package:flutter/material.dart';
import 'package:amplify_hashnode/features/trip/ui/trips_list_page.dart';
import 'package:go_router/go_router.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_hashnode/common/navigation/router/routes.dart';
import 'package:amplify_hashnode/common/utils/colors.dart' as constants;

class TripsPlannerApp extends StatelessWidget {
  const TripsPlannerApp({
    required this.isAmplifySuccessfullyConfigured,
    Key? key,
  }) : super(key: key);

  final bool isAmplifySuccessfullyConfigured;

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            name: AppRoute.home.name,
            builder: (context, state) => isAmplifySuccessfullyConfigured
                ? const TripsListPage()
                : const Scaffold(
                    body: Center(
                      child: Text('Tried to reconfigure Amplify;'
                          'This error occurs when your app restarts'),
                    ),
                  ),
          )
        ],
        errorBuilder: (context, state) => Scaffold(
              body: Center(
                child: Text(state.error.toString()),
              ),
            ));
    return Authenticator(
        child: MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
      builder: Authenticator.builder(),
      theme: ThemeData(
          colorScheme:
              ColorScheme.fromSwatch(primarySwatch: constants.primaryColor)
                  .copyWith(background: const Color(0xff82CFEA))),
    ));
  }
}
