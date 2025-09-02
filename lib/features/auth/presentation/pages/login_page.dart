import 'package:antelope/features/auth/presentation/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:antelope/features/auth/presentation/components/my_button.dart';
import 'package:antelope/features/auth/presentation/cubits/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  final void Function()? togglePages;
  const LoginPage({super.key, required this.togglePages});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late final authCubit = context.read<AuthCubit>();

  void login() {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    if(email.isNotEmpty && password.isNotEmpty) {
      authCubit.login(email, password);
    }

    else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill out all fields")));
    }

  }

  void openForgotPasswordBox() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Forgot Password"),
          content: MyTextfield(
              controller: emailController,
              hintText: "Enter email",
              obscureText: false
          ),
          actions: [
            // Cancel button
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel")
            ),

            // Reset button
            TextButton(
                onPressed: () async {
                  String message =
                      await authCubit.forgotPassword(emailController.text);

                  if(message == "Password reset email sent, check inbox") {
                    Navigator.pop(context);
                    emailController.clear();
                  }

                  ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(message)));
                },
                child: const Text("Reset")
            ),
          ]
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
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

              Text("A p e x b y t e s", style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              ),

              const SizedBox(height: 25,),

              // Email Text field
              MyTextfield(controller: emailController, hintText: "Email", obscureText: false, keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 10,),
              // Password Text field
              MyTextfield(controller: passwordController, hintText: "Password", obscureText: true),
              const SizedBox(height: 10,),

              // Forgot Password?
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => openForgotPasswordBox(),
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                      ),
                  ),
                ],
              ),
              const SizedBox(height: 25,),

              // Login button
              MyButton(
                  onTap: login,
                  text: "Login"),
              const SizedBox(height: 25,),

              // Don't have an account?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 4,),
                  GestureDetector(
                    onTap: widget.togglePages,
                    child: Text(
                      "Register now",
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
    );
  }
}
