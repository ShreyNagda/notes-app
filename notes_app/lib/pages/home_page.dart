import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/pages/add_note_page.dart';
// import 'package:notes_app/pages/new_note.dart';
import 'package:notes_app/pages/settings_page.dart';
import 'package:notes_app/pages/signin_page.dart';
import 'package:notes_app/providers/notes_provider.dart';
import 'package:provider/provider.dart';

import '../main.dart';
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
    // print(DateTime.now().millisecondsSinceEpoch);
    NoteProvider noteProvider = Provider.of<NoteProvider>(context);
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration:
                  BoxDecoration(color: DynamicColorTheme.of(context).color),
              currentAccountPicture: CircleAvatar(
                backgroundColor: DynamicColorTheme.of(context).isDark
                    ? Colors.white
                    : const Color.fromARGB(
                        115,
                        82,
                        82,
                        82,
                      ),
                child: Icon(Icons.person,
                    color: !DynamicColorTheme.of(context).isDark
                        ? Colors.white
                        : Colors.black),
              ),
              accountName: Text(auth.currentUser!.displayName!),
              accountEmail: Text(auth.currentUser!.email!),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
              },
              title: Text(
                'Home',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              trailing: const Icon(Icons.home),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (_) => const SettingsPage()),
                );
              },
              title: Text(
                'Settings',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              trailing: const Icon(Icons.settings),
            ),
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: const Text('Do you want to logout?', style: TextStyle(fontSize: 18, letterSpacing: 1),),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel')),
                          ElevatedButton(
                              onPressed: () async {
                                await auth.signOut();
                                // ignore: use_build_context_synchronously
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const SigninPage()),
                                    (route) => false);
                              },
                              child: const Text("Logout"))
                        ],
                      );
                    });
              },
              title: Text(
                'Logout',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              trailing: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Notes App',
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              DynamicColorTheme.of(context).setIsDark(
                isDark: !DynamicColorTheme.of(context).isDark,
                shouldSave: true,
              );
              setState(() {});
            },
            icon: Icon(
              DynamicColorTheme.of(context).isDark
                  ? CupertinoIcons.light_max
                  : CupertinoIcons.moon,
            ),
          ),
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
                          style: const TextStyle(fontSize: 15),
                          cursorColor: DynamicColorTheme.of(context).color,
                          decoration: InputDecoration(
                            suffixIconColor:
                                DynamicColorTheme.of(context).color,
                            // border: UnderlineInputBorder(
                            //   borderSide: BorderSide(
                            //     color: DynamicColorTheme.of(context).color,
                            //   ),
                            // ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: DynamicColorTheme.of(context).color,
                                width: 2,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: DynamicColorTheme.of(context).color,
                                width: 2,
                              ),
                            ),
                            suffixIcon: const Icon(Icons.search),
                          ),
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
                builder: (context) => const AddNotePage(isUpdate: false)),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
