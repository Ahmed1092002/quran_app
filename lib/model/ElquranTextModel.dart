
class ElquranTextModel {
  ElquranTextModel({
      this.code, 
      this.status, 
      this.data,});

  ElquranTextModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? code;
  String? status;
  Data? data;
ElquranTextModel copyWith({  num? code,
  String? status,
  Data? data,
}) => ElquranTextModel(  code: code ?? this.code,
  status: status ?? this.status,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}


class Data {
  Data({
      this.surahs, 
      this.edition,});

  Data.fromJson(dynamic json) {
    if (json['surahs'] != null) {
      surahs = [];
      json['surahs'].forEach((v) {
        surahs?.add(Surahs.fromJson(v));
      });
    }
    edition = json['edition'] != null ? Edition.fromJson(json['edition']) : null;
  }
  List<Surahs>? surahs;
  Edition? edition;
Data copyWith({  List<Surahs>? surahs,
  Edition? edition,
}) => Data(  surahs: surahs ?? this.surahs,
  edition: edition ?? this.edition,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (surahs != null) {
      map['surahs'] = surahs?.map((v) => v.toJson()).toList();
    }
    if (edition != null) {
      map['edition'] = edition?.toJson();
    }
    return map;
  }

}


class Edition {
  Edition({
      this.identifier, 
      this.language, 
      this.name, 
      this.englishName, 
      this.format, 
      this.type,});

  Edition.fromJson(dynamic json) {
    identifier = json['identifier'];
    language = json['language'];
    name = json['name'];
    englishName = json['englishName'];
    format = json['format'];
    type = json['type'];
  }
  String? identifier;
  String? language;
  String? name;
  String? englishName;
  String? format;
  String? type;
Edition copyWith({  String? identifier,
  String? language,
  String? name,
  String? englishName,
  String? format,
  String? type,
}) => Edition(  identifier: identifier ?? this.identifier,
  language: language ?? this.language,
  name: name ?? this.name,
  englishName: englishName ?? this.englishName,
  format: format ?? this.format,
  type: type ?? this.type,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['identifier'] = identifier;
    map['language'] = language;
    map['name'] = name;
    map['englishName'] = englishName;
    map['format'] = format;
    map['type'] = type;
    return map;
  }

}



class Surahs {
  Surahs({
      this.number, 
      this.name, 
      this.englishName, 
      this.englishNameTranslation, 
      this.revelationType, 
      this.ayahs,});

  Surahs.fromJson(dynamic json) {
    number = json['number'];
    name = json['name'];
    englishName = json['englishName'];
    englishNameTranslation = json['englishNameTranslation'];
    revelationType = json['revelationType'];
    if (json['ayahs'] != null) {
      ayahs = [];
      json['ayahs'].forEach((v) {
        ayahs?.add(Ayahs.fromJson(v));
      });
    }
  }
  num? number;
  String? name;
  String? englishName;
  String? englishNameTranslation;
  String? revelationType;
  List<Ayahs>? ayahs;
Surahs copyWith({  num? number,
  String? name,
  String? englishName,
  String? englishNameTranslation,
  String? revelationType,
  List<Ayahs>? ayahs,
}) => Surahs(  number: number ?? this.number,
  name: name ?? this.name,
  englishName: englishName ?? this.englishName,
  englishNameTranslation: englishNameTranslation ?? this.englishNameTranslation,
  revelationType: revelationType ?? this.revelationType,
  ayahs: ayahs ?? this.ayahs,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['number'] = number;
    map['name'] = name;
    map['englishName'] = englishName;
    map['englishNameTranslation'] = englishNameTranslation;
    map['revelationType'] = revelationType;
    if (ayahs != null) {
      map['ayahs'] = ayahs?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}



class Ayahs {
  Ayahs({
      this.number,
      this.audio,
      this.audioSecondary,
      this.text,
      this.numberInSurah,
      this.juz,
      this.manzil,
      this.page,
      this.ruku,
      this.hizbQuarter,
      this.sajda,});

  Ayahs.fromJson(dynamic json) {
    number = json['number'];
    audio = json['audio'];
    audioSecondary = json['audioSecondary'] != null ? json['audioSecondary'].cast<String>() : [];
    text = json['text'];
    numberInSurah = json['numberInSurah'];
    juz = json['juz'];
    manzil = json['manzil'];
    page = json['page'];
    ruku = json['ruku'];
    hizbQuarter = json['hizbQuarter'];
    if (json['sajda'] is bool) {
      sajda = json['sajda'];
    } else if (json['sajda'] is Map) {
      // Handle the case where 'sajda' is a map
      // You need to decide how to convert the map to a boolean value
      // This is just an example
      sajda = json['sajda']['someKey'] as bool?;
    }

    // sajda = json['sajda'];
  }
  num? number;
  String? audio;
  List<String>? audioSecondary;
  String? text;
  num? numberInSurah;
  num? juz;
  num? manzil;
  num? page;
  num? ruku;
  num? hizbQuarter;
  bool? sajda;
Ayahs copyWith({  num? number,
  String? audio,
  List<String>? audioSecondary,
  String? text,
  num? numberInSurah,
  num? juz,
  num? manzil,
  num? page,
  num? ruku,
  num? hizbQuarter,
  bool? sajda,
}) => Ayahs(  number: number ?? this.number,
  audio: audio ?? this.audio,
  audioSecondary: audioSecondary ?? this.audioSecondary,
  text: text ?? this.text,
  numberInSurah: numberInSurah ?? this.numberInSurah,
  juz: juz ?? this.juz,
  manzil: manzil ?? this.manzil,
  page: page ?? this.page,
  ruku: ruku ?? this.ruku,
  hizbQuarter: hizbQuarter ?? this.hizbQuarter,
  sajda: sajda ?? this.sajda,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['number'] = number;
    map['audio'] = audio;
    map['audioSecondary'] = audioSecondary;
    map['text'] = text;
    map['numberInSurah'] = numberInSurah;
    map['juz'] = juz;
    map['manzil'] = manzil;
    map['page'] = page;
    map['ruku'] = ruku;
    map['hizbQuarter'] = hizbQuarter;
    map['sajda'] = sajda;
    return map;
  }

}