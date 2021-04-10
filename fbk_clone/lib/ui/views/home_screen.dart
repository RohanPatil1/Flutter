import 'file:///G:/MyGithub/Flutter/fbk_clone/lib/ui/shared/palette.dart';
import 'package:fbk_clone/core/data/data.dart';
import 'package:fbk_clone/core/models/post_model.dart';
import 'package:fbk_clone/core/viewmodels/home_view_model.dart';
import 'package:fbk_clone/ui/views/base_view.dart';
import 'package:fbk_clone/ui/widgets/widgets.dart';

import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: _HomeScreenMobile(),
        desktop: _HomeScreenDesktop(),
      ),
    );
  }
}

class _HomeScreenMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      onModelReady: (model) => model.getUserName(),
      builder: (context, model, child) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              brightness: Brightness.light,
              backgroundColor: Colors.white,
              title: Text(
                "facebook",
                style: const TextStyle(
                    color: Palette.facebookBlue,
                    fontSize: 28.0,
                    letterSpacing: -1.2,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: false,
              floating: true,
              actions: [
                GreyCircularrBtn(
                    icon: Icons.search, iconSize: 30.0, onPressed: () {}),
                GreyCircularrBtn(
                    icon: MdiIcons.facebookMessenger,
                    iconSize: 30.0,
                    onPressed: () {}),
              ],
            ),
            SliverToBoxAdapter(
              child: UploadPostContainer(
                currUser: model.currUser,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
              sliver: SliverToBoxAdapter(
                child: Rooms(onlineUsers: onlineUsers),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
              sliver: SliverToBoxAdapter(
                child: Stories(
                  currentUser: currentUser,
                  stories: stories,
                ),
              ),
            ),
            // SliverList(
            //     delegate: SliverChildBuilderDelegate((context, index) {
            //   final Post currPost = model.posts[index];
            //
            //   return PostContainer(
            //     post: currPost,
            //   );
            // }, childCount: posts.length))
          ],
        );
      },
    );
  }
}

class _HomeScreenDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: MoreOptionsList(
                    currentUser: currentUser,
                  )),
            )),
        const Spacer(),
        Container(
          width: 600.0,
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                sliver: SliverToBoxAdapter(
                  child: Stories(
                    currentUser: currentUser,
                    stories: stories,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: UploadPostContainer(),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                sliver: SliverToBoxAdapter(
                  child: Rooms(onlineUsers: onlineUsers),
                ),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                final Post currPost = posts[index];
                return PostContainer(
                  post: currPost,
                );
              }, childCount: posts.length))
            ],
          ),
        ),
        const Spacer(),
        Flexible(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ContactsList(users: onlineUsers),
              ),
            )),
      ],
    );
  }
}
