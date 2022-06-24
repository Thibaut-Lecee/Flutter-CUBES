import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guacatube/data.dart';
import 'package:guacatube/pages/nav_page.dart';
import 'package:guacatube/widgets/video_card.dart';
import 'package:guacatube/widgets/video_info_card.dart';
import 'package:miniplayer/miniplayer.dart';

class VideoPage extends StatefulWidget {
  @override
  VideoPageState createState() => VideoPageState();
}

class VideoPageState extends State<VideoPage> {
  ScrollController? _scrollController;

  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read(miniPlayerController).state.animateToHeight(
          state: PanelState.MAX, duration: const Duration(milliseconds: 500)),
      child: Scaffold(
        body: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: CustomScrollView(
                controller: _scrollController,
                shrinkWrap: true, slivers: [
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
                                .animateToHeight(
                                    state: PanelState.MIN,
                                    duration:
                                        const Duration(milliseconds: 500));
                            ;
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
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final video = suggestedVideos[index];
                      return VideoCard(
                          video: video,
                          onTap: () => _scrollController!.animateTo(0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut));
                    },
                    childCount: suggestedVideos.length,
                  ),
                ),
              ),
            ])),
      ),
    );
  }
} // end class _VideoPageState
