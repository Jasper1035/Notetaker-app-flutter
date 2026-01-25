import 'package:flutter/material.dart';
import 'package:notetaker/widgets/dialog_card.dart';
import 'package:notetaker/widgets/note_button.dart';
import 'package:notetaker/widgets/note_form_field.dart';

class NewTagDialog extends StatefulWidget {
  const NewTagDialog({super.key, this.tag});

  final String? tag;

  @override
  State<NewTagDialog> createState() => _NewTagDialogState();
}

class _NewTagDialogState extends State<NewTagDialog> {
  late final TextEditingController tagController;

  late final GlobalKey<FormFieldState> tagKey;

  @override
  void initState() {
    super.initState();

    tagController = TextEditingController(text: widget.tag);
    tagKey = GlobalKey();
  }

  @override
  void dispose() {
    tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DialogCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Add tag",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 24),
          NoteFormField(
            key: tagKey,
            controller: tagController,
            hintText: 'Add tag (< 16 characters)',
            validator: (value) {
              if (value!.trim().isEmpty) {
                return 'No tag added';
              } else if (value.trim().length > 16) {
                return 'Tags should not be more then 16 characters.';
              }
              return null;
            },
            onChanged: (value) {
              tagKey.currentState?.validate();
            },
            autofocus: true,
          ),
          SizedBox(height: 24),
          NoteButton(
            child: Text('Add'),
            onPressed: () {
              if (tagKey.currentState?.validate() ?? false) {
                Navigator.pop(context, tagController.text.trim());
              }
            },
          ),
        ],
      ),
    );
  }
}
