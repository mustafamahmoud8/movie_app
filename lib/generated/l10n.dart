// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Forget Password ?`
  String get forgetPassword {
    return Intl.message(
      'Forget Password ?',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Login With Google`
  String get loginWithGoogle {
    return Intl.message(
      'Login With Google',
      name: 'loginWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Don’t Have Account ? `
  String get donotHaveAccount {
    return Intl.message(
      'Don’t Have Account ? ',
      name: 'donotHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Create One`
  String get createOne {
    return Intl.message('Create One', name: 'createOne', desc: '', args: []);
  }

  /// `Or`
  String get or {
    return Intl.message('Or', name: 'or', desc: '', args: []);
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Avatar`
  String get avatar {
    return Intl.message('Avatar', name: 'avatar', desc: '', args: []);
  }

  /// `Name`
  String get nameHint {
    return Intl.message('Name', name: 'nameHint', desc: '', args: []);
  }

  /// `Email`
  String get emailHint {
    return Intl.message('Email', name: 'emailHint', desc: '', args: []);
  }

  /// `Password`
  String get passwordHint {
    return Intl.message('Password', name: 'passwordHint', desc: '', args: []);
  }

  /// `Confirm Password`
  String get confirmPasswordHint {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneHint {
    return Intl.message('Phone Number', name: 'phoneHint', desc: '', args: []);
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Already Have Account ? `
  String get alreadyHaveAccount {
    return Intl.message(
      'Already Have Account ? ',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Name is required`
  String get nameRequired {
    return Intl.message(
      'Name is required',
      name: 'nameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get emailRequired {
    return Intl.message(
      'Email is required',
      name: 'emailRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter valid email`
  String get invalidEmail {
    return Intl.message(
      'Enter valid email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get passwordRequired {
    return Intl.message(
      'Password is required',
      name: 'passwordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get passwordMinLength {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'passwordMinLength',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one uppercase letter`
  String get passwordUppercase {
    return Intl.message(
      'Password must contain at least one uppercase letter',
      name: 'passwordUppercase',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one number`
  String get passwordNumber {
    return Intl.message(
      'Password must contain at least one number',
      name: 'passwordNumber',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one special character`
  String get passwordSpecial {
    return Intl.message(
      'Password must contain at least one special character',
      name: 'passwordSpecial',
      desc: '',
      args: [],
    );
  }

  /// `Confirm your password`
  String get confirmPasswordRequired {
    return Intl.message(
      'Confirm your password',
      name: 'confirmPasswordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Phone number is required`
  String get phoneRequired {
    return Intl.message(
      'Phone number is required',
      name: 'phoneRequired',
      desc: '',
      args: [],
    );
  }

  /// `Phone number must start with +`
  String get phoneStartWithPlus {
    return Intl.message(
      'Phone number must start with +',
      name: 'phoneStartWithPlus',
      desc: '',
      args: [],
    );
  }

  /// `Phone number must be exactly 13 characters`
  String get phoneExactLength {
    return Intl.message(
      'Phone number must be exactly 13 characters',
      name: 'phoneExactLength',
      desc: '',
      args: [],
    );
  }

  /// `Phone number must contain only digits after +`
  String get phoneOnlyDigits {
    return Intl.message(
      'Phone number must contain only digits after +',
      name: 'phoneOnlyDigits',
      desc: '',
      args: [],
    );
  }

  /// `Login Successful`
  String get loginSuccess {
    return Intl.message(
      'Login Successful',
      name: 'loginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Registration Successful`
  String get registrationSuccess {
    return Intl.message(
      'Registration Successful',
      name: 'registrationSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Registration failed`
  String get registrationFailed {
    return Intl.message(
      'Registration failed',
      name: 'registrationFailed',
      desc: '',
      args: [],
    );
  }

  /// `Google Sign-In Cancelled`
  String get googleCancelled {
    return Intl.message(
      'Google Sign-In Cancelled',
      name: 'googleCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Old Password`
  String get oldPasswordHint {
    return Intl.message(
      'Old Password',
      name: 'oldPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPasswordHint {
    return Intl.message(
      'New Password',
      name: 'newPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `search`
  String get search {
    return Intl.message('search', name: 'search', desc: '', args: []);
  }

  /// `Pick Avatar`
  String get pickAvatar {
    return Intl.message('Pick Avatar', name: 'pickAvatar', desc: '', args: []);
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete the account?`
  String get deleteAccountMessage {
    return Intl.message(
      'Are you sure you want to delete the account?',
      name: 'deleteAccountMessage',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: '', args: []);
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
  }

  /// `Profile deleted successfully`
  String get profileDeleted {
    return Intl.message(
      'Profile deleted successfully',
      name: 'profileDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully`
  String get profileUpdated {
    return Intl.message(
      'Profile updated successfully',
      name: 'profileUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Failed to update: `
  String get profileUpdateFailed {
    return Intl.message(
      'Failed to update: ',
      name: 'profileUpdateFailed',
      desc: '',
      args: [],
    );
  }

  /// `Update Data`
  String get updateData {
    return Intl.message('Update Data', name: 'updateData', desc: '', args: []);
  }

  /// `Wish List`
  String get wishList {
    return Intl.message('Wish List', name: 'wishList', desc: '', args: []);
  }

  /// `History`
  String get history {
    return Intl.message('History', name: 'history', desc: '', args: []);
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get exit {
    return Intl.message('Exit', name: 'exit', desc: '', args: []);
  }

  /// `Watch List`
  String get watchList {
    return Intl.message('Watch List', name: 'watchList', desc: '', args: []);
  }

  /// `User Name`
  String get userName {
    return Intl.message('User Name', name: 'userName', desc: '', args: []);
  }

  /// `Action`
  String get genreAction {
    return Intl.message('Action', name: 'genreAction', desc: '', args: []);
  }

  /// `Adventure`
  String get genreAdventure {
    return Intl.message(
      'Adventure',
      name: 'genreAdventure',
      desc: '',
      args: [],
    );
  }

  /// `Animation`
  String get genreAnimation {
    return Intl.message(
      'Animation',
      name: 'genreAnimation',
      desc: '',
      args: [],
    );
  }

  /// `Biography`
  String get genreBiography {
    return Intl.message(
      'Biography',
      name: 'genreBiography',
      desc: '',
      args: [],
    );
  }

  /// `Comedy`
  String get genreComedy {
    return Intl.message('Comedy', name: 'genreComedy', desc: '', args: []);
  }

  /// `Crime`
  String get genreCrime {
    return Intl.message('Crime', name: 'genreCrime', desc: '', args: []);
  }

  /// `Documentary`
  String get genreDocumentary {
    return Intl.message(
      'Documentary',
      name: 'genreDocumentary',
      desc: '',
      args: [],
    );
  }

  /// `Drama`
  String get genreDrama {
    return Intl.message('Drama', name: 'genreDrama', desc: '', args: []);
  }

  /// `Family`
  String get genreFamily {
    return Intl.message('Family', name: 'genreFamily', desc: '', args: []);
  }

  /// `Fantasy`
  String get genreFantasy {
    return Intl.message('Fantasy', name: 'genreFantasy', desc: '', args: []);
  }

  /// `Film-Noir`
  String get genreFilmNoir {
    return Intl.message('Film-Noir', name: 'genreFilmNoir', desc: '', args: []);
  }

  /// `Game-Show`
  String get genreGameShow {
    return Intl.message('Game-Show', name: 'genreGameShow', desc: '', args: []);
  }

  /// `History`
  String get genreHistory {
    return Intl.message('History', name: 'genreHistory', desc: '', args: []);
  }

  /// `Horror`
  String get genreHorror {
    return Intl.message('Horror', name: 'genreHorror', desc: '', args: []);
  }

  /// `Music`
  String get genreMusic {
    return Intl.message('Music', name: 'genreMusic', desc: '', args: []);
  }

  /// `Musical`
  String get genreMusical {
    return Intl.message('Musical', name: 'genreMusical', desc: '', args: []);
  }

  /// `Mystery`
  String get genreMystery {
    return Intl.message('Mystery', name: 'genreMystery', desc: '', args: []);
  }

  /// `News`
  String get genreNews {
    return Intl.message('News', name: 'genreNews', desc: '', args: []);
  }

  /// `Reality-TV`
  String get genreRealityTV {
    return Intl.message(
      'Reality-TV',
      name: 'genreRealityTV',
      desc: '',
      args: [],
    );
  }

  /// `Romance`
  String get genreRomance {
    return Intl.message('Romance', name: 'genreRomance', desc: '', args: []);
  }

  /// `Sci-Fi`
  String get genreSciFi {
    return Intl.message('Sci-Fi', name: 'genreSciFi', desc: '', args: []);
  }

  /// `Short`
  String get genreShort {
    return Intl.message('Short', name: 'genreShort', desc: '', args: []);
  }

  /// `Sport`
  String get genreSport {
    return Intl.message('Sport', name: 'genreSport', desc: '', args: []);
  }

  /// `Talk-Show`
  String get genreTalkShow {
    return Intl.message('Talk-Show', name: 'genreTalkShow', desc: '', args: []);
  }

  /// `Thriller`
  String get genreThriller {
    return Intl.message('Thriller', name: 'genreThriller', desc: '', args: []);
  }

  /// `War`
  String get genreWar {
    return Intl.message('War', name: 'genreWar', desc: '', args: []);
  }

  /// `Western`
  String get genreWestern {
    return Intl.message('Western', name: 'genreWestern', desc: '', args: []);
  }

  /// `See More`
  String get seeMore {
    return Intl.message('See More', name: 'seeMore', desc: '', args: []);
  }

  /// `Summary`
  String get summary {
    return Intl.message('Summary', name: 'summary', desc: '', args: []);
  }

  /// `Genres`
  String get geners {
    return Intl.message('Genres', name: 'geners', desc: '', args: []);
  }

  /// `Cast`
  String get cast {
    return Intl.message('Cast', name: 'cast', desc: '', args: []);
  }

  /// `Similar`
  String get similar {
    return Intl.message('Similar', name: 'similar', desc: '', args: []);
  }

  /// `Screenshots`
  String get screenshots {
    return Intl.message('Screenshots', name: 'screenshots', desc: '', args: []);
  }

  /// `Watch`
  String get watch {
    return Intl.message('Watch', name: 'watch', desc: '', args: []);
  }

  /// `No Character Available`
  String get nocharacter {
    return Intl.message(
      'No Character Available',
      name: 'nocharacter',
      desc: '',
      args: [],
    );
  }

  /// `No Name Available`
  String get noname {
    return Intl.message(
      'No Name Available',
      name: 'noname',
      desc: '',
      args: [],
    );
  }

  /// `No Cast Available`
  String get nocast {
    return Intl.message(
      'No Cast Available',
      name: 'nocast',
      desc: '',
      args: [],
    );
  }

  /// `No Summary Available For This Movie!`
  String get nosummary {
    return Intl.message(
      'No Summary Available For This Movie!',
      name: 'nosummary',
      desc: '',
      args: [],
    );
  }

  /// `Character:`
  String get character {
    return Intl.message('Character:', name: 'character', desc: '', args: []);
  }

  /// `Name:`
  String get name {
    return Intl.message('Name:', name: 'name', desc: '', args: []);
  }

  /// `No Movies!`
  String get nomovies {
    return Intl.message('No Movies!', name: 'nomovies', desc: '', args: []);
  }

  /// `You Are Going To Watch The Movie`
  String get youAreGoingToWatchTheMovie {
    return Intl.message(
      'You Are Going To Watch The Movie',
      name: 'youAreGoingToWatchTheMovie',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to exit?`
  String get areYouSureYouWantToExit {
    return Intl.message(
      'Are you sure you want to exit?',
      name: 'areYouSureYouWantToExit',
      desc: '',
      args: [],
    );
  }

  /// `Password Should Not Match Old Password`
  String get passwordShouldNotMatch {
    return Intl.message(
      'Password Should Not Match Old Password',
      name: 'passwordShouldNotMatch',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
