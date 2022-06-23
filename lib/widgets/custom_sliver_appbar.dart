import 'package:flutter/material.dart';

import '../data.dart';

class CustomSliverAppBar extends StatefulWidget {
  const CustomSliverAppBar({Key? key}) : super(key: key);

  @override
  _CustomSliverAppBarState createState() => _CustomSliverAppBarState();
}

class _CustomSliverAppBarState extends State<CustomSliverAppBar> {
  bool _isLogged = false;

  set isLogged(bool value) {
    setState(() {
      _isLogged = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      leadingWidth: 115,
      backgroundColor: Color.fromRGBO(103, 135, 94, 1),
      leading: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Image.asset('assets/img/logoTextWhite2.png')),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.notifications_none_outlined),
          onPressed: () {},
        ),
        _isLogged
            ? IconButton(
                iconSize: 30,
                icon: CircleAvatar(
                  foregroundImage: NetworkImage(currentUser.profileImageUrl),
                ),
                onPressed: () {},
              )
            : IconButton(
                icon: Icon(Icons.login_outlined),
                onPressed: () {},
              ),
      ],
    );
  }
}
