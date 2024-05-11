import 'package:equatable/equatable.dart';

class Department extends Equatable {
  const Department({this.id, this.name, this.parentId, this.parentName});
  final int? id;
  final String? name;
  final int? parentId;
  final String? parentName;

  Department copyWith(
      {int? id, String? name, int? parentId, String? parentName}) {
    return Department(
        id: id ?? id,
        name: name ?? name,
        parentId: parentId ?? parentId,
        parentName: parentName ?? parentName);
  }

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
        id: json['id'],
        name: json['name'],
        parentId: json['parentId'],
        parentName: json['parentName']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'parentId': parentId,
      'parentName': parentName
    };
  }

  @override
  List<Object?> get props => [id, name, parentId, parentName];
}
