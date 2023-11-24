import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/blocs/RegisterCubit/register_cubit.dart';
import 'package:quran_app/views/MainScrean.dart';

import '../widget/custom_bottom.dart';
import '../widget/custom_text_field.dart';

class SignUpBody extends StatefulWidget {
  SignUpBody({Key? key}) : super(key: key);

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  final GlobalKey<FormState> formKey = GlobalKey();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MainScraen(),
              ),
            );
          }
          if (state is RegisterErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('error'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              var cubit = RegisterCubit.get(context);
              return Form(
                  key: formKey,
                  autovalidateMode: autovalidateMode,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(height: 30,),

                      Text('Create Account', style: TextStyle(fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFA7031)),),
                      const SizedBox(height: 20,),

                      CustomTextField(
                        hint: 'Full Name',
                        icon: Icons.person,
                        controller: cubit.nameController,

                      ),
                      CustomTextField(
                        hint: 'Email',
                        icon: Icons.email,
                        controller: cubit.emailController,

                      ),
                      CustomTextField(
                        hint: 'Password',
                        icon: Icons.lock,
                        controller: cubit.passwordController,),
                      CustomTextField(
                        hint: 'Confirm Password',
                        icon: Icons.lock,
                        controller: cubit.confirmPasswordController,),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isChecked = !isChecked;
                                });
                              },
                              child: Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  gradient: isChecked
                                      ? LinearGradient(
                                    colors: [
                                      Color(0xFFFA7031),
                                      Color(0xFFE64A19),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                      : null,

                                ),
                                child: Checkbox(
                                  value: isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  },
                                  activeColor: Colors.transparent,
                                  checkColor: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('I agree all statements in',),
                                Text('Terms of service',
                                  style: TextStyle(color: Color(0xFFFA7031)),),
                              ],
                            ),

                          ]
                      ),
                      const SizedBox(height: 50,),
                      if (state is RegisterLoadingState)
                        const CircularProgressIndicator()
                      else
                        CustomButton(
                            buttonName: 'Sign Up',
                            onPressed: ()async {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                if (cubit.passwordController.text ==
                                    cubit.confirmPasswordController.text) {
                                  if (isChecked)  {
                                await    cubit.register(
                                        email: cubit.emailController.text,
                                        password: cubit.passwordController.text,
                                        name: cubit.nameController.text).whenComplete(() => {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                        builder: (context) =>

                                        const MainScraen(),))

                                });

                                  }
                                  else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Please agree to the terms'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Password not match'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }

                                print('Validated');
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Please enter your data'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                        )

                    ],
                  )


              );
            },
          );
        },
      ),
    );
  }
}
