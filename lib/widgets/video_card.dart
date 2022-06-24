import 'package:flutter/material.dart';
import 'package:guacatube/data.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../pages/nav_page.dart'; // timeago.format(DateTime.now())
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoCard extends StatelessWidget {
  const VideoCard({Key? key, required this.video, this.onTap})
      : super(key: key);
  final Video video;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read(selectVideoProvider).state = video;
        context.read(miniPlayerController).state.animateToHeight(
            state: PanelState.MAX,
            duration: const Duration(milliseconds: 500));
        if (onTap != null) onTap!();
      },
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(
                video.thumbnailUrl,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                  bottom: 6.0,
                  right: 6.0,
                  child: Container(
                    color: Colors.black.withOpacity(0.7),
                    child: Text(
                      video.duration,
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: Colors.white),
                    ),
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => VideoPage(video: video),
                    //   ),
                    // );
                    print('Tapped');
                  },
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(video.author.profileImageUrl),
                  ),
                ),
                const SizedBox(width: 8.5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          video.title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 15),
                        ),
                      ),
                      Flexible(
                        child: Text(
                            '${video.author.username}'
                            ' * ${video.viewCount} views'
                            ' * ${video.likes} likes'
                            ' * ${timeago.format(video.timestamp)}',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.white, fontSize: 14)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
