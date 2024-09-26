// presentation/signup/components/sign_up_form.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stream_feed_unofficial/src/presentation/signup/bloc/signup_cubit.dart';

class SignUpFormComponent extends StatelessWidget {
  SignUpFormComponent({super.key, required this.signUpCubit});

  final SignupCubit signUpCubit;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _profilePictureUrlController =
      TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'Username'),
          ),
          TextField(
            controller: _fullNameController,
            decoration: const InputDecoration(labelText: 'Full Name'),
          ),
          TextField(
            controller: _profilePictureUrlController,
            decoration: const InputDecoration(labelText: 'Profile Picture URL'),
          ),
          TextField(
            controller: _occupationController,
            decoration: const InputDecoration(labelText: 'Occupation'),
          ),
          TextField(
            controller: _genderController,
            decoration: const InputDecoration(labelText: 'Gender'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              unawaited(
                signUpCubit.signupPerformed(
                  username: _usernameController.text,
                  fullName: _fullNameController.text,
                  profilePictureUrl: _profilePictureUrlController.text,
                  occupation: _occupationController.text,
                  gender: _genderController.text,
                ),
              );
            },
            child: const Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}
