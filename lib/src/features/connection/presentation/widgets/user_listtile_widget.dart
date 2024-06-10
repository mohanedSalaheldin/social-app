import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/src/config/routes/navigate_methods.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/utls/widgets/custom_buttons.dart';
import 'package:social_app/src/features/connection/presentation/cubit/search_cubit.dart';
import 'package:social_app/src/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:social_app/src/features/profile/presentation/pages/prfile_screen.dart';

class UserListTileWidget extends StatefulWidget {
  const UserListTileWidget({
    super.key,
    required this.otherUser,
    required this.currentUser,
    required this.isSearched,
  });
  final UserInfoEntity otherUser;
  final UserInfoEntity currentUser;
  final bool isSearched;

  @override
  State<UserListTileWidget> createState() => _UserListTileWidgetState();
}

class _UserListTileWidgetState extends State<UserListTileWidget> {
  @override
  Widget build(BuildContext context) {
    //  context.read<>;
    bool isFollowed = false;
    isFollowed = widget.currentUser.following.contains(widget.otherUser.userId);
    print(isFollowed);
    return Card(
      // color: const Color.fromARGB(0, 79, 114, 201),
      child: SizedBox(
        height: 80.0,
        child: InkWell(
          onTap: () {
            navigateToScreen(
                context,
                ProfileScreen(
                  userID: widget.otherUser.userId,
                ));
          },
          borderRadius: BorderRadius.circular(10.0),
          splashColor: Colors.transparent,
          child: Center(
            child: ListTile(
              leading: CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(
                  widget.otherUser.profileImageURL,
                ),
              ),
              title: Text(
                widget.otherUser.userName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              subtitle: Text(
                widget.otherUser.address,
                style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.white70,
                ),
              ),
              trailing: widget.isSearched
                  ? MyCustomizedElevatedButtonSmall(
                      backgroundColor: isFollowed ? Colors.grey : null,
                      onPressed: () {
                        navigateToScreen(
                            context, ProfileScreen(userID: widget.otherUser.userId));
                      },
                      text: 'View Profile',
                    )
                  : MyCustomizedElevatedButtonSmall(
                      backgroundColor: isFollowed ? Colors.grey : null,
                      onPressed: () {
                        if (!isFollowed) {
                          context
                              .read<NotificationCubit>()
                              .sendNewFollowerNotification(
                                receiverToken: widget.otherUser.fcmToken,
                                senderName: widget.currentUser.userName,
                              );
                        }
                        ConnectionCubit.get(context).followUnfollowUser(
                            otherUserId: widget.otherUser.userId,
                            currentUserId: widget.currentUser.userId);
                      },
                      text: isFollowed ? 'Unfollow' : 'Follow',
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
