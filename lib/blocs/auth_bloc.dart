import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/utils/app_consts.dart';

class AuthState {
  final bool isAuthenticated;
  final String? error;

  AuthState({required this.isAuthenticated, this.error});
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState(isAuthenticated: false));

  void login(String email, String password) {
    if (email == AppConstants.email && password == AppConstants.password) {
      emit(AuthState(isAuthenticated: true));
    } else {
      emit(AuthState(isAuthenticated: false, error: "Invalid credentials"));
    }
  }
}
