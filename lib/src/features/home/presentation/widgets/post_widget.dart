import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_app/src/core/entites/post_entity.dart';
import 'package:social_app/src/core/utls/methods/screen_sizes.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({
    super.key,
    required this.post,
    required this.onDeletePost,
  });
  final PostEntity post;
  final Function onDeletePost;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(20.0),
      //   // color: const Color.fromARGB(255, 242, 243, 245),
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(post.imageUrl.toString()),
              ),
              const Gap(10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.writtenBy.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    post.time.toString(),
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              PopupMenuButton<int>(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                onSelected: (item) {
                  if (item == 0) {}
                  if (item == 1) {
                    onDeletePost();
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
              ),
            ],
          ),
          const Gap(10.0),
          Text(
            post.text.toString(),
          ),
          const Gap(10.0),
          Image.network(
            post.imageUrl.toString(),
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
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_outline),
                  ),
                  const Gap(2.0),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.chat_bubble_outline),
                  ),
                  const Gap(2.0),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.send_outlined),
                  ),
                ],
              ),
              Row(
                children: [
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: '100k ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'Likes ',
                        ),
                        TextSpan(
                          text: '200k ',
                        ),
                        TextSpan(
                          text: 'Comments',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
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
