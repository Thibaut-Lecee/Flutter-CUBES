import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../data.dart';

class VideoInfo extends StatelessWidget {
  const VideoInfo({
    Key? key,
    required this.video,
  }) : super(key: key);
  final Video video;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            video.title,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 8),
          Text(
            '${video.viewCount} views • ${timeago.format(video.timestamp)} ',
            style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 15),
          ),
          Divider(),
          _ActionsRow(video: video),
          Divider(),
          _UserInfo(user: currentUser, video: video),
        ],
      ),
    );
  }
}

class _ActionsRow extends StatelessWidget {
  const _ActionsRow({Key? key, required this.video}) : super(key: key);
  final Video video;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildAction(
          context,
          Icons.thumb_up,
          '${video.likes}',
        )
      ],
    );
  }

  Widget _buildAction(BuildContext context, IconData icon, String label) {

    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.grey),
          const SizedBox(height: 4),
          Text(label,
              style:
                  Theme.of(context).textTheme.caption!.copyWith(fontSize: 15)),
        ],
      ),
    );
  }
}

class _UserInfo extends StatelessWidget {
  const _UserInfo({Key? key, required this.user, required this.video}) : super(key: key);
  final User user;
final Video video;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ProfilePage(user: user),
        //   ),
        // );
      },
      child: Row(children: [
        CircleAvatar(
          backgroundImage: NetworkImage(user.profileImageUrl),
          radius: 20,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  user.username,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontSize: 15),
                ),
              ),
              Flexible(
                child: Text(
                  '${user.subscribers} subscribers',
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
        TextButton(
            onPressed: () {},
            child: Text(
              'Subscribe',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 18, color: Colors.red),
            )),
      ]),
    );
  }
}
