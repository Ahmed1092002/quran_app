import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/PrayerTimes/prayer_times_api_cubit.dart';
import '../generated/assets.dart';

class PlayerTimeBodyDate extends StatelessWidget {
  const PlayerTimeBodyDate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,

              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          image: const DecorationImage(
            image: AssetImage(Assets.imageHomeHeader),
            fit: BoxFit.fill,
          ),
        ),
        child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 20, top: 5),
            child: Container(
              width: 220,
              height: 150,


              child: BlocConsumer<PrayerTimesApiCubit, PrayerTimesApiState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  var cubit = PrayerTimesApiCubit.get(context).playerTimesModel;

                if (cubit == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'اليوم',
                      textDirection: TextDirection.rtl,

                      style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Expanded(
                        child: Container(
                          height: 55,

                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.white, width: 1)),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                              children: [
                                Flexible(
                                  child: Text(
                                    cubit.data!.date!.hijri!.month!.ar!,
                                    overflow: TextOverflow.ellipsis,

                                    textDirection: TextDirection.rtl
                                    //,'محرم'
                                   , style: TextStyle(

                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                VerticalDivider(
                                  color: Colors.white,
                                  thickness: 2,
                                  indent: 5,
                                  endIndent: 5,
                                ),
                                Text(
                                '  ${
                                    int.tryParse(cubit.data!.date!.hijri!.day!.trim())

                                  } ',                                overflow: TextOverflow.visible
                  // cubit.data!.date!.hijri!.day.toString(),
                                  ,style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          cubit.data!.date!.hijri!.year.toString(),
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
