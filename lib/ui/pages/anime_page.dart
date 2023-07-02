import 'package:animeto/constants/my_color.dart';
import 'package:animeto/data/models/anime_model.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class animePage extends StatelessWidget {
  AnimeModel? anime;
  static String id = 'animePage';
  YoutubePlayerController? _controller;
  animePage({super.key, this.anime}) {
    _controller = YoutubePlayerController(
      initialVideoId:
          anime!.trailer!.url.substring(anime!.trailer!.url.indexOf('=') + 1),
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Text(anime!.title),
            bottom: const TabBar(tabs: [
              Tab(
                child: Text("Description"),
              ),
              Tab(
                child: Text("episodes"),
              ),
              Tab(
                child: Text("review"),
              ),
            ]),
          ),
          body: TabBarView(children: [
            ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        opacity: 0.7,
                        image: NetworkImage(anime!.image),
                        fit: BoxFit.fill),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          Colors.black.withOpacity(0.2),
                          Colors.white.withOpacity(0.2),
                          Colors.white,
                        ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 250,
                            width: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              image: DecorationImage(
                                  image: NetworkImage(anime!.image),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  anime!.title,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  anime!.status.state,
                                ),
                                Text(
                                  anime!.year,
                                ),
                                Text(
                                  anime!.rating,
                                ),
                                Text(
                                  "${anime!.episodes} episodes",
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 30,
                          ),
                          Text("${anime!.score}")
                        ],
                      ),
                      Column(
                        children: [
                          Image.asset(
                            "assets/images/icons/ranking.png",
                            scale: 12,
                          ),
                          Text("${anime!.rank}")
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2,
                            spreadRadius: 0.5,
                            offset: Offset(1, 1)),
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(anime!.synopsis),
                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: anime!.genres.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 7),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 1),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey[400]),
                              child: Center(
                                  child: Text(
                                "${anime!.genres[index].type}",
                              )),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                anime!.trailer!.url != '?'
                    ? Container(
                        height: 200,
                        width: double.infinity,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: YoutubePlayer(
                            controller: _controller!,
                            showVideoProgressIndicator: true,
                            progressIndicatorColor: MyColors.mainColor,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            ListView(
              children: [
                Container(
                  child: const Text("data"),
                ),
              ],
            ),
            ListView(
              children: [
                Container(
                  child: const Text("data"),
                )
              ],
            ),
          ])),
    );
  }
}
