import 'package:bloc/bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void login(String username, String password) async {
    emit(AuthLoading());
    try {
      // Simulate a network request
      await Future.delayed(const Duration(seconds: 2));
      // Allow any username and password to login successfully
      emit(const AuthAuthenticated('fcd0b520-222c-429c-86e4-58683784a724'));
    } catch (e) {
      emit(const AuthError('An error occurred'));
    }
  }

  void logout() {
    emit(AuthInitial());
  }
}
