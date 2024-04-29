class Category {
  Category(
      {this.categoryId, this.categoryName, this.parentId, this.parentName});
  int? categoryId;
  String? categoryName;
  int? parentId;
  String? parentName;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json['categoryId'],
        categoryName: json['categoryName'],
        parentId: json['parentId'],
        parentName: json['parentName'],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['categoryId'] = categoryId as int;
    map['categoryName'] = categoryName as String;
    map['parentId'] = parentId;
    map['parentName'] = parentName;
    return map;
  }

  Category copyWith(
      {int? categoryId,
      String? categoryName,
      int? parentId,
      String? parentName}) {
    return Category(
        categoryId: categoryId ?? this.categoryId,
        categoryName: categoryName ?? this.categoryName,
        parentId: parentId ?? this.parentId,
        parentName: parentName ?? this.parentName);
  }

  @override
  String toString() {
    return 'Category{categoryId=$categoryId, categoryName=$categoryName, parentId=$parentId, parentName=$parentName}';
  }
}
