// presentation/signup/components/sign_up_form.dart
import 'package:example/presentation/signup/bloc/signup_cubit.dart';
import 'package:example/utils/constants/app_text_constants.dart';
import 'package:flutter/material.dart';

class SignUpFormComponent extends StatelessWidget {
  final SignupCubit signUpCubit;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _profilePictureUrlController =
      TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  SignUpFormComponent({super.key, required this.signUpCubit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: AppTextConstants.usernameLabel,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          TextField(
            controller: _fullNameController,
            decoration: const InputDecoration(
              labelText: AppTextConstants.fullnameLabel,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          TextField(
            controller: _profilePictureUrlController,
            decoration: const InputDecoration(
              labelText: AppTextConstants.profilePictureUrlLabel,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          TextField(
            controller: _occupationController,
            decoration: const InputDecoration(
              labelText: AppTextConstants.occupationLabel,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          TextField(
            controller: _genderController,
            decoration: const InputDecoration(
              labelText: AppTextConstants.genderLabel,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              signUpCubit.signupPerformed(
                username: _usernameController.text,
                fullName: _fullNameController.text,
                profilePictureUrl: _profilePictureUrlController.text,
                occupation: _occupationController.text,
                gender: _genderController.text,
              );
            },
            child: const Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}
