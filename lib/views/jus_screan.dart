import 'package:flutter/material.dart';
import 'package:quran_app/model/JusTextModel.dart';

import '../generated/assets.dart';
import '../widget/shared_app_bar.dart';

class JusScrean extends StatefulWidget {
  List<Ayahs>? surahText;
  JusScrean({Key? key, this.surahText}) : super(key: key);

  @override
  _JusScreanState createState() => _JusScreanState();
}

class _JusScreanState extends State<JusScrean> {


  String surahText = '';
  Map<String, String> surahTextMap = Map<String, String>();
  Map<int, Map<String, String>> pageMap = Map<int, Map<String, String>>();

  Map<int, Map<String, String>> oneLine(int page) {
    if (page < pageSet.length) {
      for (int i = 0; i < widget.surahText!.length; i++) {
        if (widget.surahText![i].page == pageSet.elementAt(page)) {
          // Update the Surah name if it's different from the current one
          if (widget.surahText![i].surah!.name != pageNameString) {
            pageNameString = widget.surahText![i].surah!.name!;
          }

          surahText +=
              '${widget.surahText![i].text.toString()}﴿${widget.surahText![i].numberInSurah}﴾';
          if (i==widget.surahText!.length){
            surahTextMap[pageNameString] = surahText;


          }
          else if (widget.surahText![i + 1].page !=
              pageSet.elementAt(page)) {
            surahTextMap[pageNameString] = surahText;
            pageMap[pageSet.elementAt(page)] = surahTextMap;

            surahText = '';
          }
        } else if (page + 1 < pageSet.length &&
            widget.surahText![i].page == pageSet.elementAt(page + 1)) {
          break;
        }
      }
      pageMap[pageSet.elementAt(page)] = surahTextMap;
    }

    return pageMap;
  }
  Set<int> pageSet = Set<int>();

  void oneLineLoop(int page) {
    surahTextMap.clear();
    print('Page: $page'); // Print the page parameter
    print('Surah Text Length: ${widget.surahText?.length}'); /// Clear the map for each new page
    String currentSurah = '';
    for (var ayah in widget.surahText!) {
      int ayahPage = ayah.page!;
      print('Ayah Page: $ayahPage');
      if (ayahPage == pageSet.elementAt(page)) {
        print('Found an Ayah on the current page'); // Print a message when an Ayah on the current page is found

        String surahName = ayah.surah!.name!;
        String numberInSurah = ayah.numberInSurah.toString();
        String text = ayah.text!;

        // If the Surah name is different from the current one, reset the surahText
        if (surahName != currentSurah) {
          currentSurah = surahName;
          surahText = '';
        }

        surahText += text + '﴿$numberInSurah﴾';
        surahTextMap[surahName] = surahText;

        print('Current Surah: $currentSurah'); // Print the current Surah
        print('Surah Text: $surahText');
      }
    }
    print(surahTextMap); // Print the map to check the result

  }
    pageCountLoop() {
      for (int i = 0; i < widget.surahText!.length; i++) {
        pageSet.add(widget.surahText![i].page!.toInt());
      }
      print(pageSet);
      return pageSet.length;
    }

    String pageNameString = '';
    // PageNameLoop(int page) {
    //   if (page < pageSet.length) {
    //     for (int i = 0; i < widget.surahText!.length; i++) {
    //       if (widget.surahText![i].page == pageSet.elementAt(page)) {
    //         pageNameString = widget.surahText![i].surah!.name!.toString();
    //       } else if (page + 1 < pageSet.length &&
    //           widget.surahText![i].page == pageSet.elementAt(page + 1)) {
    //         break;
    //       }
    //     }
    //   }
    // }

    @override
    void initState() {
      pageCountLoop();
      // PageNameLoop(0);
      oneLineLoop(0);
      super.initState();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(38),
          child: SharedAppBar(),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            child: PageView.builder(
              itemCount: pageSet.length,
              onPageChanged: (index) {
                setState(() {
                  print('index$index');
                  oneLineLoop(index);
                });
              },
              itemBuilder: (context, index) {
                if (index < pageSet.length) {

                  return Column(

                    children: surahTextMap.entries.map((entry) {
                      return Flexible(
                        fit: FlexFit.loose,
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),

                                image: DecorationImage(
                                  image: AssetImage(Assets.imageF034e0b60aa64ac4A797B3542e0220c9RemovebgPreview),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  " ${entry.key}",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              fit: FlexFit.loose,
                              child: ListView(
                                padding: EdgeInsets.all(12),
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    entry.value,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                                '${pageSet.elementAt(index)}'
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ),
        ),
      );
    }

}
