import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_flutter/bloc/task_event.dart';
import 'package:task_flutter/bloc/task_state.dart';

import '../repository/repository.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository repository;

  static const _limit = 20;
  static const _maxTodos = 200;

  TodoBloc({required this.repository}) : super(
      const TodoState(todos: [], loading: false, hasReachedMax: false)) {
    on<FetchTodos>(_onFetchTodos);
  }

  Future<void> _onFetchTodos(FetchTodos event, Emitter<TodoState> emit) async {
    if (!state.hasReachedMax) {
      final startIndex = state.todos.length;
      try {
        emit(state.copyWith(loading: true));
        final todos = await repository.fetchTodos(startIndex, _limit);
        final allTodos = state.todos + todos;
        final hasReachedMax = allTodos.length >= _maxTodos;
        emit(state.copyWith(
            todos: allTodos, loading: false, hasReachedMax: hasReachedMax));
      } catch (e) {
        emit(state.copyWith(loading: false));
      }
    }
  }
}