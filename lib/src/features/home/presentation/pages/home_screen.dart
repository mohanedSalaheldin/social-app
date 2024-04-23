import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: const Text('Home'),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt_outlined),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.email_outlined),
            ),
          ]),
      body: Column(
        children: [
          Container(
            color: const Color.fromARGB(255, 237, 236, 236),
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 30.0,
                      backgroundImage:
                          NetworkImage('https://i.pravatar.cc/300'),
                    ),
                    const Gap(10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'username',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        Text(
                          'time',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_vert_outlined),
                    ),
                  ],
                ),
                const Gap(10.0),
                const Text(
                  'lorem ipsum dolor sit amet lorem ipsum dolor sit ametlorem ipsum dolor sit amet',
                ),
                const Gap(10.0),
                Image.network(
                  'https://i.pravatar.cc/700',
                  fit: BoxFit.cover,
                  width: double.infinity,
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
                        const Gap(10.0),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.chat_bubble_outline),
                        ),
                        const Gap(10.0),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.send_outlined),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.bookmark_outline),
                    ),
                  ],
                ),
                const Gap(10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              border: Border.all(
                                width: 3.0,
                                color: Colors.white,
                              ),
                            ),
                            child: const CircleAvatar(
                              radius: 15.0,
                              backgroundImage:
                                  NetworkImage('https://i.pravatar.cc/300'),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.only(start: 15.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              border: Border.all(
                                width: 3.0,
                                color: Colors.white,
                              ),
                            ),
                            child: const CircleAvatar(
                              radius: 15.0,
                              backgroundImage:
                                  NetworkImage('https://i.pravatar.cc/500'),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.only(start: 30.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              border: Border.all(
                                width: 3.0,
                                color: Colors.white,
                              ),
                            ),
                            child: const CircleAvatar(
                              radius: 15.0,
                              backgroundImage:
                                  NetworkImage('https://i.pravatar.cc/400'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(10.0),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: 'liked by ',
                          ),
                          TextSpan(
                            text: 'Joe Hoe',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: ' and 1.5k',
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => {},
        currentIndex: 3,
        selectedItemColor: HexColor('#7737ff'),
        type: BottomNavigationBarType.fixed,
        elevation: 0.0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }
}
