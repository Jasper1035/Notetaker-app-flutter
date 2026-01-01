import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notetaker/core/constants.dart';

class NoteToolbar extends StatelessWidget {
  const NoteToolbar({super.key, required this.quillController});

  final QuillController quillController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: white,
        border: Border.all(
          color: primary,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: primary, offset: Offset(4, 4))],
      ),
      child: QuillSimpleToolbar(
        controller: quillController,
        config: QuillSimpleToolbarConfig(
          multiRowsDisplay: false,
          showFontFamily: false,
          showStrikeThrough: false,
          showInlineCode: false,
          showSubscript: false,
          showSuperscript: false,
          showSmallButton: false,
          showClearFormat: false,
          showAlignmentButtons: false,
          showDirection: false,
          showLineHeightButton: false,
          showHeaderStyle: false,
          showListNumbers: false,
          showListCheck: false,
          showCodeBlock: false,
          showQuote: false,
          showIndent: false,
          showLink: false,
          buttonOptions: QuillSimpleToolbarButtonOptions(
            undoHistory: QuillToolbarHistoryButtonOptions(
              iconData: FontAwesomeIcons.arrowRotateLeft,
              iconSize: 14,
            ),
            redoHistory: QuillToolbarHistoryButtonOptions(
              iconData: FontAwesomeIcons.arrowRotateRight,
              iconSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
