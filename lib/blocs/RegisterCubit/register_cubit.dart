import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

import '../../model/UserProfile.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  var Token;

  final storage = new FlutterSecureStorage();

  Future<void> register({required String email, required String password, required String name}) async {
    if (state is! RegisterInitial) {
      throw Exception('Cannot emit new states after calling close');
    }
    emit(RegisterLoadingState());
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      await createNewUser(email: email, password: password, name: name, uid: userCredential.user!.uid);
      await storage.write(key: 'uid', value: userCredential.user!.uid);
      Token = await storage.read(key: 'uid');
      emit(RegisterSuccessState());
    } catch (error) {
      emit(RegisterErrorState());
    }
  }

  Future<void> createNewUser({required String email, required String password, required String name, required String uid}) async {
    UserProfile userProfile = UserProfile(email: email, fullName: name, uid: uid);
    emit(UserCreateLoadingState());
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set(userProfile.toJson());
      emit(UserCreateSuccessState());
    } catch (error) {
      emit(UserCreateErrorState());
    }
  }
}