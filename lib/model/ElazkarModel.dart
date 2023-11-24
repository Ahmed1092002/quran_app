class ElazkarModel {
  List<Elazkar>? elazkar;

  ElazkarModel({this.elazkar});

  ElazkarModel.fromJson(Map<String, dynamic> json) {
    if (json['Elazkar'] != null) {
      elazkar = <Elazkar>[];
      json['Elazkar'].forEach((v) {
        elazkar!.add(new Elazkar.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.elazkar != null) {
      data['Elazkar'] = this.elazkar!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Elazkar {
  int? id;
  String? category;
  String? audio;
  String? filename;
  List<Array>? array;

  Elazkar({this.id, this.category, this.audio, this.filename, this.array});

  Elazkar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    audio = json['audio'];
    filename = json['filename'];
    if (json['array'] != null) {
      array = <Array>[];
      json['array'].forEach((v) {
        array!.add(new Array.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['audio'] = this.audio;
    data['filename'] = this.filename;
    if (this.array != null) {
      data['array'] = this.array!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Array {
  int? id;
  String? text;
  int? count;
  String? audio;
  String? filename;

  Array({this.id, this.text, this.count, this.audio, this.filename});

  Array.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    count = json['count'];
    audio = json['audio'];
    filename = json['filename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['count'] = this.count;
    data['audio'] = this.audio;
    data['filename'] = this.filename;
    return data;
  }
}
