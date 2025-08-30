import 'package:antelope/features/auth/presentation/components/text_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 50,),

          Icon(
            Icons.person_2_outlined,
            size: 100,
            color: Theme.of(context).colorScheme.primary,
          ),

          const SizedBox(height: 25,),

          Text(
            currentUser!.email!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),

          const SizedBox(height: 100,),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              'M y  D e t a i l s',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
              ),

            ),
          ),

          MyTexBox(
              text: 'Dave',
              sectionName: 'Username',
              onPressed: () {}),

          MyTexBox(
              text: '',
              sectionName: 'Bio',
              onPressed: () {}),
        ],
      ),
    );
  }
}

