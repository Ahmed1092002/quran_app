import 'package:flutter/material.dart';
import 'package:quran_app/model/ElquranTextModel.dart';
import 'package:quran_app/model/elquran.dart';
import 'package:quran_app/utils/navigator.dart';
import 'package:quran_app/views/surah_screan.dart';


class SurahBody extends StatefulWidget {
  const SurahBody({Key? key}) : super(key: key);

  @override
  _SurahBodyState createState() => _SurahBodyState();
}

class _SurahBodyState extends State<SurahBody> {
  ElquranTextModel? elquranTextModel;
  @override
  void initState() {

    elquranTextModel = ElquranTextModel.fromJson(elquran);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if (elquranTextModel == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return ListView.separated(
        itemCount:elquranTextModel!.data!.surahs!.length,
        itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ListTile(


                title: Text(
                  elquranTextModel!.data!.surahs![index].name!,
                    style:  Theme.of(context).textTheme.bodyLarge
                ),
                titleTextStyle: Theme.of(context).textTheme.bodyLarge,

                trailing: Icon(Icons.arrow_forward_ios),
                leading: CircleAvatar(
                    radius: elquranTextModel!.data!.surahs![index].number!.toString().length > 2 ? 20 : 15,
                    backgroundColor: Theme.of(context).backgroundColor,
                    child: Text('${index + 1}',
                        style: Theme.of(context).textTheme.bodySmall
                    )
                ),
                subtitleTextStyle: Theme.of(context).textTheme.bodyMedium,

                subtitle: Text('${elquranTextModel!.data!.surahs![index].revelationType == 'Meccan' ? 'مكيه' : 'مدنيه'}'
                    '-'
                    ' ${elquranTextModel!.data!.surahs![index].ayahs!.length} ايات'

                ),




                onTap: () {
                  navigateToScreen(context, SurahScrean(
                    surahName: elquranTextModel!.data!.surahs![index].name!,
                   surahText: elquranTextModel!.data!.surahs![index].ayahs,
                  ));
                },
              )
            )


        ),
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey,
          thickness: 1,
          height: 10,
          endIndent: 15,
          indent: 15,
        )



    );
  }
}
