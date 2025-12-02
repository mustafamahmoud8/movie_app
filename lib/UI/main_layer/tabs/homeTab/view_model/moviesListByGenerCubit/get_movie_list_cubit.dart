import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/UI/main_layer/tabs/homeTab/model/movies_list_api.dart';
import 'package:movies_app/UI/main_layer/tabs/homeTab/model/movies_list_response.dart';
import 'package:movies_app/UI/main_layer/tabs/homeTab/view_model/moviesListByGenerCubit/get_movie_list_cubit_states.dart';

class GetMoviesCubit extends Cubit<GetMovieListCubitStates> {
  GetMoviesCubit() : super(GetMovieListInitialState());

  getMoviesListByGener(String gener1, String gener2, String gener3) async {
    emit(GetMovieListLoadingState());
    try {
      List<Movies>? availableNowSection =
          await MoviesListApi.getListMoviesByDate();
      List<Movies>? moviesListSectino1 =
          await MoviesListApi.getListMoviesByGener(gener1);
      List<Movies>? moviesListSectino2 =
          await MoviesListApi.getListMoviesByGener(gener2);
      List<Movies>? moviesListSectino3 =
          await MoviesListApi.getListMoviesByGener(gener3);

      if (moviesListSectino1 == null || moviesListSectino1.isEmpty) {
        emit(GetMovieListEmptyListState());
        return;
      }
      if (moviesListSectino2 == null || moviesListSectino2.isEmpty) {
        emit(GetMovieListEmptyListState());
        return;
      }
      if (moviesListSectino3 == null || moviesListSectino3.isEmpty) {
        emit(GetMovieListEmptyListState());
        return;
      }
      if (availableNowSection == null || availableNowSection.isEmpty) {
        emit(GetMovieListEmptyListState());
        return;
      }

      emit(GetMovieListSuccessState(
        availableNowSection: availableNowSection,
        moviesSection1: moviesListSectino1,
        moviesSection2: moviesListSectino2,
        moviesSection3: moviesListSectino3,
      ));
    } catch (e) {
      emit(GetMovieListFailureState(message: e.toString()));
    }
  }
}
