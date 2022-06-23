import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guacatube/pages/video_page.dart';
import 'package:miniplayer/miniplayer.dart';

import '../data.dart';
import 'home_page.dart';

final selectVideoProvider = StateProvider<Video?>((ref) => null);
final miniPlayerController = StateProvider.autoDispose<MiniplayerController>((ref) => MiniplayerController());

class NavPage extends StatefulWidget {
  const NavPage({Key? key}) : super(key: key);

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int _currentIndex = 0;

  final _pages = [
    const HomePage(),
    const Scaffold(body: Center(child: Text('Explore'))),
    const Scaffold(body: Center(child: Text('Liked'))),
    const Scaffold(body: Center(child: Text('Account')))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, watch, _) {
          final selectedVideo = watch(selectVideoProvider).state;
          final miniplayerController = watch(miniPlayerController).state;
          return Stack(
              children: _pages
                  .asMap()
                  .map(
                    (index, page) => MapEntry(
                      index,
                      Offstage(offstage: index != _currentIndex, child: page),
                    ),
                  )
                  .values
                  .toList()
                ..add(
                  Offstage(
                    offstage: selectedVideo == null,
                    child: Miniplayer(
                      controller: miniplayerController,
                      minHeight: 60,
                      maxHeight: MediaQuery.of(context).size.height,
                      builder: (height, width) {
                        if (selectedVideo == null) {
                          return const SizedBox.shrink();
                        }
                        if(height <= 190) {
                          return Container(
                            color: Theme
                                .of(context)
                                .scaffoldBackgroundColor,
                            child: Column(
                              children: [
                                Row(children: [
                                  Image.network(
                                    selectedVideo.thumbnailUrl,
                                    height: 56,
                                    width: 110,
                                    fit: BoxFit.cover,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              selectedVideo.title,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                                selectedVideo.author.username,
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .caption!
                                                    .copyWith(
                                                    fontSize: 14,
                                                    fontWeight:
                                                    FontWeight.w400)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.play_arrow),
                                    onPressed: () {},
                                  ),
                                  IconButton(icon:
                                  Icon(Icons.close), onPressed: () {
                                    context
                                        .read(selectVideoProvider)
                                        .state = null;
                                  })
                                ]),
                                const LinearProgressIndicator(
                                  value: 0.6,
                                  valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.red),
                                )
                              ],
                            ),
                          );
                        }
                        return VideoPage();
                      },
                    ),
                  ),
                ));
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(103, 135, 94, 1),
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_off_outlined),
            activeIcon: Icon(Icons.explore),
            label: 'Explore',
          ),

          // if isLogged can see liked and account

          BottomNavigationBarItem(
            icon: Icon(Icons.thumb_up_outlined),
            activeIcon: Icon(Icons.thumb_up),
            label: 'Liked',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_outlined),
            activeIcon: Icon(Icons.account_box),
            label: 'Account',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
      ),
    );
  }
}
