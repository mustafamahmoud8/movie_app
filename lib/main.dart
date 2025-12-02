import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movies_app/UI/auth/view/screens/signInScreen.dart';
import 'package:movies_app/UI/auth/view/screens/signUpScreen.dart';
import 'package:movies_app/UI/auth/view_model/providers/switch_provider.dart';
import 'package:movies_app/UI/auth/view_model/providers/token_provider.dart';
import 'package:movies_app/UI/main_layer/main_layer_screen.dart';
import 'package:movies_app/UI/main_layer/provider/selected_cat_provider.dart';
import 'package:movies_app/UI/movieDetails/view/movie_details_screen.dart';
import 'package:movies_app/UI/onboarding/onboarding_screens/onboarding_screen_1.dart';
import 'package:movies_app/core/utils/app_constants.dart';
import 'package:movies_app/core/utils/app_theme.dart';
import 'package:movies_app/generated/l10n.dart';
import 'package:provider/provider.dart';

import 'UI/main_layer/tabs/profileTab/view/screens/resetPassword.dart';
import 'UI/main_layer/tabs/profileTab/view/screens/update_profile_screen.dart';
import 'UI/main_layer/tabs/profileTab/view_model/providers/avatar_bottom_sheet_provider.dart';
import 'UI/main_layer/tabs/profileTab/view_model/providers/profile_tab_provider.dart';
import 'UI/movieDetails/model/movie_details_model.dart';
import 'UI/onboarding/onboarding_screens/onboarding_screen_2.dart';
import 'core/utils/app_prefs.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(MovieDetailsAdapter());
  Hive.registerAdapter(CastAdapter());
  Hive.registerAdapter(TorrentsAdapter());

  await AppPrefs.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SwitchProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AvatarBottomSheetProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SelectedCatProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TokenProvider()..loadToken(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileTabProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    final tokenProvider = context.watch<TokenProvider>();

    if (!tokenProvider.isTokenLoaded) {
      return MaterialApp(
        home: const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        navigatorObservers: [routeObserver],
      );
    }
    return ScreenUtilInit(
      designSize: Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorObservers: [routeObserver],
        theme: AppTheme.themeData,
        themeMode: ThemeMode.light,
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: context.watch<SwitchProvider>().isActive == false
            ? Locale('en')
            : Locale('ar'),
        supportedLocales: S.delegate.supportedLocales,
        routes: {
          SignInScreen.routeName: (_) => SignInScreen(),
          OnboardingScreen1.routeName: (_) => OnboardingScreen1(),
          OnboardingScreen2.routeName: (_) => OnboardingScreen2(),
          UpdateProfileScreen.routeName: (_) => UpdateProfileScreen(),
          MainLayerScreen.routeName: (_) => const MainLayerScreen(),
          ResetPassword.routeName: (_) => ResetPassword(),
          SignUpScreen.routeName: (_) => SignUpScreen(),
          MovieDetailsScreen.routeName: (context) {
            String movieId =
                ModalRoute.of(context)!.settings.arguments as String;

            return MovieDetailsScreen(
              movieId: movieId,
            );
          },
        },
        initialRoute: getInitialRoute(tokenProvider),
      ),
    );
  }

  String getInitialRoute(TokenProvider tokenProvider) {
    if (AppPrefs.onboardingGetBool(AppConstants.onboardingKey) == null) {
      return OnboardingScreen1.routeName;
    } else if (tokenProvider.token != null) {
      return MainLayerScreen.routeName;
    } else {
      return SignInScreen.routeName;
    }
  }
}
