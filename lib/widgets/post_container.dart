import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_responsive_ui_clone/config/palette.dart';
import 'package:facebook_responsive_ui_clone/models/post_model.dart';
import 'package:facebook_responsive_ui_clone/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PostContainer extends StatelessWidget {
  final Post post;
  const PostContainer({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    // todo: the border is not getting rounded
    return Card(
      margin: EdgeInsets.symmetric(
        vertical:  5.0,
        horizontal: isDesktop ? 5.0 : 0.0,
      ),
      elevation: isDesktop ? 1.0 : 0.0,
      shape: isDesktop
          ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
          : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _PostHeader(post: post),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(post.caption),
                  post.imageUrl == ''
                      ? const SizedBox.shrink()
                      : const SizedBox(height: 6.0)
                ],
              ),
            ),
            post.imageUrl == ''
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CachedNetworkImage(imageUrl: post.imageUrl),
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: _PostStats(
                post: post,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  final Post post;
  const _PostHeader({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(imageUrl: post.user.imageUrl),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.user.name,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            Row(
              children: [
                Text(
                  post.timeAgo + ' • ',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12.0,
                  ),
                ),
                Icon(
                  Icons.public,
                  color: Colors.grey[600],
                  size: 12.0,
                )
              ],
            )
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: () => debugPrint('More'),
          icon: const Icon(Icons.more_horiz),
        )
      ],
    );
  }
}

class _PostStats extends StatelessWidget {
  final Post post;
  const _PostStats({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Palette.facebookBlue,
              ),
              child: const Icon(
                Icons.thumb_up_rounded,
                size: 10,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '${post.likes}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const Spacer(),
            Text(
              '${post.comments} Comments',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(width: 8),
            Text(
              '${post.shares} Shares',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
        const Divider(height: 10, thickness: 0.5),
        Container(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () => debugPrint(
                  'Live',
                ),
                icon: Icon(
                  Icons.thumb_up_off_alt,
                  color: Colors.grey[600],
                ),
                label: Text(
                  'Like',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
              TextButton.icon(
                onPressed: () => debugPrint('Comment'),
                icon: Icon(MdiIcons.commentOutline, color: Colors.grey[600]),
                label: Text(
                  'Comment',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
              TextButton.icon(
                onPressed: () => debugPrint('Share'),
                icon: Icon(
                  MdiIcons.shareOutline,
                  color: Colors.grey[600],
                ),
                label: const Text(
                  'Share',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
