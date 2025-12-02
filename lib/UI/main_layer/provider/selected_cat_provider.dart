import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_constants.dart';

class SelectedCatProvider extends ChangeNotifier {
  int selectedCat = 0;
  final ScrollController scrollController = ScrollController();

  final double itemWidth = 100;
  Map<String, String> arabicToEnglishGenre = {
    'أكشن': 'Action',
    'مغامرة': 'Adventure',
    'رسوم متحركة': 'Animation',
    'سيرة ذاتية': 'Biography',
    'كوميديا': 'Comedy',
    'جريمة': 'Crime',
    'وثائقي': 'Documentary',
    'دراما': 'Drama',
    'عائلي': 'Family',
    'خيال': 'Fantasy',
    'فيلم نوار': 'Film-Noir',
    'برامج ألعاب': 'Game-Show',
    'تاريخي': 'History',
    'رعب': 'Horror',
    'موسيقى': 'Music',
    'غنائي': 'Musical',
    'غموض': 'Mystery',
    'أخبار': 'News',
    'تلفزيون الواقع': 'Reality-TV',
    'رومانسي': 'Romance',
    'خيال علمي': 'Sci-Fi',
    'قصير': 'Short',
    'رياضي': 'Sport',
    'برنامج حواري': 'Talk-Show',
    'إثارة': 'Thriller',
    'حرب': 'War',
    'ويسترن': 'Western',
  };

  void selectCat(
    String cat,
  ) {
    cat = arabicToEnglishGenre[cat] ?? cat;

    selectedCat = AppConstants.genresList.indexWhere((e) => e == cat);
    notifyListeners();
    Future.delayed(Duration(milliseconds: 100), () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!scrollController.hasClients) return;

        final double offset = (itemWidth * selectedCat);
        final max = scrollController.position.maxScrollExtent;

        scrollController.animateTo(
          offset.clamp(0, max),
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
    });
  }

  void unSelectCat() {
    selectedCat = 0;
    notifyListeners();
  }
}
