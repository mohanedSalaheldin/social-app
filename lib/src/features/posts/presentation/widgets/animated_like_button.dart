
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_app/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:social_app/src/features/home/presentation/cubit/home_state.dart';

class AnimatedLikeButtonWidget extends StatefulWidget {
  const AnimatedLikeButtonWidget({
    super.key,
    required this.isLikedPost,
    required this.postId,
    required this.userId,
  });

  final bool isLikedPost;
  final String postId;
  final String userId;

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedLikeButtonWidgetState createState() =>
      _AnimatedLikeButtonWidgetState();
}

class _AnimatedLikeButtonWidgetState extends State<AnimatedLikeButtonWidget> {
  bool isLiked = true;

  @override
  Widget build(BuildContext context) {
    isLiked = widget.isLikedPost;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
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
              setState(() {
                isLiked = !isLiked;
                HomeCubit.get(context).likeOrDislikePost(
                    postId: widget.postId, userId: widget.userId);
              });
            },
          ),
        );
      },
    );
  }
}