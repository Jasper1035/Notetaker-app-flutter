import 'package:flutter/material.dart';
import 'package:notetaker/core/constants.dart';

class NoteIconButton extends StatelessWidget {
  const NoteIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      constraints: BoxConstraints(),
      style: IconButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      iconSize: size,
      color: gray700,
    );
  }
}
