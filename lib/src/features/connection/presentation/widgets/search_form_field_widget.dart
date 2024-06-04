import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_app/src/config/routes/navigate_methods.dart';
import 'package:social_app/src/features/connection/presentation/cubit/search_cubit.dart';
import 'package:social_app/src/features/connection/presentation/pages/search_results_screen.dart';

class SearchFormField extends StatelessWidget {
  SearchFormField({
    super.key,
    required this.isEditable,
  });
  final bool isEditable;

  TextEditingController searchController = TextEditingController();

  var outlineInputBorder = const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
      ),
      borderRadius: BorderRadius.all(Radius.circular(30)));

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white, fontSize: 14.0),
      controller: searchController,
      validator: (value) {
        return null;
      },
      keyboardType: isEditable ? TextInputType.text : TextInputType.none,
      onTap: () {
        if (!isEditable) {
          navigateToScreen(context, const ConnectionSearchScreen());
        }
      },
      enabled: isEditable,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        enabledBorder: outlineInputBorder,
        border: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        hintText: 'Search',
        prefixIcon: const Icon(Iconsax.search_normal_1, color: Colors.white),
      ),
      onFieldSubmitted: (value) {
        if (searchController.text.trim().isNotEmpty) {
          ConnectionCubit.get(context).searchForUser(keyword: value);
        }
      },
    );
  }
}
