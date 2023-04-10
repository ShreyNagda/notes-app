// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes_app/pages/home_page.dart';

import '../main.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/notes_logo.png',
                        scale: 15,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'N O T E S  A P P',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return const Dialog(
                                  elevation: 0,
                                  backgroundColor: Colors.transparent,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              });
                          await signin();
                          Navigator.pop(context);
                          Navigator.pushAndRemoveUntil(
                              context,
                              CupertinoDialogRoute(
                                builder: (_) => const HomePage(),
                                context: context,
                              ),
                              (route) => false);
                        },
                        child: const Text('Continue with google')),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signin() async {
    GoogleSignIn signin = GoogleSignIn();
    GoogleSignInAccount? account = await signin.signIn();
    try {
      if (account != null) {
        GoogleSignInAuthentication authentication =
            await account.authentication;
        AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken,
        );
        UserCredential userCredential =
            await auth.signInWithCredential(authCredential);
        if (userCredential.user != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Successfully signed in as: ${userCredential.user!.email}',
              ),
            ),
          );
        }
      }
    } on FirebaseAuthException {
      
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(
      //       'Error signing in! code: ${error.code}',
      //     ),
      //   ),
      // );
    }

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'An uncaught error occured! Try again later',
      ),
    ));
  }
}
