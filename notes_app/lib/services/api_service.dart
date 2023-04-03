import 'dart:convert';

import '../models/note.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String baseUrl = 'https://notes-app-15we.onrender.com/notes';

  static Future<void> addNote(Note note) async {
    Uri requestedUri = Uri.parse('$baseUrl/add');
    var response = await http.post(requestedUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    print(decoded.toString());
  }

  static Future<void> deleteNote(Note note) async {
    Uri requestedUri = Uri.parse('$baseUrl/delete');
    var response = await http.post(requestedUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    print(decoded.toString());
    // print(response.body{'message'}.toString())
  }

  static Future<List<Note>> fetchNotes(String userid) async {
    Uri requestedUri = Uri.parse('$baseUrl/list');
    var response = await http.post(requestedUri, body: {"userid": userid});
    print(response.body.toString());
    var decoded = jsonDecode(response.body);
    print(decoded.toString());
    List<Note> notes = [];
    for (var noteMap in decoded) {
      Note newNote = Note.fromMap(noteMap);
      notes.add(newNote);
    }

    return notes;
    // return [];
  }
}
