import 'package:flutter/material.dart';

import '../main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = auth.currentUser!.displayName!;
    emailController.text = auth.currentUser!.email!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          TextFormField(
            controller: nameController,
            style: const TextStyle(fontSize: 18),
            decoration: InputDecoration(
                hintText: 'Full Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: emailController,
            style: const TextStyle(fontSize: 18),
            decoration: InputDecoration(
                hintText: 'Full Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (nameController.text != "" &&
                    emailController.text != "" &&
                    emailController.text.endsWith("@gmail.com")) {
                  auth.currentUser!.updateDisplayName(nameController.text);
                  auth.currentUser!.updateEmail(emailController.text);
                  Navigator.pop(context);
                }
              },
              child: const Text('Save Changes'),
            ),
          )
        ]),
      ),
    );
  }
}
