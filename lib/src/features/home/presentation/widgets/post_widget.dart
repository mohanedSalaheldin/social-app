import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
            errorBuilder: (context, error, stackTrace) => SizedBox(
              width: double.infinity,
              height: ScreenSizes.width(context),
              child: Center(
                child: Text('😢 we are sory $error'),
              ),
            ),
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
                    onPressed: () {
                      showBottomSheet(
                          context: context,
                          builder: (context) {
                            return const CommentBottomSheetWidget();
                          });
                    },
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
                    // overflow: ,
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 14.0,
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

class CommentBottomSheetWidget extends StatelessWidget {
  const CommentBottomSheetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSizes.height(context) * .75,
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 231, 236, 237),
        borderRadius: BorderRadius.only(
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
            child: ListView.separated(
              itemBuilder: (context, index) => const CommentEntryWidget(),
              separatorBuilder: (context, index) => const Gap(10.0),
              itemCount: 10,
            ),
          ),
          // const Spacer(),
          const Gap(10.0),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  minLines: 1,
                  maxLines: 3,
                  // expands: true,
                  decoration: const InputDecoration(
                    // hintMaxLines: 3,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: 'What\'s on your mind?',
                  ),
                  onFieldSubmitted: (value) {},
                ),
              ),
              const Gap(10.0),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.send),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CommentEntryWidget extends StatelessWidget {
  const CommentEntryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 20.0,
          backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'), // NetworkImage
        ),
        const Gap(10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Text(
                  'username',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                Gap(5.0),
                Text(
                  '5h',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: ScreenSizes.width(context) * .7,
              child: const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
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
