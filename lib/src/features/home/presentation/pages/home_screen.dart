import 'dart:io';

import 'package:dartz/dartz_unsafe.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/src/features/home/domain/entities/comment_entity.dart';
import 'package:social_app/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:social_app/src/features/home/presentation/cubit/home_state.dart';
import 'package:social_app/src/features/home/presentation/widgets/post_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              // File file = File(path);
              final ImagePicker picker = ImagePicker();
// Pick an image.
              final XFile? image = await picker
                  .pickImage(
                source: ImageSource.gallery,
                // imageQuality: 50,
              )
                  .then((value) async {
                print('*******************************************');
                print(value!.path);
                print('*******************************************');
                final extension = value.path.split('/').last;
                final task = FirebaseStorage.instance
                    .ref()
                    .child('tests/images/profiles/profile.$extension')
                    .putFile(File(value.path));
                final snapshot = await task.whenComplete(() => null);
                final url = await snapshot.ref.getDownloadURL();
                print(
                    '*********************(IMAGE UPLOADED)**********************');
                print(url);
                print(
                    '*********************(IMAGE UPLOADED)**********************');
                return null;
              });
            },
            child: const Icon(Icons.add),
          ),
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
                      return const CircularProgressIndicator();
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
      },
    );
  }
}
