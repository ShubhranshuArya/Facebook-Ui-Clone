import 'package:facebook_responsive_ui_clone/models/user_model.dart';
import 'package:facebook_responsive_ui_clone/widgets/widgets.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final User user;
  const UserCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min ,
      children: [
        ProfileAvatar(imageUrl: user.imageUrl),
        const SizedBox(width: 8.0),
        Flexible(
          child: Text(
            user.name,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
      ],
    );
  }
}
