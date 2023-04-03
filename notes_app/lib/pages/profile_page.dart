import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
          ),
          SizedBox(
            height: 2.h,
          ),
          TextFormField(
            controller: emailController,
            readOnly: true,
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
          ),
        ]),
      ),
    );
  }
}
