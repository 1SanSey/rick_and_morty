import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morty/feature/presentation/bloc/person_list_cubit/person_list_state.dart';
import 'package:rick_and_morty/feature/presentation/widgets/person_card_widget.dart';
import '../../../common/loading_indicator.dart';

class PersonsList extends StatelessWidget {
  PersonsList({super.key});

  final scrollController = ScrollController();

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          //BlocProvider.of<PersonListCubit>(context).loadPerson();
          context.read<PersonListCubit>().loadPerson();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    return BlocBuilder<PersonListCubit, PersonState>(builder: (context, state) {
      bool isLoading = false;
      List<PersonEntity> persons = [];
      if (state is PersonLoading && state.isFirstFetch) {
        return loadingIndicator();
      } else if (state is PersonLoading) {
        persons = state.oldPersonsList;
        isLoading = true;
      } else if (state is PersonLoaded) {
        persons = state.personsList;
      } else if (state is PersonError) {
        return Center(
          child: Text(
            state.message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        );
      }
      return ListView.separated(
          controller: scrollController,
          itemBuilder: (context, index) {
            if (index < persons.length) {
              return PersonCard(person: persons[index]);
            } else {
              Timer(const Duration(microseconds: 30), () {
                scrollController
                    .jumpTo(scrollController.position.maxScrollExtent);
              });
              return loadingIndicator();
            }
          },
          separatorBuilder: (context, index) {
            return Divider(color: Colors.grey[400]);
          },
          itemCount: persons.length + (isLoading ? 1 : 0));
    });
  }
}
