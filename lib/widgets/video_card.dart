import 'package:flutter/material.dart';
import 'package:guacatube/data.dart';
import 'package:timeago/timeago.dart' as timeago; // timeago.format(DateTime.now())

class VideoCard extends StatelessWidget {
  const VideoCard({Key? key, required this.video}) : super(key: key);
  final Video video;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  color: Colors.black.withOpacity(0.5),
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
          padding: const EdgeInsets.all(8.0),
       child : Row(
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
            const SizedBox(width: 8),
            Expanded(
            child :Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(video.title,
              maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15),
            ),
                Text(
                    '${video.author.username} * ${video.viewCount} * ${timeago.format(video.timestamp)}'),
              ],


            ),
        ),

          ],

        ),
        ),
      ],
    );
  }
}
