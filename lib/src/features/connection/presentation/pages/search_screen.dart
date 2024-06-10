import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_app/src/config/routes/navigate_methods.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/utls/constants/constants.dart';
import 'package:social_app/src/features/connection/presentation/cubit/search_cubit.dart';
import 'package:social_app/src/features/connection/presentation/pages/search_results_screen.dart';
import 'package:social_app/src/features/connection/presentation/widgets/search_form_field_widget.dart';
import 'package:social_app/src/features/connection/presentation/widgets/user_listtile_widget.dart';

class ConnectionScreen extends StatefulWidget {
  const ConnectionScreen({super.key});

  @override
  State<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  @override
  Widget build(BuildContext context) {
    // ConnectionCubit.get(context).getAllUsers();

    return BlocBuilder<ConnectionCubit, ConnectionsState>(
      builder: (context, state) {
        ConnectionCubit.get(context).getAllUsers();
        Stream<List<UserInfoEntity>> users =
            ConnectionCubit.get(context).allUsers;
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(30.0),
                    onTap: () {
                      navigateToScreen(context, const ConnectionSearchScreen());
                    },
                    child: SearchFormField(
                      isEditable: false,
                    ),
                  ),
                  const Gap(20.0),
                  Expanded(
                    child: StreamBuilder<List<UserInfoEntity>>(
                        stream: users,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.waiting ||
                              snapshot.data!.isEmpty) {
                            return Scaffold(
                              body: SafeArea(
                                  child: Center(
                                      child: CircularProgressIndicator(
                                          color: mainColor))),
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.data!.isEmpty) {
                            return const Center(child: Text('No posts yet'));
                          }
                          return ListView.separated(
                            itemBuilder: (context, index) => UserListTileWidget(
                              isSearched: false,
                              otherUser: snapshot.data![index],
                              currentUser: snapshot.data!.where((element) {
                                return element.userId ==
                                    FirebaseAuth.instance.currentUser!.uid;
                              }).first,
                            ),
                            separatorBuilder: (context, index) => const Gap(0),
                            itemCount: snapshot.data!.length,
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
