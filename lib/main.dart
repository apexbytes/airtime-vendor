import 'package:antelope/features/auth/presentation/components/loading.dart';
import 'package:antelope/features/auth/presentation/cubits/auth_states.dart';
import 'package:antelope/features/auth/presentation/pages/auth_page.dart';
import 'package:antelope/firebase_options.dart';
// theme.dart is already imported via theme_provider.dart
import 'package:antelope/themes/theme_provider.dart'; // Make sure this is imported
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart'; // Make sure this is imported

import 'features/auth/data/firebase_auth_repo.dart';
import 'features/auth/presentation/cubits/auth_cubit.dart';
import 'features/home/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    // Wrap your app with ChangeNotifierProvider
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final firebaseAuthRepo = FirebaseAuthRepo();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          // Auth cubit
          BlocProvider<AuthCubit>(
              create: (context) =>
              AuthCubit(authRepo: firebaseAuthRepo)..checkAuth()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Provider.of<ThemeProvider>(context).themeData,
          home: BlocConsumer<AuthCubit, AuthState>(
              builder: (context, state) {
                // unauthenticated
                if (state is Unauthenticated) {
                  return const AuthPage();
                }

                // authenticated
                if (state is Authenticated) {
                  return const HomePage();
                }

                // loading ...
                else {
                  return const LoadingScreen();
                }
              }, // listen for state changes
              listener: (context, state) {
                if (state is AuthError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                }
              }),
        ));
  }
}
