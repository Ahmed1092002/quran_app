import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/views/audio_quran_list.dart';

import '../blocs/ElquranCubit/elquran_cubit.dart';
import '../utils/navigator.dart';


class ElquranPlayerBody extends StatefulWidget {
  const ElquranPlayerBody({Key? key}) : super(key: key);

  @override
  _ElquranPlayerBodyState createState() => _ElquranPlayerBodyState();
}

class _ElquranPlayerBodyState extends State<ElquranPlayerBody> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ElquranCubit.get(context).getQuranAudioPlayer();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ElquranCubit, ElquranState>(
      listener: (context, state) {
        if (state is ElquranInitial) {
          ElquranCubit.get(context).getQuranAudioPlayer();
        }
      },
      builder: (context, state) {
        var cubit = ElquranCubit.get(context);

if (cubit.quranAudioPlayerModel==null) {
  return Center(child: CircularProgressIndicator(),);
}
List widghts=[];
        for (int i = 0; i < cubit.quranAudioPlayerModel!.reciters!.length; i++) {
          for (int j = 0; j < cubit.quranAudioPlayerModel!.reciters![i].moshaf!.length; j++) {
            widghts.add(
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        title: Text(
                            cubit.quranAudioPlayerModel!.reciters![i].name ==
                                null ? '' : cubit.quranAudioPlayerModel!
                                .reciters![i].name!,
                        style:  Theme.of(context).textTheme.bodyLarge


                        ),
                       titleTextStyle: Theme.of(context).textTheme.bodyLarge,

                        trailing: Icon(Icons.arrow_forward_ios),
                        leading: CircleAvatar(
                            radius: 20,
                     backgroundColor: Theme.of(context).backgroundColor,
                            child: Text('${i + 1}'
                              ,
                              style: Theme.of(context).textTheme.bodySmall
                            )
                        ),
                        subtitleTextStyle: Theme.of(context).textTheme.bodyMedium,
                        subtitle:
                        Text(cubit.quranAudioPlayerModel!.reciters![i]
                            .moshaf![j].name == null ? '' : cubit
                            .quranAudioPlayerModel!.reciters![i].moshaf![j]
                            .name!),
                        onTap: () {

                          cubit.getQuranAudioPlayer().then((value) {
                            CircularProgressIndicator();
                          }).whenComplete(() {
                            navigateToScreen(context, AudioQuranList(
                              audioFiles: cubit.quranAudioPlayerModel!
                                  .reciters![i].moshaf![j],
                              surahNames: cubit.surahNames,
                              ElshaikhName: cubit.quranAudioPlayerModel!
                                  .reciters![i].name!,

                            ));
                          });
                        },
                      ),
                    )


                )
            );
          }
        }
        return ListView.separated(
            itemCount: widghts.length,
            itemBuilder: (context, index) {


              return widghts.elementAt(index);


            },
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
