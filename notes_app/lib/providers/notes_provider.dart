import 'package:flutter/material.dart';

import '../main.dart';
import '../models/note.dart';
import '../services/api_service.dart';

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
    NotesApiService.addNote(note);
  }

  void updateNote(Note note) {
    int noteIndex =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[noteIndex] = note;
    sortNotes();
    notifyListeners();
    NotesApiService.addNote(note);
  }

  void deleteNote(Note note) {
    int noteIndex = notes.indexOf(
      notes.firstWhere((element) => element.id == note.id),
    );
    notes.removeAt(noteIndex);
    sortNotes();
    notifyListeners();
    NotesApiService.deleteNote(note);
  }

  void fetchNotes() async {
    notes = await NotesApiService.fetchNotes(auth.currentUser!.email!);
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
