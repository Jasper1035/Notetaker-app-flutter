import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notetaker/change_notifiers/new_note_controller.dart';
import 'package:notetaker/change_notifiers/notes_provider.dart';
import 'package:notetaker/core/dialogs.dart';
import 'package:notetaker/models/note.dart';
import 'package:notetaker/pages/new_or_edit_note_page.dart';
import 'package:notetaker/services/auth_service.dart';
import 'package:notetaker/widgets/no_notes.dart';
import 'package:notetaker/widgets/note_fab.dart';
import 'package:notetaker/widgets/note_grid.dart';
import 'package:notetaker/widgets/note_icon_button_outlined.dart';
import 'package:notetaker/widgets/note_list.dart';
import 'package:notetaker/widgets/search_field.dart';
import 'package:notetaker/widgets/view_options.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note Taker📗"),
        actions: [
          NoteIconButtonOutlined(
            icon: FontAwesomeIcons.rightFromBracket,
            onPressed: () async {
              final bool shouldLogout =
                  await showConfirmationDialog(
                    context: context,
                    title: 'Do you want to sign out from the app',
                  ) ??
                  false;

              if (shouldLogout) AuthService.logout();
            },
          ),
        ],
      ),
      floatingActionButton: NoteFab(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (context) => NewNoteController(),
                child: NewOrEditNotePage(isNewNote: true),
              ),
            ),
          );
        },
      ),
      body: Consumer<NotesProvider>(
        builder: (context, notesProvider, child) {
          final List<Note> notes = notesProvider.notes;
          return notes.isEmpty && notesProvider.searchTerm.isEmpty
              ? NoNotes()
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SearchField(),
                      if (notes.isNotEmpty) ...[
                        ViewOptions(),
                        Expanded(
                          child: notesProvider.isGrid
                              ? NotesGrid(notes: notes)
                              : NotesList(notes: notes),
                        ),
                      ] else
                        Expanded(
                          child: Center(
                            child: Text(
                              "No Notes found for your search query",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
