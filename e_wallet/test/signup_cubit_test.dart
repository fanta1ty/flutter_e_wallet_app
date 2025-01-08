import 'package:bloc_test/bloc_test.dart';
import 'package:e_wallet/constant/load_status.dart';
import 'package:e_wallet/models/request/signup_request.dart';
import 'package:e_wallet/models/response/signup_response.dart';
import 'package:e_wallet/repositories/api/api.dart';
import 'package:e_wallet/screen/signup/signup_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock API Class
class MockApi extends Mock implements Api {}

void main() {
  late SignupCubit signupCubit;
  late MockApi mockApi;

  setUp(() {
    mockApi = MockApi();
    signupCubit = SignupCubit(mockApi);
  });

  tearDown(() {
    signupCubit.close();
  });

  group('SignupCubit Tests', () {
    test('Initial state is SignupState.init()', () {
      expect(signupCubit.state, SignupState.init());
    });

    blocTest<SignupCubit, SignupState>(
      'Emits updated email when updateEmail() is called',
      build: () => signupCubit,
      act: (cubit) => cubit.updateEmail('test@example.com'),
      expect: () => [
        SignupState.init().copyWith(email: 'test@example.com'),
      ],
    );

    blocTest<SignupCubit, SignupState>(
      'Enables signup button when email, password, and confirm password are valid',
      build: () => signupCubit,
      act: (cubit) {
        cubit.updateEmail('valid@email.com');
        cubit.updatePassword('password123');
        cubit.updateConfirmPassword('password123');
      },
      expect: () => [
        SignupState.init().copyWith(email: 'valid@email.com'),
        SignupState.init().copyWith(
          email: 'valid@email.com',
          password: 'password123',
        ),
        SignupState.init().copyWith(
          email: 'valid@email.com',
          password: 'password123',
          confirmPassword: 'password123',
          isButtonEnabled: false,
        ),
        SignupState.init().copyWith(
          email: 'valid@email.com',
          password: 'password123',
          confirmPassword: 'password123',
          isButtonEnabled: true,
        ),
      ],
    );

    blocTest<SignupCubit, SignupState>(
      'Disables signup button when passwords do not match',
      build: () => signupCubit,
      act: (cubit) {
        cubit.updateEmail('valid@email.com');
        cubit.updatePassword('password123');
        cubit.updateConfirmPassword('wrongpassword');
      },
      expect: () => [
        SignupState.init().copyWith(email: 'valid@email.com'),
        SignupState.init().copyWith(
          email: 'valid@email.com',
          password: 'password123',
        ),
        SignupState.init().copyWith(
          email: 'valid@email.com',
          password: 'password123',
          confirmPassword: 'wrongpassword',
          isButtonEnabled: false,
        ),
      ],
    );

    blocTest<SignupCubit, SignupState>(
      'Emits [Loading, Done] on successful signup',
      build: () {
        when(() => mockApi.signup(SignUpRequest(
              email: 'test@example.com',
              password: 'password123',
              confirmPassword: 'password123',
            ))).thenAnswer((_) async {
          return SignUpResponse(success: true, errorMessage: '');
        });
        return signupCubit;
      },
      act: (cubit) {
        cubit.updateEmail('test@example.com');
        cubit.updatePassword('password123');
        cubit.updateConfirmPassword('password123');
        return cubit.signup();
      },
      expect: () => [
        SignupState.init().copyWith(
          email: 'test@example.com',
        ),
        SignupState.init().copyWith(
          email: 'test@example.com',
          password: 'password123',
        ),
        SignupState.init().copyWith(
          email: 'test@example.com',
          password: 'password123',
          confirmPassword: 'password123',
        ),
        SignupState.init().copyWith(
          email: 'test@example.com',
          password: 'password123',
          confirmPassword: 'password123',
          isButtonEnabled: true,
        ),
        SignupState.init().copyWith(
          email: 'test@example.com',
          password: 'password123',
          confirmPassword: 'password123',
          isButtonEnabled: true,
          loadStatus: LoadStatus.Loading,
        ),
        SignupState.init().copyWith(
          email: 'test@example.com',
          password: 'password123',
          confirmPassword: 'password123',
          loadStatus: LoadStatus.Done,
          isButtonEnabled: true,
          response: SignUpResponse(success: true, errorMessage: ''),
        ),
      ],
    );

    blocTest<SignupCubit, SignupState>(
      'Emits [Loading, Error] on failed signup',
      build: () {
        when(() => mockApi.signup(SignUpRequest(
              email: 'test@example.com',
              password: 'password123',
              confirmPassword: 'password123',
            ))).thenAnswer((_) async {
          return SignUpResponse(success: false, errorMessage: '');
        });
        return signupCubit;
      },
      act: (cubit) {
        cubit.updateEmail('test@example.com');
        cubit.updatePassword('password123');
        cubit.updateConfirmPassword('password123');
        return cubit.signup();
      },
      expect: () => [
        SignupState.init().copyWith(
          email: 'test@example.com',
        ),
        SignupState.init().copyWith(
          email: 'test@example.com',
          password: 'password123',
        ),
        SignupState.init().copyWith(
          email: 'test@example.com',
          password: 'password123',
          confirmPassword: 'password123',
        ),
        SignupState.init().copyWith(
          email: 'test@example.com',
          password: 'password123',
          confirmPassword: 'password123',
          isButtonEnabled: true,
        ),
        SignupState.init().copyWith(
          email: 'test@example.com',
          password: 'password123',
          confirmPassword: 'password123',
          isButtonEnabled: true,
          loadStatus: LoadStatus.Loading,
        ),
        SignupState.init().copyWith(
          email: 'test@example.com',
          password: 'password123',
          confirmPassword: 'password123',
          loadStatus: LoadStatus.Error,
          isButtonEnabled: true,
          response: SignUpResponse(success: false, errorMessage: ''),
        ),
      ],
    );
  });
}
