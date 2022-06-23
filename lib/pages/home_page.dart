import 'package:flutter/material.dart';
import 'package:guacatube/data.dart';

import '../widgets/custom_sliver_appbar.dart';
import '../widgets/video_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        CustomSliverAppBar(),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => VideoCard(video: videos[index]),
            childCount: videos.length,
          ),
        ),
      ],
    ));
  }
}
