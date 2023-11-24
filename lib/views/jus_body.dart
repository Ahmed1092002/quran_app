import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/blocs/ElquranCubit/elquran_cubit.dart';
import 'package:quran_app/utils/navigator.dart';
import 'package:quran_app/views/jus_screan.dart';

class JusBody extends StatefulWidget {
  const JusBody({Key? key}) : super(key: key);

  @override
  _JusBodyState createState() => _JusBodyState();
}

class _JusBodyState extends State<JusBody> {


  @override
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ElquranCubit, ElquranState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ElquranCubit.get(context);


        return ListView.separated(
            itemCount: 30,
            itemBuilder: (context, index) =>
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child:ListTile(
                        title: Text(cubit.Jus[index],

style: Theme.of(context).textTheme.bodyLarge,),

                        titleTextStyle: Theme.of(context).textTheme.bodyLarge,

                        trailing: Icon(Icons.arrow_forward_ios),
                        leading: CircleAvatar(
                            radius: 20,
                            backgroundColor: Theme.of(context).backgroundColor,
                            child: Text('${index+1}'
                            ,
                                style: Theme.of(context).textTheme.bodySmall
                            )
                        ),
                        onTap: ()   {
                          print("index $index");


                          cubit.getJus(juzNumber: index+1)
                              .then((value) => {

if (state is ElquranGetJusLoadingState)
  {
  CircularProgressIndicator(),

  }  else
  {
                                navigateToScreen(
                                    context,
                                    JusScrean(
                                      surahText:
                                          cubit.jusTextModel!.data!.ayahs,
                                    ))
                              }
                          });


                        },
                      ),
                    )


                ),
            separatorBuilder: (context, index) =>
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                  height: 10,
                  endIndent: 15,
                  indent: 15,
                )


        );
      },
    );
  }
}