import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kat_chat/models/user_model.dart';
import 'package:kat_chat/view/authentication/registration_view.dart';
import 'package:kat_chat/view/home/home_view.dart';

import 'sign_in_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  String? userName;
  String? email;
  String? password;
  final users = FirebaseFirestore.instance.collection('users');
  Future<void> kattaluu() async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );

      createUser(userCredential);
    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (error.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      log('$e');
      throw (e);
    }
  }

  Future<void> createUser(UserCredential userCredential) async {
    final userModel = UserModel(
      id: userCredential.user!.uid,
      userName: userName!,
      email: email!,
    );
    users.doc(userCredential.user!.uid).set(userModel.toMap()).then((_) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeView(userModelData: userModel),
        ),
      );
      log('User koshuldu');
    }).catchError((error) => log("Failed to add user: $error"));
  }

// CRUD
// Create - Writing data, Adding documents
// Read - One Time read, Realtime changes
// Update -
// Delete
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegistrationView(),
                      ));
                },
                child: const Text(
                  'Негизги Бет',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Жаныдан катталуу',
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      onChanged: (String adamdynJazgany) {
                        userName = adamdynJazgany;
                        log(userName!);
                      },
                      decoration: InputDecoration(
                        labelText: "Атыны жаз",
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      onChanged: (String adamdynJazgany) {
                        email = adamdynJazgany;
                        log(email!);
                      },
                      decoration: InputDecoration(
                        labelText: "Почтаны жаз",
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      onChanged: (String adamdynJazgany) {
                        password = adamdynJazgany;
                        log(password!);
                      },
                      decoration: InputDecoration(
                        labelText: "Пароль",
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Эгер почтаныз бар болсо',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignInView(),
                              ));
                        },
                        child: Text(
                          'Кируу',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        kattaluu();
                      },
                      child: Text(
                        'Катталуу',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
