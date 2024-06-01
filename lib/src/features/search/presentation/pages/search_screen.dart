import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/features/search/presentation/cubit/search_cubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        List<UserInfoEntity> users = SearchCubit.get(context).searchResultUsers;
        print(users.length);
        var outlineInputBorder = const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.all(Radius.circular(30)));
        return Scaffold(
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     SearchCubit.get(context).searchForUser(keyword: 'Ayman');
          //   },
          //   child: const Icon(Icons.add),
          // ),
          // appBar: AppBar(),
          body: state is SearchForUserLoadingState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14.0),
                            controller: searchController,
                            validator: (value) {
                              if (value!.isEmpty || value == '') {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              enabledBorder: outlineInputBorder,
                              border: outlineInputBorder,
                              focusedBorder: outlineInputBorder,
                              hintText: 'Search',
                              prefixIcon:
                                  const Icon(Icons.search, color: Colors.white),
                            ),
                            onFieldSubmitted: (value) {
                              if (formKey.currentState!.validate()) {
                                SearchCubit.get(context)
                                    .searchForUser(keyword: value);
                              }
                            },
                          ),
                          const Gap(20.0),
                          Expanded(
                            child: ListView.separated(
                              itemBuilder: (context, index) =>
                                  SearchResultWidget(user: users[index]),
                              separatorBuilder: (context, index) =>
                                  const Gap(15),
                              itemCount: users.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({
    super.key,
    required this.user,
  });
  final UserInfoEntity user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30.0,
          backgroundImage: NetworkImage(
            user.profileImageURL,
          ),
        ),
        const Gap(10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              user.userName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            Text(
              user.bio,
              style: const TextStyle(
                fontSize: 15.0,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.person_add_outlined,
                color: Colors.blue,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.info_outline_rounded,
                color: Colors.blue,
              ),
            ),
          ],
        )
      ],
    );
  }
}
