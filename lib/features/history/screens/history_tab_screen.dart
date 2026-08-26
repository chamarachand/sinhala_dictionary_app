import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sinhala_dictionary_app/core/enums/dictionary_language.dart';
import 'package:sinhala_dictionary_app/features/history/cubit/history_cubit.dart';
import 'package:sinhala_dictionary_app/features/history/screens/history_screen.dart';

class HistoryTabScreen extends StatefulWidget {
  final Widget drawer;
  const HistoryTabScreen({super.key, required this.drawer});

  @override
  State<HistoryTabScreen> createState() => _HistoryTabScreenState();
}

class _HistoryTabScreenState extends State<HistoryTabScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HistoryCubit>().getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("History"),
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
            HistoryScreen(language: DictionaryLanguage.english),
            HistoryScreen(language: DictionaryLanguage.sinhala),
          ],
        ),
      ),
    );
  }
}
