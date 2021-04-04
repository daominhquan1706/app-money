class TypeRecord {
  int id;
  String name;
  String imageUrl;
  TypeRecord({
    this.id,
    this.name,
    this.imageUrl,
  });

  factory TypeRecord.fromJson(Map<String, dynamic> json) {
    return TypeRecord(
      id: json['id'] as int,
      name: json['typeRecord_name'] as String,
      imageUrl: json['image_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['typeRecord_name'] = name;
    data['image_url'] = imageUrl;
    return data;
  }
}
