import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quran_app/model/UserProfile.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../model/UserProfile.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());static UserCubit get(context) => BlocProvider.of(context);
  UserProfile? user;
  File? profileImage;
  String? profileImageLink = '';
  var imagePicker = ImagePicker();
  String ?token;
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();

  final storage =   FlutterSecureStorage();

  getUserData()  async {
    token=await storage.read(key:'uid' );
    if (token!=null) {
      print(token);
      emit(UserLoadingState());
      print('User Loading State');
      FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(      token
      )
          .get()
          .then((value) {
        print(value.data());
        user = UserProfile.fromJson(value.data()!);
        print(user!.toJson());
        emit(UserSuccessState());
      }).catchError((error) {
        print(error);
        emit(UserErrorState());
      });
    }

  }

  Future<void> pickProfileImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());

    } else {
      print('No image selected.');
      emit(ProfileImagePickedErrorState());
    }
  }


  uploadProfileImage() {
    if (profileImage != null) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
          .putFile(profileImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          print(value);
          profileImageLink = value;

          emit(uploadProfileImageSuccessState());
        });
      })
          .catchError((error) {
        print(error);
        emit(uploadProfileImageErrorState());
      });
    } else {
      print('No profile image selected.');
      emit(uploadProfileImageErrorState());
    }
  }

  updateUserProfile({
    String? email,
    String? fullName,


    String?  profileImageLink,
  }) async {
    user=UserProfile(email: email==null||email==''?user!.email:email,


      fullName: fullName==null||fullName==''?user!.fullName:fullName,


      uid: user!.uid,


      image: profileImageLink==null||profileImageLink==''? '':profileImageLink,);
    token=await storage.read(key:'uid' );


    emit(UserUpdateLoadingState());

    FirebaseFirestore.instance.collection('users').doc(token).update(

        user!.toJson()
    )
        .then((value) {

      print('User Updated Successfully');
      print(user!.toJson());


      getUserData();
      emit(UserUpdateSuccessState());

    })
        .catchError((error) {
      print(error);
      emit(UserUpdateErrorState());
    });
    // if (user != null && profileImageLink != null) {
    //
    // } else {
    //   print('User or profile image link is null.');
    //   emit(UserUpdateErrorState());
    // }
  }
  chanegPassword({required String password}) async {
    emit(ChangePasswordLoadingState());
    FirebaseAuth.instance.currentUser!.updatePassword(password).then((value) {
      emit(ChangePasswordSuccessState());
    }).catchError((error) {
      print(error);
      emit(ChangePasswordErrorState());
    });
  }


}
