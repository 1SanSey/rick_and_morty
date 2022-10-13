import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rick_and_morty/common/app_colors.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';

class PersonCard extends StatelessWidget {
  const PersonCard({required this.person, super.key});

  final PersonEntity person;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.cellBackground,
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: <Widget>[
          Container(
            width: 160,
            height: 160,
            child: Image.network(person.image),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 12,
                ),
                Text(
                  person.name,
                  style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: person.status == 'Alive'
                            ? Colors.green
                            : Colors.amber[900],
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: Text(
                      '${person.status} - ${person.species}',
                      style: const TextStyle(
                          color: Colors.white, overflow: TextOverflow.ellipsis),
                    ))
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'Last known location:',
                  style: TextStyle(
                    color: AppColors.greyColor,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  person.location.name,
                  style: const TextStyle(
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'Origin:',
                  style: TextStyle(
                    color: AppColors.greyColor,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  person.origin.name,
                  style: const TextStyle(
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 12,
          ),
        ],
      ),
    );
  }
}
