import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/UI/main_layer/provider/selected_cat_provider.dart';
import 'package:movies_app/UI/main_layer/tabs/exploreTab/view/explore_tab_screen.dart';
import 'package:movies_app/UI/main_layer/tabs/homeTab/view/home_tab_screen.dart';
import 'package:movies_app/UI/main_layer/tabs/profileTab/view/profile_tab_screen.dart';
import 'package:movies_app/UI/main_layer/tabs/searchTab/view/search_tab_screen.dart';
import 'package:movies_app/UI/main_layer/tabs/searchTab/view_model/search_movies_cubit.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';

final ValueNotifier<int> currentIndex = ValueNotifier<int>(0);

class MainLayerScreen extends StatefulWidget {
  static const String routeName = '/mainLayerScreen';

  const MainLayerScreen({super.key});

  @override
  State<MainLayerScreen> createState() => _MainLayerScreenState();
}

class _MainLayerScreenState extends State<MainLayerScreen> {
  List<Widget> tabs = [
    const HomeTabScreen(),
    BlocProvider(
        create: (context) => SearchMoviesCubit(),
        child: const SearchTabScreen()),
    const ExploreTabScreen(),
    const ProfileTabScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentIndex,
      builder: (context, value, _) => Scaffold(
          extendBody: true,
          bottomNavigationBar: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.grey,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BottomNavigationBar(
                onTap: (value) {
                  setState(() {
                    currentIndex.value = value;
                    context.read<SelectedCatProvider>().unSelectCat();
                  });
                },
                currentIndex: value,
                items: [
                  BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage(AppAssets.homeIcon)),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage(AppAssets.searchIcon)),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage(AppAssets.exploreIcon)),
                    label: 'Explore',
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage(AppAssets.profileIcon)),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
          body: tabs[value]),
    );
  }
}
