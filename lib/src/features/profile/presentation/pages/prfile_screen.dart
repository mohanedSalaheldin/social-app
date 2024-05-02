import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/src/features/home/presentation/widgets/post_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const ProfileWidget(),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  '100',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('followers'),
              ],
            ),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.black,
              backgroundImage: NetworkImage('https://loremflickr.com/640/640'),
            ),
            Column(
              children: [
                Text(
                  '100',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('following'),
              ],
            ),
          ],
        ),
        const Gap(20),
        const Column(
          children: [
            Text(
              'John Doe',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Software Developer @ X'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on),
                Text('New York, USA'),
              ],
            ),
          ],
        ),
        const Gap(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  HexColor('#7737ff'),
                ),
                padding: const MaterialStatePropertyAll(
                  EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
                ),
              ),
              child: const Text(
                'Follow',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const Gap(10),
            ElevatedButton(
              onPressed: () {},
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  Colors.white,
                ),
                padding: MaterialStatePropertyAll(
                  EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
                ),
              ),
              child: const Text(
                'Message',
              ),
            ),
          ],
        ),
        const Gap(20),
        Expanded(
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => const PostWidget(),
            separatorBuilder: (context, index) => const Gap(20),
            itemCount: 5,
          ),
        ),
      ],
    );
  }
}
