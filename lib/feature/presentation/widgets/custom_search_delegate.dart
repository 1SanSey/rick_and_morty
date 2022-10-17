import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/common/loading_indicator.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_state.dart';
import 'package:rick_and_morty/feature/presentation/widgets/search_result.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate() : super(searchFieldLabel: 'Search for characters...');

  final _suggestions = ['Rick', 'Morty', 'Summer', 'Beth', 'Jerry'];
  final scrollController = ScrollController();
  int page = 1;
  bool isFirstBuildResults = true;

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          page++;
          print('Call setupScrollController, page $page');
          BlocProvider.of<PersonSearchBloc>(context)
              .add(SearchPersons(query, page));
        }
      }
    });
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back_outlined),
      tooltip: 'Back',
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    print(
        'Inside custom search delegate and search query is $query and page $page');
    setupScrollController(context);
    // if (isFirstBuildResults) {
    BlocProvider.of<PersonSearchBloc>(context).add(SearchPersons(query, page));
    // isFirstBuildResults = false;
    //}
    //print(isFirstBuildResults);
    return BlocBuilder<PersonSearchBloc, PersonSearchState>(
        builder: (context, state) {
      bool isLoading = false;
      final List<PersonEntity> person;
      if (state is PersonSearchLoading && state.isFirstFetch) {
        return loadingIndicator();
      } else if (state is PersonSearchLoading) {
        isLoading = true;
        person = state.oldSearchPersonList;
      } else if (state is PersonSearchLoaded) {
        person = state.persons;

        if (person.isEmpty) {
          return _showErrorText('No characters with that name were found');
        }
      } else if (state is PersonSearchError) {
        return Center(child: _showErrorText(state.message));
      } else {
        return const Center(
          child: Icon(Icons.now_wallpaper),
        );
      }
      return ListView.builder(
          controller: scrollController,
          itemBuilder: (context, index) {
            if (index < person.length) {
              PersonEntity result = person[index];
              print('call Builder');
              return SearchResult(personResult: result);
            } else {
              Timer(const Duration(microseconds: 30), () {
                scrollController
                    .jumpTo(scrollController.position.maxScrollExtent);
              });
              return loadingIndicator();
            }
          },
          itemCount:
              person.isNotEmpty ? person.length + (isLoading ? 1 : 0) : 0);
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return Container();
    }

    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index) => Text(
        _suggestions[index],
        style: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
      ),
      itemCount: _suggestions.length,
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 1,
        );
      },
    );
  }

  Widget _showErrorText(String errorMessage) {
    return Container(
      color: Colors.black,
      child: Text(
        errorMessage,
        style: const TextStyle(color: Colors.white, fontSize: 25),
      ),
    );
  }
}
