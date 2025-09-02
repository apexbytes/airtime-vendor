import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:antelope/features/auth/presentation/components/my_button.dart';
import 'package:antelope/features/auth/presentation/components/my_textfield.dart';
import 'package:antelope/features/auth/presentation/cubits/auth_cubit.dart';


class RegisterPage extends StatefulWidget {
  final void Function()? togglePages;

  const RegisterPage({super.key, required this.togglePages});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();

  // Register button pressed
  void register() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    // Auth Cubit
    final authCubit = context.read<AuthCubit>();

    // Validate all fields
    if(email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty && name.isNotEmpty) {
      if(password == confirmPassword) {
        authCubit.register(name, email, password);
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill out all fields")));
    }
  }
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.asset(
                      'lib/assets/icons/icon.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                const SizedBox(height: 25,),

                Text("Create an account", style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                ),

                const SizedBox(height: 25,),
                // Name field
                MyTextfield(controller: nameController, hintText: "Name", obscureText: false),
                const SizedBox(height: 10,),
                // Email Text field
                MyTextfield(controller: emailController, hintText: "Email", obscureText: false, keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 10,),
                // Password Text field
                MyTextfield(controller: passwordController, hintText: "Password", obscureText: true),
                const SizedBox(height: 10,),
                // Confirm Password Text field
                MyTextfield(controller: confirmPasswordController, hintText: "Confirm Password", obscureText: true),

                const SizedBox(height: 25,),

                // Register button
                MyButton(
                    onTap: register,
                    text: "Signup"
                ),
                const SizedBox(height: 25,),

                // Don't have an account?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 4,),
                    GestureDetector(
                      onTap: widget.togglePages,
                      child: Text(
                        "Login here",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
