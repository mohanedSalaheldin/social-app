
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_app/src/core/utls/methods/screen_sizes.dart';

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
