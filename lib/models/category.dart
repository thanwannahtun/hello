class Category {
  Category({this.id, this.name, this.parentId, this.parentName});
  int? id;
  String? name;
  int? parentId;
  String? parentName;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'],
        name: json['name'],
        parentId: json['parentId'],
        parentName: json['parentName'],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id as int;
    map['name'] = name as String;
    map['parentId'] = parentId;
    map['parentName'] = parentName;
    return map;
  }

  Category copyWith(
      {int? id, String? name, int? parentId, String? parentName}) {
    return Category(
        id: id ?? id,
        name: name ?? name,
        parentId: parentId ?? this.parentId,
        parentName: parentName ?? this.parentName);
  }

  @override
  String toString() {
    return 'Category{id=$id, name=$name, parentId=$parentId, parentName=$parentName}';
  }
}
