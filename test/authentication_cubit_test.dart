import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_login/authentication_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthenticationCubit', () {
    late AuthenticationCubit authenticationCubit;

    setUp(() {
      authenticationCubit = AuthenticationCubit();
    });

    tearDown(() {
      authenticationCubit.close();
    });

    test('initial state is not authenticated', () {
      expect(authenticationCubit.state, AuthenticationState(false));
    });

    blocTest<AuthenticationCubit, AuthenticationState>(
      'emits [authenticated] when loggedIn is called',
      build: () => authenticationCubit,
      act: (cubit) => cubit.loggedIn(),
      expect: () => [AuthenticationState(true)],
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'emits [not authenticated] when loggedOut is called',
      build: () => authenticationCubit,
      act: (cubit) => cubit.loggedOut(),
      expect: () => [AuthenticationState(false)],
    );
  });
}
