import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guacatube/pages/nav_page.dart';
import 'package:guacatube/widgets/video_info_card.dart';
import 'package:miniplayer/miniplayer.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: CustomScrollView(shrinkWrap: true, slivers: [
            SliverToBoxAdapter(child: Consumer(builder: (context, watch, _) {
              final selectedVideo = watch(selectVideoProvider).state;
              return SafeArea(
                child: Column(
                  children: [
                    Stack(children: [
                      Image.network(
                        selectedVideo!.thumbnailUrl,
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      IconButton(
                        icon: Icon(Icons.keyboard_arrow_down_outlined),
                        onPressed: () {
                          context
                              .read(miniPlayerController)
                              .state
                              .animateToHeight(state: PanelState.MIN);
                        },
                      )
                    ]),
                    const LinearProgressIndicator(
                      value: 0.6,
                      valueColor: AlwaysStoppedAnimation(Colors.red),
                    ),
                    VideoInfo(video: selectedVideo)
                  ],
                ),
              );
            })),
          ])),
    );
  }
}
