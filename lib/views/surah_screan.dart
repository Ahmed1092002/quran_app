import 'package:flutter/material.dart';
import 'package:quran_app/generated/assets.dart';
import 'package:quran_app/model/ElquranTextModel.dart';

import '../widget/shared_app_bar.dart';

class SurahScrean extends StatefulWidget {
  String? surahName;
  List<Ayahs>? surahText;

  SurahScrean({Key? key, this.surahName, this.surahText}) : super(key: key);

  @override
  _SurahScreanState createState() => _SurahScreanState();
}

class _SurahScreanState extends State<SurahScrean> {
  String basmala = "بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ";
  String basmalaText = '';

  String surahText = '';

  String oneLine(int page) {
    if (page < pageSet.length) {
      for (int i = 0; i < widget.surahText!.length; i++) {
        if (widget.surahText![i].page == pageSet.elementAt(page)) {
          if (widget.surahText![i].text.toString().contains(basmala)) {
            basmalaText = basmala;
            surahText +=
            "${widget.surahText![i].text.toString().replaceFirst(basmala, '')}﴿${widget.surahText![i].numberInSurah}﴾";
          } else {
            surahText +=
            '${widget.surahText![i].text.toString()}﴿${widget.surahText![i].numberInSurah}﴾';
          }
        } else if (page + 1 < pageSet.length && widget.surahText![i].page == pageSet.elementAt(page + 1)) {
          break;
        }
      }
    }

    return surahText;
  }
  Set<int> pageSet = Set<int>();

  pageCountLoop() {
    for (int i = 0; i < widget.surahText!.length; i++) {
      pageSet.add(widget.surahText![i].page!.toInt());
    }
    print(pageSet);
    print(pageSet.length);
    return pageSet.length;
  }

  @override
  void initState() {
    pageCountLoop();
    oneLine(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int totalPageCount = pageCountLoop();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(38),
        child: SharedAppBar(),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
            child: Column(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                image: AssetImage(Assets
                    .imageF034e0b60aa64ac4A797B3542e0220c9RemovebgPreview

                ),
                fit: BoxFit.cover,

              ),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                widget.surahName!,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color:Theme.of(context).brightness == Brightness.dark ? Colors.white:Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: PageView.builder(
                itemCount: pageSet.length,
                onPageChanged: (index) {
                  setState(() {
                    surahText = '';
print ('index$index');

                      surahText = oneLine(index);


                    if (index != 0) {
                      basmalaText = '';
                    } else {
                      basmalaText = basmala;
                    }
                  });
                },
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.75,

                          child: Center(
                              child: ListView(
                            padding: EdgeInsets.all(12),
                            children: [
                              Text(
                                basmalaText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                surahText,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )),
                        ),
                        Text(
                          "${pageSet.elementAt(index)}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ])),
      ),
    );
  }
}
