part of 'department_bloc.dart';

class DepartmentState extends Equatable {
  const DepartmentState({
    required this.status,
    required this.departments,
    this.error
  });

  final BlocStatus status;
  final List<Department> departments;
  final String? error;

  @override
  List<Object> get props => [];
  DepartmentState copyWith({
    BlocStatus? status,
    List<Department>? departments,
    String? error    
  }) {
    return DepartmentState(
          status: status ?? this.status,
      departments: departments ?? this.departments,
      error: error ?? this.error
    );
  }
}
