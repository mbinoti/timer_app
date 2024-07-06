import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_login/login_cubit.dart';
import 'package:flutter_login/login_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginCubit', () {
    late LoginCubit loginCubit;

    setUp(() {
      loginCubit = LoginCubit();
    });

    tearDown(() {
      loginCubit.close();
    });

    test('initial state is LoginState.initial()', () {
      expect(loginCubit.state, LoginState.initial());
    });

    blocTest<LoginCubit, LoginState>(
      'emits [state with email updated] when emailChanged is called',
      build: () => loginCubit,
      act: (cubit) => cubit.emailChanged('test@example.com'),
      expect: () => [LoginState.initial().copyWith(email: 'test@example.com')],
    );

    blocTest<LoginCubit, LoginState>(
      'emits [state with password updated] when passwordChanged is called',
      build: () => loginCubit,
      act: (cubit) => cubit.passwordChanged('password'),
      expect: () => [LoginState.initial().copyWith(password: 'password')],
    );

    blocTest<LoginCubit, LoginState>(
      'emits [state with isSubmitting true, isSuccess true] when login is successful',
      build: () => loginCubit,
      act: (cubit) => cubit.login(),
      expect: () => [
        LoginState.initial().copyWith(isSubmitting: true),
        LoginState.initial().copyWith(isSubmitting: false, isSuccess: true),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits [state with isSubmitting true, isFailure true] when login fails',
      build: () => loginCubit,
      act: (cubit) async {
        // Forçar um erro de login
        cubit.emit(cubit.state.copyWith(email: 'wrong@example.com'));
        cubit.login();
      },
      expect: () => [
        LoginState.initial()
            .copyWith(email: 'wrong@example.com', isSubmitting: true),
        LoginState.initial().copyWith(
            email: 'wrong@example.com', isSubmitting: false, isFailure: true),
      ],
    );
  });
}
