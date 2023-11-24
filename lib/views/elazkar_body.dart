import 'package:flutter/material.dart';
import 'package:quran_app/model/ElazkarModel.dart';
import 'package:quran_app/utils/navigator.dart';
import 'package:quran_app/views/elazkar_screan.dart';
import 'package:quran_app/widget/custom_text.dart';
import 'package:quran_app/widget/elazkar_container.dart';

import '../model/adhkar.dart';

class ElazkarBody extends StatefulWidget {
  const ElazkarBody({Key? key}) : super(key: key);

  @override
  _ElazkarBodyState createState() => _ElazkarBodyState();
}

class _ElazkarBodyState extends State<ElazkarBody> {
  ElazkarModel? elazkarModel ;
  @override
  void initState() {
    // TODO: implement initState
    elazkarModel = ElazkarModel.fromJson(MapsOfElazkar);
    convertIntoMap();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Container(
        height: MediaQuery.of(context).size.height/0.1,
        decoration: BoxDecoration(


        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomText(
              text: 'الادعية و الاذكار',

            ),
            Container(
              height: MediaQuery.of(context).size.height*0.7,

              child: ListView.builder(
                shrinkWrap: true,

                itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(10.0), child: InkWell(

                    onTap: (){
                      navigateToScreen(context, ElazkarScrean(
                        Title: elazkarModel!.elazkar![index].category,
                        Description: elazkarModel!.elazkar![index].array!,
                      ));
                    },
                      child: ElazkarContainer(
                  text: elazkarModel!.elazkar![index].category,


                ),
                    )),
                itemCount: elazkarModel!.elazkar!.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
