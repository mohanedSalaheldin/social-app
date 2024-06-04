import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/features/connection/presentation/cubit/search_cubit.dart';
import 'package:social_app/src/features/connection/presentation/widgets/search_form_field_widget.dart';
import 'package:social_app/src/features/connection/presentation/widgets/user_listtile_widget.dart';

class ConnectionSearchScreen extends StatefulWidget {
  const ConnectionSearchScreen({super.key});

  @override
  State<ConnectionSearchScreen> createState() => _ConnectionSearchScreenState();
}

class _ConnectionSearchScreenState extends State<ConnectionSearchScreen> {
  TextEditingController searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ConnectionCubit.get(context).getAllUsers();

    return BlocBuilder<ConnectionCubit, ConnectionsState>(
      builder: (context, state) {
        List<UserInfoEntity> users =
            ConnectionCubit.get(context).searchResultUsers;
        print(users.length);

        return Scaffold(
          body: Builder(builder: (context) {
            if (state is ConnectionSearchForUserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const BackButton(
                          color: Colors.white,
                        ),
                        Expanded(
                          child: SearchFormField(
                            isEditable: true,
                          ),
                        ),
                      ],
                    ),
                    const Gap(20.0),
                    Expanded(
                        child: ListView.separated(
                      itemBuilder: (context, index) => UserListTileWidget(
                        otherUser: users[index],
                        isSearched: true,
                        currentUser: users[index],
                      ),
                      separatorBuilder: (context, index) => const Gap(5),
                      itemCount: users.length,
                    )),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
