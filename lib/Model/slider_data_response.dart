class SliderData {
  bool? error;
  List<SliderDataList>? data;

  SliderData({this.error, this.data});

  SliderData.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['data'] != null) {
      data = <SliderDataList>[];
      json['data'].forEach((v) {
        data!.add(new SliderDataList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SliderDataList {
  String? id;
  String? type;
  String? typeId;
  String? image;
  String? dateAdded;

  SliderDataList({this.id, this.type, this.typeId, this.image, this.dateAdded});

  SliderDataList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    typeId = json['type_id'];
    image = json['image'];
    dateAdded = json['date_added'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['type_id'] = this.typeId;
    data['image'] = this.image;
    data['date_added'] = this.dateAdded;
    return data;
  }
}
