import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/model/QuranAudioPlayerModel.dart';

import '../widget/shared_app_bar.dart';



class AudioQuranList extends StatefulWidget {
  String?ElshaikhName;
  List<String>?surahNames;
  Moshaf?audioFiles;
  AudioQuranList({Key? key,

    this.ElshaikhName,
    this.surahNames,
    this.audioFiles,

  }) : super(key: key);

  @override
  _AudioQuranListState createState() => _AudioQuranListState();
}

class _AudioQuranListState extends State<AudioQuranList> {
  int? _playingIndex=0; // Add this line to keep track of the currently playing index

  bool _isPlaying = false;
  AudioPlayer audioPlayer = AudioPlayer();
  playAudio(int id ) {
    String formattedId = id.toString().padLeft(3, '0');
    print (formattedId);
    audioPlayer.play(
      UrlSource(

         '${widget.audioFiles!.server}/${formattedId}.mp3',

      ),
      mode: PlayerMode.mediaPlayer,
    ).then((value) => {
      setState(() {
        _isPlaying = true;
      })
    }).catchError((error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('this Audio is not available'),
    ));
    });


  }


  @override
  Widget build(BuildContext context) {
    if (widget.audioFiles==null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child:SharedAppBar(
Titel: widget.ElshaikhName,
        )
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,

        child: ListView.separated(
          itemBuilder:(context, index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child:ListTile(
                  title: Text(widget.surahNames![index],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                  trailing: Icon(_isPlaying && index == _playingIndex ?  Icons.pause : Icons.play_arrow),
                  leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Color(0xFF333333),
                      child: Text('${index+1}'
                        ,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      )
                  ),
                  onTap: ()   {

                    if (_isPlaying && index == _playingIndex) {
                      audioPlayer.pause();
                      setState(() {
                        _isPlaying = false;
                      });
                    } else {
                      _playingIndex = index; // Set the currently playing index to the tapped index

                      playAudio(index+1);
                    }
                  },
                ),
              ),
            );
          },
          itemCount:widget.surahNames!.length ,
          separatorBuilder: (context, index) => Divider(
            thickness: 1,
            color: Colors.grey,
          ),
        ),

      ),
    );
  }
}
