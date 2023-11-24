import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:quran_app/model/UserProfile.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  UserProfile? user ;
  var Token;

  final storage = new FlutterSecureStorage();

  static LoginCubit get(context) => BlocProvider.of(context);

  Future<void> login({required String email, required String password}) async {
    if (state is! LoginInitial) {
      throw Exception('Cannot emit new states after calling close');
    }
    emit(LoginLoadingState());
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      await storage.write(key: 'uid', value: userCredential.user!.uid);
      Token = await storage.read(key: 'uid');
      emit(LoginSuccessState());
    } catch (error) {
      emit(LoginErrorState());
    }
  }
}