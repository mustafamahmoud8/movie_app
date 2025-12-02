import 'package:flutter/material.dart';
import 'package:movies_app/generated/l10n.dart';

extension GenreNameExtension on String {
  String getGenreLocalizedName(BuildContext context) {
    final genreKey =
        'genre${replaceAll('-', '').replaceAll(' ', '').replaceAll('–', '')}';
    switch (genreKey) {
      case 'genreAction':
        return S.of(context).genreAction;
      case 'genreAdventure':
        return S.of(context).genreAdventure;
      case 'genreAnimation':
        return S.of(context).genreAnimation;
      case 'genreBiography':
        return S.of(context).genreBiography;
      case 'genreComedy':
        return S.of(context).genreComedy;
      case 'genreCrime':
        return S.of(context).genreCrime;
      case 'genreDocumentary':
        return S.of(context).genreDocumentary;
      case 'genreDrama':
        return S.of(context).genreDrama;
      case 'genreFamily':
        return S.of(context).genreFamily;
      case 'genreFantasy':
        return S.of(context).genreFantasy;
      case 'genreFilmNoir':
        return S.of(context).genreFilmNoir;
      case 'genreGameShow':
        return S.of(context).genreGameShow;
      case 'genreHistory':
        return S.of(context).genreHistory;
      case 'genreHorror':
        return S.of(context).genreHorror;
      case 'genreMusic':
        return S.of(context).genreMusic;
      case 'genreMusical':
        return S.of(context).genreMusical;
      case 'genreMystery':
        return S.of(context).genreMystery;
      case 'genreNews':
        return S.of(context).genreNews;
      case 'genreRealityTV':
        return S.of(context).genreRealityTV;
      case 'genreRomance':
        return S.of(context).genreRomance;
      case 'genreSciFi':
        return S.of(context).genreSciFi;
      case 'genreShort':
        return S.of(context).genreShort;
      case 'genreSport':
        return S.of(context).genreSport;
      case 'genreTalkShow':
        return S.of(context).genreTalkShow;
      case 'genreThriller':
        return S.of(context).genreThriller;
      case 'genreWar':
        return S.of(context).genreWar;
      case 'genreWestern':
        return S.of(context).genreWestern;
      default:
        return this;
    }
  }
}
