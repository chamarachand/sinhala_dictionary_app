import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sinhala_dictionary_app/core/enums/dictionary_language.dart';
import 'package:sinhala_dictionary_app/features/favourites/cubit/favourites_cubit.dart';
import 'package:sinhala_dictionary_app/features/favourites/screens/favourites_screen.dart';

class FavouritesTabScreen extends StatefulWidget {
  final Widget drawer;
  const FavouritesTabScreen({super.key, required this.drawer});

  @override
  State<FavouritesTabScreen> createState() => _FavouritesTabScreenState();
}

class _FavouritesTabScreenState extends State<FavouritesTabScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavouritesCubit>().getFavourites();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Favourites"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "English"),
              Tab(text: "Sinhala"),
            ],
          ),
        ),
        drawer: widget.drawer,
        body: const TabBarView(
          children: [
            FavouritesScreen(language: DictionaryLanguage.english),
            FavouritesScreen(language: DictionaryLanguage.sinhala),
          ],
        ),
      ),
    );
  }
}
