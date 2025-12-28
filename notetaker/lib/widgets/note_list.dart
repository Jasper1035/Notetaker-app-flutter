import 'package:flutter/material.dart';
import 'package:notetaker/widgets/note_card.dart';

class NotesList extends StatefulWidget {
  const NotesList({super.key});

  @override
  State<NotesList> createState() => NotesListState();
}

class NotesListState extends State<NotesList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 20,
      itemBuilder: (context, index) {
        return NotesCard(isInGrid: false);
      },
      separatorBuilder: (context, index) => SizedBox(height: 10),
      clipBehavior: Clip.none,
    );
  }
}
