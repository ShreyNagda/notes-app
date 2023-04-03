import 'package:flutter/material.dart';
import 'package:notes_app/services/api_service.dart';

import '../main.dart';
import '../models/note.dart';

class NoteProvider extends ChangeNotifier {
  bool isLoading = true;
  List<Note> notes = [];

  NoteProvider() {
    fetchNotes();
  }

  void sortNotes() {
    notes.sort((a, b) => b.dateAdded!.compareTo(a.dateAdded!));
  }

  void addNote(Note note) {
    notes.add(note);
    sortNotes();
    notifyListeners();
    ApiService.addNote(note);
  }

  void updateNote(Note note) {
    int noteIndex =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[noteIndex] = note;
    sortNotes();
    notifyListeners();
    ApiService.addNote(note);
  }

  void deleteNote(Note note) {
    int noteIndex = notes.indexOf(
      notes.firstWhere((element) => element.id == note.id),
    );
    notes.removeAt(noteIndex);
    sortNotes();
    notifyListeners();
    ApiService.deleteNote(note);
  }

  void fetchNotes() async {
    notes = await ApiService.fetchNotes(auth.currentUser!.email!);
    isLoading = false;
    notifyListeners();
  }

  List<Note> getFilteredNotes(String searchQuery) {
    return notes
        .where((element) =>
            element.title!
                .toLowerCase()
                .contains(searchQuery.toLowerCase().toString()) ||
            element.content!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }
}
