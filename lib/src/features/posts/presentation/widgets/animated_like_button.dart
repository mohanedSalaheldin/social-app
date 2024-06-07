import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_app/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:social_app/src/features/home/presentation/cubit/home_state.dart';
import 'package:social_app/src/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:social_app/src/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:social_app/src/features/profile/presentation/cubit/profile_cubit.dart';

class AnimatedLikeButtonWidget extends StatefulWidget {
  const AnimatedLikeButtonWidget({
    super.key,
    required this.isLikedPost,
    required this.postId,
    required this.userId,
    required this.posterFCMToken,
  });

  final bool isLikedPost;
  final String postId;
  final String userId;
  final String posterFCMToken;

  @override
  State<AnimatedLikeButtonWidget> createState() =>
      _AnimatedLikeButtonWidgetState();
}

class _AnimatedLikeButtonWidgetState extends State<AnimatedLikeButtonWidget> {
  bool isLiked = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLiked = widget.isLikedPost;
  }

  // bool isFa = true;
  @override
  Widget build(BuildContext context) {
    // isLiked = widget.isLikedPost;
    String currentUserName = context.read<ProfileCubit>().userInfo.userName;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: IconButton(
        key: ValueKey<bool>(isLiked),
        icon: Icon(
          isLiked ? Iconsax.heart5 : Iconsax.heart,
          color: isLiked ? Colors.red : Colors.white,
        ),
        onPressed: () {
          if (!isLiked) {
            context.read<NotificationCubit>().sendLikeNotification(
                receiverToken: widget.posterFCMToken,
                senderName: currentUserName);
          }
          setState(() {
            isLiked = !isLiked;
            context.read<PostsCubit>().likeOrDislikePost(
                postId: widget.postId, userId: widget.userId);
          });
        },
      ),
    );
  }
}

class HeartBButton extends StatefulWidget {
  const HeartBButton({super.key});

  @override
  State<HeartBButton> createState() => _HeartBButtonState();
}

class _HeartBButtonState extends State<HeartBButton> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
