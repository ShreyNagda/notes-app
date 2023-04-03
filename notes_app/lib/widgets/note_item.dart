import 'dart:math';

import 'package:flutter/material.dart';

import '../models/note.dart';

class NoteItem extends StatelessWidget {
  final Note currentNote;
  const NoteItem({super.key, required this.currentNote});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          width: 2,
        ),
      ),
      // color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currentNote.title!,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              currentNote.content!,
              maxLines: 4,
              style: const TextStyle(
                fontSize: 18,
              ),
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
