import 'package:flaury_mobile/app/services/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../services/secure_storage.dart';
import '../repositories/auth_repository.dart';

enum AuthStatus {
  inital,
  loading,
  error,
  success,
}

class AuthState {
  final AuthStatus status;
  final String message;

  AuthState({
    required this.status,
    this.message = '',
  });

  factory AuthState.initial() {
    return AuthState(
      status: AuthStatus.inital,
      message: '',
    );
  }

  factory AuthState.loading() {
    return AuthState(
      status: AuthStatus.loading,
      message: '',
    );
  }
  factory AuthState.error(String message) {
    return AuthState(
      status: AuthStatus.error,
      message: message,
    );
  }
  factory AuthState.success(String message) {
    return AuthState(
      status: AuthStatus.success,
      message: message,
    );
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(
      ref.read(
        authrepositoryProvider,
      ),
      ref.read(authTokenManagerProvider));
});

// this contoller manages the authentication state of the app
class AuthController extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final AuthTokenManager _authTokenManager;
  AuthController(this.authRepository, this._authTokenManager)
      : super(AuthState.initial());

  Future<void> signUp(
      {required String email,
      required String password,
      required String userName,
      required String gender,
      required String name,
      required String phoneNumber}) async {
    state = AuthState.loading();
    try {
      final response = await authRepository.signUp(
          password: password,
          name: name,
          userName: userName,
          phonenumber: phoneNumber,
          gender: gender,
          email: email);
      // save tokens to secure storage
      // await _authTokenManager.saveAuthToken(response);
      // await _authTokenManager.saveRefreshAuthToken(response.refreshToken);
      state = AuthState.success(response.message ?? 'Sign up Succesful ');
    } on CustomException catch (e) {
      state = AuthState.error(e.message);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = AuthState.loading();
    try {
      final response =
          await authRepository.login(email: email, password: password);
      // save tokens to secure storage
      await _authTokenManager.saveAuthToken(response.accessToken);
      await _authTokenManager.saveRefreshAuthToken(response.refreshToken);
      state = AuthState.success(response.responseDescription);
    } catch (e) {
      state = AuthState.error(
          'An error occurred, your email or password is incorrect');
    }
  }

  // logout
  Future<void> logout() async {
    state = AuthState.loading();
    try {
      final response = await authRepository.logout();
      await _authTokenManager.deleteAuthToken();
      await _authTokenManager.deleteRefreshAuthToken();
      state = AuthState.success(response.responseDescription);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  // forgot password
  Future<void> forgotPassword(String email) async {
    state = AuthState.loading();
    try {
      final response = await authRepository.forgotPassword(email);
      state = AuthState.success(response.data);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  // verify email
  Future<void> verifyEmail(String email, String code) async {
    state = AuthState.loading();
    try {
      final response = await authRepository.verifyEmail(email, code);
      state = AuthState.success(response.data);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> resetPassword(
      {required String email,
      required String newPassword,
      required String verificationCode}) async {
    state = AuthState.loading();
    try {
      final response = await authRepository.resetPassword(
          email: email,
          newPassword: newPassword,
          verificationCode: verificationCode);
      state = AuthState.success(response.data);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> resendVerifcationCode(String email) async {
    state = AuthState.loading();
    try {
      final response = await authRepository.resendVerifcationCode(email);
      state = AuthState.success(response.data);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> refreshAccessToken() async {
    state = AuthState.loading();
    try {
      final response = await authRepository.refreshAccessToken();
      state = AuthState.success(response.data);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }
}
