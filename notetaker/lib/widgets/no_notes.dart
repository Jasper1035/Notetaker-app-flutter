import 'package:flutter/material.dart';

class NoNotes extends StatelessWidget {
  const NoNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/emptybox.png",
            width: MediaQuery.sizeOf(context).width * 0.75,
          ),
          SizedBox(height: 30),
          Text(
            "You have no notes \nStart creting by pressing the + button below.",

            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: "Fredoka",
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
