import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/utils/navigator.dart';
import 'package:quran_app/views/login_sign_up_screan.dart';
import 'package:quran_app/widget/shared_app_bar.dart';

import '../blocs/UserCubit/user_cubit.dart';
import '../generated/assets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class SettingScrean extends StatelessWidget {
   SettingScrean({Key? key}) : super(key: key);
  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: SharedAppBar(
          Titel: 'الاعدادات',
        ),
      ),

      body: BlocProvider(
        create: (context) => UserCubit()..getUserData(),
        child: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var cubit = UserCubit.get(context);
if (state is UserLoadingState || cubit.user == null) {
              return Center(child: CircularProgressIndicator());
            }
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
             Image.asset(Assets.imageLogo, width: 150),
               const SizedBox(height:20,),
ListTile(
                    title: Text('الاسم'),
                    trailing: Text(cubit.user!.fullName!,
                    style: Theme.of(context).textTheme.bodyMedium,
                    ),
  titleTextStyle: Theme.of(context).textTheme.bodyLarge,


                  ),
                  ListTile(
                    title: Text('البريد الالكتروني'),
                    trailing: Text(cubit.user!.email!
                    ,style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),

                  ListTile(
                    title: Text('اللغة'),
                    titleTextStyle: Theme.of(context).textTheme.bodyLarge,

                    trailing: Text('العربية',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  ListTile(
                    title: Text('المظهر'),
                    trailing: Text(Theme.of(context).brightness == Brightness.dark ? 'الوضع الليل' : 'الوضع النهاري',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  ElevatedButton(onPressed: ()async {
                    await FirebaseAuth.instance.signOut();
                    await storage.delete(key: 'uid');
                    Navigator.pop(context);
                    navigateToScreenAndExit(context, LoginAndSignUpScrean());
                  },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(200, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text('تسجيل الخروج'
                      ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                      )

                  )
                ],
              ),


            );
          },
        ),
      ),
    );
  }
}
