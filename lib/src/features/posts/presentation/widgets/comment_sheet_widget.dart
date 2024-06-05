import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/utls/methods/methods.dart';
import 'package:social_app/src/core/utls/methods/screen_sizes.dart';
import 'package:social_app/src/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:social_app/src/features/posts/domain/entities/comment_entity.dart';
import 'package:social_app/src/features/posts/presentation/cubit/posts_cubit.dart';

class CommentBottomSheetWidget extends StatelessWidget {
  CommentBottomSheetWidget({
    super.key,
    required this.postID,
    required this.userEntity,
    required this.posterFCMToken,
  });
  final String postID;
  final String posterFCMToken;
  final UserInfoEntity userEntity;
  final outlineInputBorder = const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
      ),
      borderRadius: BorderRadius.all(Radius.circular(30)));
  final commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state) {
        return Container(
          height: ScreenSizes.height(context) * .75,
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: HexColor('#21232a'),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                width: ScreenSizes.width(context) * .1,
                child: Divider(
                  color: Colors.grey[400],
                  thickness: 3.0,
                ),
              ),
              Expanded(
                child: StreamBuilder<List<CommentEntity>>(
                    stream: PostsCubit.get(context).commentList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      }
                      return ListView.separated(
                        itemBuilder: (context, index) => CommentEntryWidget(
                          commentEntity: snapshot.data![index],
                        ),
                        separatorBuilder: (context, index) => const Gap(10.0),
                        itemCount: snapshot.data!.length,
                      );
                    }),
              ),
              // const Spacer(),
              const Gap(10.0),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: commentController,
                      minLines: 1,
                      maxLines: 2,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 14.0),
                      // expands: true,
                      decoration: InputDecoration(
                        // hintMaxLines: 3,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        enabledBorder: outlineInputBorder,
                        border: outlineInputBorder,
                        focusedBorder: outlineInputBorder,
                        hintText: 'What\'s on your mind?',
                      ),
                      onFieldSubmitted: (value) {},
                    ),
                  ),
                  const Gap(10.0),
                  IconButton(
                    onPressed: () {
                      if (commentController.text.trim() != '') {
                        context
                            .read<NotificationCubit>()
                            .sendCommentNotification(
                              receiverToken: posterFCMToken,
                              senderName: userEntity.userName.toString(),
                            );
                        PostsCubit.get(context).addComment(
                          comment: CommentEntity(
                            postId: postID,
                            id: 'id',
                            writerName: userEntity.userName.toString(),
                            writerProfileImage:
                                userEntity.profileImageURL.toString(),
                            text: commentController.text,
                            time: DateTime.now().toString(),
                          ),
                        );
                        FocusScope.of(context).unfocus();
                        commentController.clear();
                      }
                    },
                    icon: const Icon(
                      Iconsax.send_1,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class CommentEntryWidget extends StatelessWidget {
  const CommentEntryWidget({
    super.key,
    required this.commentEntity,
  });
  final CommentEntity commentEntity;

  @override
  Widget build(BuildContext context) {
    String formattedDate = formateDate(date: commentEntity.time);

    return Row(
      children: [
        CircleAvatar(
          radius: 20.0,
          backgroundImage: NetworkImage(commentEntity.writerProfileImage),
        ),
        const Gap(10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  commentEntity.writerName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                const Gap(5.0),
                Text(
                  formattedDate,
                  style: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: ScreenSizes.width(context) * .7,
              child: Text(
                commentEntity.text,
                style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
