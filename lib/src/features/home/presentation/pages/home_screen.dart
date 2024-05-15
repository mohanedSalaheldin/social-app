import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:social_app/src/features/home/presentation/widgets/post_widget.dart';

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
          Expanded(
            child: StreamBuilder(
                stream: BlocProvider.of<HomeCubit>(context).getPosts(),
                builder: (context, snapshot) {
                  print(snapshot.error);
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) => PostWidget(
                          post: snapshot.data![index], onDeletePost: () {}),
                    );
                  }
                  return CircularProgressIndicator();
                }),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => {},
        currentIndex: 3,
        selectedItemColor: HexColor('#7737ff'),
        type: BottomNavigationBarType.fixed,
        elevation: 0.0,
        // iconSize: 30.0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: '',
          ),
        ],
      ),
    );
  }
}
