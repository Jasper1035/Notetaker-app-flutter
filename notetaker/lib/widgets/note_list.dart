import 'package:flutter/material.dart';
import 'package:notetaker/models/note.dart';
import 'package:notetaker/widgets/note_card.dart';

class NotesList extends StatelessWidget {
  const NotesList({super.key, required this.notes});
  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return NotesCard(isInGrid: false, note: notes[index]);
      },
      separatorBuilder: (context, index) => SizedBox(height: 10),
      clipBehavior: Clip.none,
    );
  }
}
