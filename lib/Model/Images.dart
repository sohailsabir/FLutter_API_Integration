class Images {
  Images({
      String? id, 
      String? url,}){
    _id = id;
    _url = url;
}

  Images.fromJson(dynamic json) {
    _id = json['id'];
    _url = json['url'];
  }
  String? _id;
  String? _url;
Images copyWith({  String? id,
  String? url,
}) => Images(  id: id ?? _id,
  url: url ?? _url,
);
  String? get id => _id;
  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['url'] = _url;
    return map;
  }

}