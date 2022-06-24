import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guacatube/widgets/custom_sliver_appbar.dart';

import '../models/category.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  var categories = <Category>[];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height=MediaQuery.of(context).size.height;
    final double width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(

      ),
    );
  }
}
