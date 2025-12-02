import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../UI/movieDetails/model/movie_details_model.dart';

class AppPrefs {
  static const String _historyBoxName = 'historyBox';

  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

//onboarding
  static Future<void> onboardingSetBool(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  static bool? onboardingGetBool(String key) {
    return prefs.getBool(key);
  }

//localization
  static Future<void> localizationSetBool(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  static bool? localizationGetBool(String key) {
    return prefs.getBool(key);
  }

// history tab in profile tab screen (Hive)
  static MovieDetails _clone(MovieDetails m) => MovieDetails(
        imdbCode: m.imdbCode,
        rating: m.rating,
        largeCoverImage: m.largeCoverImage,
        title: m.title,
        year: m.year,
      );

  static Future<void> historySetSetOfString({
    required MovieDetails? watchedMovie,
  }) async {
    if (watchedMovie == null) return;

    final box = await Hive.openBox<MovieDetails>(_historyBoxName);

    final list = box.values.map(_clone).toList();

    list.removeWhere((m) => m.imdbCode == watchedMovie.imdbCode);

    list.insert(0, _clone(watchedMovie));

    await box.clear();
    await box.addAll(list);
  }

  static Future<List<MovieDetails>?> historyGetSetOfString() async {
    final box = await Hive.openBox<MovieDetails>(_historyBoxName);
    return box.values.toList();
  }
}
