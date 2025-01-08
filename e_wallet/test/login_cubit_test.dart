import 'package:bloc_test/bloc_test.dart';
import 'package:e_wallet/constant/load_status.dart';
import 'package:e_wallet/models/request/login_request.dart';
import 'package:e_wallet/models/response/login_response.dart';
import 'package:e_wallet/repositories/api/api.dart';
import 'package:e_wallet/screen/login/login_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mocking Api Class
class MockApi extends Mock implements Api {}

void main() {
  late LoginCubit loginCubit;
  late MockApi mockApi;

  setUp(() {
    mockApi = MockApi();
    loginCubit = LoginCubit(mockApi);
  });

  tearDown(() {
    loginCubit.close();
  });

  group('LoginCubit', () {
    test('Initial state should be LoginState.init()', () {
      expect(
        loginCubit.state,
        equals(LoginState.init()),
      );
    });

    blocTest<LoginCubit, LoginState>(
      'Emits updated email when updateEmail is called',
      build: () => loginCubit,
      act: (cubit) => cubit.updateEmail('test@example.com'),
      expect: () => [
        LoginState.init().copyWith(email: 'test@example.com'),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'Emits updated password when updatePassword is called',
      build: () => loginCubit,
      act: (cubit) => cubit.updatePassword('password123'),
      expect: () => [
        LoginState.init().copyWith(password: 'password123'),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'Enables login button when email and password are valid',
      build: () => loginCubit,
      act: (cubit) {
        cubit.updateEmail('thnu@email.com');
        cubit.updatePassword('abcd1234');
      },
      expect: () => [
        LoginState.init().copyWith(email: 'thnu@email.com'),
        LoginState.init().copyWith(
          email: 'thnu@email.com',
          password: 'abcd1234',
        ),
        LoginState.init().copyWith(
          email: 'thnu@email.com',
          password: 'abcd1234',
          isButtonEnabled: true,
        ),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'Disables login button when email is invalid',
      build: () => loginCubit,
      act: (cubit) {
        cubit.updateEmail('invalidemail');
        cubit.updatePassword('password');
      },
      expect: () => [
        LoginState.init().copyWith(email: 'invalidemail'),
        LoginState.init().copyWith(
          email: 'invalidemail',
          password: 'password',
          isButtonEnabled: false,
        ),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'Emits [Loading, Done] on successful login',
      build: () {
        when(
          () => mockApi.login(
            LoginRequest(
              email: 'test@example.com',
              password: 'password123',
            ),
          ),
        ).thenAnswer(
          (_) async => LoginResponse(success: true, errorMessage: ''),
        );

        return loginCubit;
      },
      act: (cubit) {
        cubit.updateEmail('test@example.com');
        cubit.updatePassword('password123');
        return cubit.login();
      },
      expect: () => [
        LoginState.init().copyWith(
          email: 'test@example.com',
        ),
        LoginState.init().copyWith(
          email: 'test@example.com',
          password: 'password123',
          isButtonEnabled: false,
        ),
        LoginState.init().copyWith(
          email: 'test@example.com',
          password: 'password123',
          isButtonEnabled: true,
        ),
        LoginState.init().copyWith(
          email: 'test@example.com',
          password: 'password123',
          isButtonEnabled: true,
          loadStatus: LoadStatus.Loading,
        ),
        LoginState.init().copyWith(
          email: 'test@example.com',
          password: 'password123',
          loadStatus: LoadStatus.Done,
          response: LoginResponse(success: true, errorMessage: ''),
          isButtonEnabled: true,
        ),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'Emits [Loading, Error] on failed login',
      build: () {
        when(
          () => mockApi.login(
            LoginRequest(email: 'wrong@example.com', password: 'wrongpassword'),
          ),
        ).thenAnswer(
          (_) async => LoginResponse(
            success: false,
            errorMessage: '',
          ),
        );

        return loginCubit;
      },
      act: (cubit) {
        cubit.updateEmail('wrong@example.com');
        cubit.updatePassword('wrongpassword');
        return cubit.login();
      },
      expect: () => [
        LoginState.init().copyWith(
          email: 'wrong@example.com',
        ),
        LoginState.init().copyWith(
          email: 'wrong@example.com',
          password: 'wrongpassword',
        ),
        LoginState.init().copyWith(
          email: 'wrong@example.com',
          password: 'wrongpassword',
          isButtonEnabled: true,
        ),
        LoginState.init().copyWith(
          email: 'wrong@example.com',
          password: 'wrongpassword',
          isButtonEnabled: true,
          loadStatus: LoadStatus.Loading,
        ),
        LoginState.init().copyWith(
          email: 'wrong@example.com',
          password: 'wrongpassword',
          isButtonEnabled: true,
          loadStatus: LoadStatus.Error,
          response: LoginResponse(success: false, errorMessage: ''),
        ),
      ],
    );
  });
}
