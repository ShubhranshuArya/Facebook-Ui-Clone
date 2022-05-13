import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_responsive_ui_clone/config/palette.dart';
import 'package:facebook_responsive_ui_clone/models/story_model.dart';
import 'package:facebook_responsive_ui_clone/models/user_model.dart';
import 'package:facebook_responsive_ui_clone/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Stories extends StatelessWidget {
  final User currentUser;
  final List<Story> stories;
  const Stories({
    Key? key,
    required this.currentUser,
    required this.stories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Responsive.isDesktop(context) ? Colors.transparent : Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 1 + stories.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
              child: _StoryCard(
                isAddStory: true,
                currentUser: currentUser,
              ),
            );
          }
          final Story story = stories[index - 1];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
            child: _StoryCard(
              story: story,
            ),
          );
        },
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  final User? currentUser;
  final bool? isAddStory;
  final Story? story;
  const _StoryCard({
    Key? key,
    this.currentUser,
    this.isAddStory = false,
    this.story,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: CachedNetworkImage(
            imageUrl: isAddStory! ? currentUser!.imageUrl : story!.imageUrl,
            width: 110,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: double.infinity,
          width: 110,
          decoration: BoxDecoration(
            gradient: Palette.storyGradient,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: Responsive.isDesktop(context) ? [
              const BoxShadow(
                color: Colors.black12,
                blurRadius: 4.0,
                offset: Offset(0, 2),
              )
            ] : null,
          ),
        ),
        Positioned(
            left: 8.0,
            top: 8.0,
            child: isAddStory!
                ? Container(
                    height: 36,
                    width: 36,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => debugPrint("Add a new story"),
                      icon: const Icon(
                        Icons.add_rounded,
                        color: Palette.facebookBlue,
                      ),
                    ),
                  )
                : ProfileAvatar(
                    imageUrl: story!.user.imageUrl,
                    hasBorder: story!.isViewed,
                  )),
        Positioned(
          left: 8.0,
          bottom: 8.0,
          right: 8.0,
          child: Text(
            isAddStory! ? 'Add a story' : story!.user.name,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
