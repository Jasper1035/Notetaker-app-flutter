import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notetaker/change_notifiers/new_note_controller.dart';
import 'package:notetaker/core/constants.dart';
import 'package:notetaker/core/dialogs.dart';
import 'package:notetaker/widgets/note_back_button.dart';
import 'package:notetaker/widgets/note_icon_button_outlined.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:notetaker/widgets/note_metadata.dart';
import 'package:notetaker/widgets/note_tool_bar.dart';
import 'package:provider/provider.dart';

class NewOrEditNotePage extends StatefulWidget {
  const NewOrEditNotePage({super.key, required this.isNewNote});

  final bool isNewNote;

  @override
  State<NewOrEditNotePage> createState() => _NewOrEditNotePageState();
}

class _NewOrEditNotePageState extends State<NewOrEditNotePage> {
  late final NewNoteController newNoteController;
  late final TextEditingController titleController;
  late final QuillController quillController;

  late final FocusNode focusNode;

  @override
  void initState() {
    super.initState();

    newNoteController = context.read<NewNoteController>();

    titleController = TextEditingController(text: newNoteController.title);

    quillController = QuillController.basic()
      ..addListener(() {
        newNoteController.content = quillController.document;
      });

    focusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.isNewNote) {
        focusNode.requestFocus();
        newNoteController.readOnly = false;
      } else {
        newNoteController.readOnly = true;
        quillController.document = newNoteController.content;
      }
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
    quillController.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;

        if (!newNoteController.canSaveNote) {
          Navigator.pop(context);
          return;
        }

        final bool? shouldSave = await showConfirmationDialog(
          context: context,
          title: toString(),
        );
        if (shouldSave == null) return;

        if (!context.mounted) return;

        if (shouldSave) {
          newNoteController.saveNote(context);
        }
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: NoteBackButton(),
          title: Text(widget.isNewNote ? 'New Note' : 'Edit Note'),
          actions: [
            Selector<NewNoteController, bool>(
              selector: (context, newNoteController) =>
                  newNoteController.readOnly,
              builder: (context, readOnly, child) => NoteIconButtonOutlined(
                icon: readOnly
                    ? FontAwesomeIcons.pen
                    : FontAwesomeIcons.bookOpen,
                onPressed: () {
                  newNoteController.readOnly = !readOnly;
                  if (newNoteController.readOnly) {
                    FocusScope.of(context).unfocus();
                  } else {
                    focusNode.requestFocus();
                  }
                },
              ),
            ),
            Selector<NewNoteController, bool>(
              selector: (_, newNoteController) => newNoteController.canSaveNote,
              builder: (_, canSaveNote, _) => NoteIconButtonOutlined(
                icon: FontAwesomeIcons.check,
                onPressed: canSaveNote
                    ? () {
                        newNoteController.saveNote(context);
                        Navigator.pop(context);
                      }
                    : null,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Selector<NewNoteController, bool>(
                selector: (context, controller) => controller.readOnly,
                builder: (context, readOnly, child) => TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: "title here",
                    hintStyle: TextStyle(color: gray300),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  canRequestFocus: !readOnly,
                  onChanged: (newValue) {
                    newNoteController.title = newValue;
                  },
                ),
              ),
              NoteMetadata(note: newNoteController.note),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Divider(color: gray500, thickness: 2),
              ),

              Expanded(
                child: Selector<NewNoteController, bool>(
                  selector: (_, controller) => controller.readOnly,

                  builder: (_, readOnly, _) => Column(
                    children: [
                      Expanded(
                        child: QuillEditor.basic(
                          controller: quillController,
                          config: QuillEditorConfig(
                            placeholder: "Note here...",
                            expands: true,
                            checkBoxReadOnly: readOnly,
                          ),
                          focusNode: focusNode,
                        ),
                      ),
                      if (!readOnly)
                        NoteToolbar(quillController: quillController),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
