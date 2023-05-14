import 'package:equatable/equatable.dart';

import '../model/todo_model.dart';

class TodoState extends Equatable {
  final List<Todo> todos;
  final bool loading;
  final bool hasReachedMax;

  const TodoState({
    required this.todos,
    required this.loading,
    required this.hasReachedMax,
  });

  @override
  List<Object?> get props => [todos, loading, hasReachedMax];

  TodoState copyWith({
    List<Todo>? todos,
    bool? loading,
    bool? hasReachedMax,
  }) {
    return TodoState(
      todos: todos ?? this.todos,
      loading: loading ?? this.loading,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}