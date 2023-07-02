import 'package:animeto/bussiness_logic/cubit/anime/anime_cubit.dart';
import 'package:animeto/bussiness_logic/cubit/search_bar/search_bar_cubit.dart';
import 'package:animeto/constants/strings.dart';
import 'package:animeto/data/repository/all_anime_repo.dart';
import 'package:animeto/data/repository/filter_anime_repo.dart';
import 'package:animeto/data/web_services/dio_web_services.dart';
import 'package:animeto/ui/pages/anime_page.dart';
import 'package:animeto/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bussiness_logic/cubit/filter/filter_cubit.dart';

class AppRouter {
  late AllAnimeRepo allAnimeRepo;
  late AllAnimeCubit animeCubit;
  AppRouter() {
    allAnimeRepo = AllAnimeRepo(dioApi: DioApi());
    animeCubit = AllAnimeCubit(allAnimeRepo);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case kHomePage:
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider(
                    create: (context) => animeCubit..getAllAnimes(),
                  ),
                  BlocProvider(
                    create: (context) => SearchBarCubit(),
                  ),
                  BlocProvider(
                    create: (context) =>
                        FilterCubit(AnimeFilterRepo(dioApi: DioApi())),
                  ),
                ], child: HomePage()));
      case kAnimePage:
        return MaterialPageRoute(
          builder: (context) => animePage(),
        );
    }
  }
}
