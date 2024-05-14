import 'package:equatable/equatable.dart';

abstract class Entity extends Equatable {
  const Entity({this.entityId, this.entityName});
  final int? entityId;
  final String? entityName;
}
