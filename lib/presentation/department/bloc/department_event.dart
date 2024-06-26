part of 'department_bloc.dart';

sealed class DepartmentEvent extends Equatable {
  const DepartmentEvent();

  @override
  List<Object> get props => [];
}

final class FetchAllDepartmentEvent extends DepartmentEvent {}

final class CreateDepartmentEvent extends DepartmentEvent {
  final Department department;
  const CreateDepartmentEvent({required this.department});
}

final class UpdateDepartmentEvent extends DepartmentEvent {
  final Department department;
  const UpdateDepartmentEvent({required this.department});
}

final class DeleteDepartmentEvent extends DepartmentEvent {
  final Department department;
  const DeleteDepartmentEvent({required this.department});
}
