import 'package:flutter/material.dart';
import 'package:immunity_frontend/types/person.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class PersonCard extends StatelessWidget {
  final Person person;

  const PersonCard({
    required this.person,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: person.color,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: SizedBox(
        height: 100,
        child: Center(
            child: Icon(
          person.isIll ? Symbols.microbiology : Symbols.recommend,
          size: 70,
        )),
      ),
    );
  }
}
