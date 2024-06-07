// import 'package:flutter/material.dart';
// import 'package:social_app/src/core/entites/post_entity.dart';
// import 'package:social_app/src/core/entites/user_info_entity.dart';
// import 'package:social_app/src/features/posts/presentation/widgets/comment_sheet_widget.dart';
// import 'package:social_app/src/features/posts/presentation/widgets/post_widget.dart';
// import 'package:social_app/src/features/profile/presentation/cubit/profile_cubit.dart';

// class PostDetailsScreen extends StatelessWidget {
//   const PostDetailsScreen({super.key, required this.postEntity});
//   final PostEntity postEntity;

//   @override
//   Widget build(BuildContext context) {
//     UserInfoEntity user = ProfileCubit.get(context).userInfo;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Post Details'),
//       ),
//       body: ListView(
//         children: [
//           PostWidget(
//             post: postEntity,
//             userEntity: user,
//             onDeletePost: () {},
//             isInDetailsScreen: true,
//           ),
//           CommentBottomSheetWidget(
//             postID: postEntity.id,
//             userEntity: user,
//             posterFCMToken: postEntity.writerFCMToken,
//           ),
//         ],
//       ),
//     );
//   }
// }
