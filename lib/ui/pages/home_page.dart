// ignore_for_file: must_be_immutable

import 'package:animeto/bussiness_logic/cubit/anime/anime_cubit.dart';
import 'package:animeto/bussiness_logic/cubit/anime/anime_state.dart';
import 'package:animeto/bussiness_logic/cubit/filter/filter_cubit.dart';
import 'package:animeto/bussiness_logic/cubit/filter/filter_state.dart';
import 'package:animeto/bussiness_logic/cubit/search_bar/search_bar_cubit.dart';
import 'package:animeto/bussiness_logic/cubit/search_bar/search_bar_state.dart';
import 'package:animeto/data/models/anime_model.dart';
import 'package:animeto/ui/pages/anime_page.dart';
import 'package:animeto/ui/widgets/bottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../../constants/my_color.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  List<AnimeModel> searchedAnimes = [];
  TextEditingController textController = TextEditingController();
  int page = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: BlocConsumer<SearchBarCubit, SearchBarState>(
            listener: (context, state) {
              if (state is SearchBarActive) {
                searchedAnimes = state.searchedAnimes;
                BlocProvider.of<AllAnimeCubit>(context)
                    .searched(searchedAnimes: searchedAnimes);
              } else {
                BlocProvider.of<AllAnimeCubit>(context).fullAnimes();
              }
            },
            builder: (context, state) {
              if (state is SearchBarNotActive) {
                return NormalAppBar();
              } else {
                return SearchAppBar(
                  searchedAnimes:
                      BlocProvider.of<SearchBarCubit>(context).searchedAnimes,
                  textController: textController,
                );
              }
            },
          ),
        ),
        body: OfflineBuilder(
          connectivityBuilder: (context, connectivity, child) {
            final bool connected = connectivity != ConnectivityResult.none;
            return connected
                ? BlocBuilder<AllAnimeCubit, AllAnimeState>(
                    builder: (context, state) {
                      if (state is AllAnimeSuccess) {
                        return SucessBody(
                          animes: state.allAnimes,
                          displayType: 0,
                        );
                      } else if (state is AllAnimeFailure) {
                        return const Center(child: Text('failed'));
                      } else if (state is SearchedAnimeSuccess) {
                        return searchedAnimes.isNotEmpty
                            ? SucessBody(
                                animes: searchedAnimes,
                                displayType: 1,
                              )
                            : Center(
                                child:
                                    Image.asset("assets/images/404 error.png"));
                      } else if (state is FilteredAnimeSuccess) {
                        return SucessBody(
                          animes: state.filteredAnimes,
                          displayType: 2,
                        );
                      } else {
                        return Center(
                            child: Image.asset(
                          "assets/images/loading/item_loading.gif",
                          scale: 8,
                        ));
                      }
                    },
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Center(child: Text("Connecion lost")),
                      Image.asset(
                        "assets/images/offline.png",
                        fit: BoxFit.fill,
                      ),
                    ],
                  );
          },
          child: const CircularProgressIndicator(),
        ));
  }
}

class SucessBody extends StatelessWidget {
  int displayType = 0;
  List<AnimeModel> animes = [];
  String status = '';
  late bool loading;
  late ScrollController controller;
  SucessBody({super.key, required this.animes, required this.displayType});

  @override
  Widget build(BuildContext context) {
    if (displayType == 1) {
      controller = BlocProvider.of<SearchBarCubit>(context).controller;
      loading = BlocProvider.of<SearchBarCubit>(context).isLoadingMore;
    } else if (displayType == 2) {
      controller = BlocProvider.of<FilterCubit>(context).controller;
      loading = BlocProvider.of<FilterCubit>(context).isLoadingMore;
    } else {
      controller = BlocProvider.of<AllAnimeCubit>(context).controller;
      loading = BlocProvider.of<AllAnimeCubit>(context).isLoadingMore;
    }

    return GridView.builder(
      controller: controller,
      itemCount: loading ? animes.length + 1 : animes.length,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
          childAspectRatio: 1 / 1.7),
      itemBuilder: (context, index) {
        if (animes.isNotEmpty) {
          return index + 1 > animes.length
              ? const Center(child: CircularProgressIndicator())
              : GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => animePage(anime: animes[index]),
                        ));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: GridTile(
                      footer: GridTileBar(
                        backgroundColor: MyColors.mainColor.withOpacity(0.4),
                        title: Text(
                          animes[index].title,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Row(
                          children: [
                            Text(status),
                            const Spacer(),
                            Text("${animes[index].score}"),
                          ],
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7)),
                        child: animes[index].image.isEmpty
                            ? Image.asset(
                                "assets/images/loading/main_loading.gif",
                                scale: 8,
                              )
                            : FadeInImage.assetNetwork(
                                placeholder:
                                    "assets/images/loading/item_loading.gif",
                                placeholderCacheWidth: 50,
                                placeholderScale: 8,
                                image: animes[index].image,
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                  ),
                );
        }
        return null;
      },
    );
  }
}

class NormalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  NormalAppBar({
    this.height = kToolbarHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Animeto"),
      actions: [
        IconButton(
            onPressed: () {
              BlocProvider.of<SearchBarCubit>(context)
                  .changeSearchBarState(isActive: true);
            },
            icon: const Icon(Icons.search)),
        IconButton(
            onPressed: () {
              BottomSheetModel().runBottomSheet(context: context);
            },
            icon: BlocListener<FilterCubit, FilterState>(
                listener: (context, state) {
                  if (state is Filtered) {
                    BlocProvider.of<AllAnimeCubit>(context).filter(
                        filteredAnimes: BlocProvider.of<FilterCubit>(context)
                            .filteredAnimes);
                  }
                },
                child: const Icon(Icons.filter_alt))),
      ],
    );
  }
}

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  List<AnimeModel> searchedAnimes = [];
  TextEditingController textController;
  SearchAppBar({
    super.key,
    this.height = kToolbarHeight,
    required this.searchedAnimes,
    required this.textController,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextField(
        controller: textController,
        cursorColor: Colors.white,
        decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Search",
            hintStyle: TextStyle(color: Colors.grey)),
        onChanged: (value) {
          BlocProvider.of<SearchBarCubit>(context).searchValue = value;
          if (value.isNotEmpty) {
            BlocProvider.of<SearchBarCubit>(context)
                .getSearchedAnime(searchValue: value);
          } else {
            BlocProvider.of<SearchBarCubit>(context)
                .emptySearch(allAnimes: searchedAnimes);
          }
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            textController.clear();
            BlocProvider.of<SearchBarCubit>(context)
                .emptySearch(allAnimes: searchedAnimes);
          },
        )
      ],
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          BlocProvider.of<SearchBarCubit>(context)
              .changeSearchBarState(isActive: false);
        },
      ),
    );
  }
}
