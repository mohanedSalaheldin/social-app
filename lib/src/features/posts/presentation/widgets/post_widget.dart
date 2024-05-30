import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:social_app/src/core/entites/post_entity.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/utls/constants/constants.dart';
import 'package:social_app/src/core/utls/methods/methods.dart';
import 'package:social_app/src/core/utls/methods/screen_sizes.dart';
import 'package:social_app/src/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:social_app/src/features/posts/presentation/widgets/animated_like_button.dart';
import 'package:social_app/src/features/posts/presentation/widgets/comment_sheet_widget.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({
    super.key,
    required this.post,
    required this.userEntity,
    required this.onDeletePost,
  });
  final PostEntity post;
  final UserInfoEntity userEntity;
  final Function onDeletePost;

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onLikeButtonPressed() {
    setState(() {
      isLiked = !isLiked;
      if (isLiked) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // String uId = FirebaseAuth.instance.currentUser!.uid;

    // print('_------------- AUTH ----------------');
    // print(FirebaseAuth.instance.currentUser!.uid);
    // print(widget.userId);
    // print('_-------------- MODEL ---------------');

    bool isLikedPost = true;
    isLikedPost = widget.post.likes.contains(widget.userEntity.userId);
    String formattedDate = formateDate(date: widget.post.time.toString());

    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage:
                    NetworkImage(widget.post.userProfileImage.toString()),
              ),
              const Gap(10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.post.writtenBy.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    formattedDate,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              widget.userEntity.userId == widget.post.writerId
                  ? PopupMenuButton<int>(
                      color: backgroundColor,
                      icon: const Icon(Icons.more_vert, color: Colors.white),
                      onSelected: (item) {
                        if (item == 0) {}
                        if (item == 1) {
                          widget.onDeletePost();
                        }
                      },
                      position: PopupMenuPosition.under,
                      itemBuilder: (context) => const [
                        PopupMenuItem<int>(
                          value: 0,
                          child: Text(
                            'Update',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        PopupMenuItem<int>(
                          value: 1,
                          child: Text(
                            'Delete',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
          const Gap(10.0),
          Text(
            widget.post.text.toString(),
          ),
          const Gap(10.0),
          widget.post.imageUrl == null || widget.post.imageUrl == ''
              ? Container()
              : Image.network(
                  widget.post.imageUrl.toString(),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: ScreenSizes.width(context),
                ),
          const Gap(10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  AnimatedLikeButtonWidget(
                    userId: widget.userEntity.userId,
                    isLikedPost: isLikedPost,
                    postId: widget.post.id,
                  ),
                  const Gap(2.0),
                  IconButton(
                    onPressed: () {
                      showBottomSheet(
                          context: context,
                          builder: (context) {
                            context.read<PostsCubit>().getComments(
                                  postId: widget.post.id.toString(),
                                );
                            return CommentBottomSheetWidget(
                              postID: widget.post.id,
                              userEntity: widget.userEntity,
                            );
                          });
                    },
                    icon: const Icon(
                      Iconsax.message,
                      color: Colors.white,
                    ),
                  ),
                  const Gap(2.0),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Iconsax.send_2,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text: '${widget.post.likes.length} ',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text: 'Likes ',
                        ),
                        TextSpan(
                          text: '${widget.post.comments} ',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text: 'Comments',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
