import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/utils/navigator.dart';
import 'package:quran_app/views/MainScrean.dart';
import 'package:quran_app/widget/custom_text_field.dart';
import 'package:quran_app/widget/login_with_face_book_buttom.dart';

import '../blocs/LoginCubit/login_cubit.dart';
import '../widget/custom_bottom.dart';

class LoginBody extends StatefulWidget {
  LoginBody({Key? key}) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final formKey = GlobalKey<FormState>();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Form(
            key: formKey,
            autovalidateMode: autovalidateMode,

            child: Column(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomTextField(
                    hint: 'email',
                    icon: Icons.email,
                    controller: cubit.emailController,

                  ),
                  CustomTextField(
                    hint: 'password',
                    icon: Icons.lock,

                    controller: cubit.passwordController,

                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(onPressed: () {},
                        child: Text('Forget Password?',
                          style: TextStyle(color: Colors.grey),)),
                  ),
                  SizedBox(height: 150,),
                  if (state is LoginLoadingState)
                    const CircularProgressIndicator()
                  else
                  CustomButton(
                    buttonName: 'Login',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        if (cubit.emailController.text.isNotEmpty &&
                            cubit.passwordController.text.isNotEmpty) {
                          cubit.login(
                              email: cubit.emailController.text,
                              password: cubit.passwordController.text).then((value)  {

                                navigateToScreenAndExit(context, MainScraen());

                          });
                        }

                        print('Validated');
                      } else {
                        print('Not Validated');
                      }
                    },

                  ),
                  SizedBox(height: 20,),
                  LoginWithFaceBookButtom(
                    buttonName: 'Login with Facebook',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();

                        print('Validated');
                      } else {
                        print('Not Validated');
                      }
                    },

                  )
                ]),
          );
        },
      ),
    );
  }
}
