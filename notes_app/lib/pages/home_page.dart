import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/pages/add_note_page.dart';
import 'package:notes_app/pages/settings_page.dart';
import 'package:notes_app/providers/notes_provider.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../widgets/note_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = '';
  @override
  Widget build(BuildContext context) {
    NoteProvider noteProvider = Provider.of<NoteProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes App',),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (BuildContext context) => const SettingsPage(),
                  ),
                );
              },
              icon: const Icon(Icons.more_vert))
        ],
      ),
      body: !noteProvider.isLoading
          ? SafeArea(
              child: noteProvider.notes.isEmpty
                  ? const Center(
                      child: Text(
                        'Nothing to show :(',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    )
                  : ListView(
                      padding: const EdgeInsets.all(10),
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.search)),
                          onChanged: (value) {
                            setState(() {
                              searchQuery = value;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        noteProvider.getFilteredNotes(searchQuery).isNotEmpty
                            ? GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: noteProvider
                                    .getFilteredNotes(searchQuery)
                                    .length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                                itemBuilder: (context, index) {
                                  Note currentNote = noteProvider
                                      .getFilteredNotes(searchQuery)[index];
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            fullscreenDialog: true,
                                            builder: (context) => AddNotePage(
                                              isUpdate: true,
                                              note: currentNote,
                                            ),
                                          ),
                                        );
                                      },
                                      onLongPress: () {
                                        noteProvider.deleteNote(currentNote);
                                      },
                                      child: NoteItem(
                                        currentNote: currentNote,
                                      ));
                                },
                              )
                            : const Center(
                                child: Text(
                                'Nothing to Show :(',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ))
                      ],
                    ))
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (context) => const AddNotePage(
                isUpdate: false,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
