import 'package:antelope/features/auth/domain/entities/app_user.dart';
import 'package:antelope/features/auth/presentation/cubits/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:antelope/features/auth/domain/repos/auth_repo.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AppUser? _currentUser;

  AuthCubit({required this.authRepo}) : super(AuthInitial());

  AppUser? get currentUser => _currentUser;

  void checkAuth() async {
    emit(AuthLoading());

    final AppUser? user = await authRepo.getCurrentUser();

    if (user != null) {
      _currentUser = user;
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      final AppUser? user = await authRepo.loginWithEmailPassword(email, password);
      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(AuthError('Login failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      emit(AuthLoading());
      final AppUser? user = await authRepo.registerWithEmailPassword(
          name, email, password);
      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(AuthError('Registration failed'));
      }
    }
      catch (e) {
        emit(AuthError(e.toString()));
        emit(Unauthenticated());
      }

      }
  Future<void> logout() async {
    try {
      await authRepo.logout();
      _currentUser = null;
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<String> forgotPassword(String email) async {
    try {
      final message = await authRepo.sendPasswordResetEmail(email);
      return message;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> deleteAccount() async {
    try {
      emit(AuthLoading());
      await authRepo.deleteAccount();
      _currentUser = null;
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }

  }

}