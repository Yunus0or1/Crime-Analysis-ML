import 'package:cached_network_image/cached_network_image.dart';
import 'package:safe_walk_mobile/src/store/store.dart';
import 'package:safe_walk_mobile/src/util/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  static final MainDrawer _drawer = new MainDrawer._internal();

  factory MainDrawer() {
    return _drawer;
  }

  MainDrawer._internal();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: buildDrawer(context),
    );
  }

  Widget buildDrawer(BuildContext context) {
    return Container();
  }


  Widget buildName() {
    return Container();
  }

  Widget buildImageWidget() {
    return Container();
  }
}
