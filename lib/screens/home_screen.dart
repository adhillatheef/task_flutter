import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../bloc/task_state.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool _isConnected = false;


  @override
  void initState() {

    super.initState();
    _checkInternetConnectivity();
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> _checkInternetConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _isConnected = connectivityResult != ConnectivityResult.none;
    });
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    setState(() {
      _isConnected = result != ConnectivityResult.none;
    });

    if (_isConnected) {
      BlocProvider.of<TodoBloc>(context).add(FetchTodos());
    }
  }
  @override
  Widget build(BuildContext context) {

    Future<void> onRefresh() async {
      BlocProvider.of<TodoBloc>(context).add(FetchTodos());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if(!_isConnected && state.todos.isEmpty){
            return  Center(
              child:  Lottie.asset(
                  repeat: true,
                  'assets/12701-no-internet-connection.json'),
            );
          }else if (state.loading && state.todos.isEmpty) {
            // return const Center(child: CircularProgressIndicator());
            return  ListView.builder(
              itemCount:10,
              itemBuilder: (context, index) {
                  return Shimmer(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey.withOpacity(0.5),
                      ),
                      title: Container(height: 10,
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey.withOpacity(0.5)
                      ),),
                      subtitle: Container(height: 10,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey.withOpacity(0.5)
                        ),),
                    ),
                  );
              },
            );
          } else if (state.hasReachedMax && state.todos.isEmpty) {
            return const Center(child: Text('No todos found'));
          } else {
            return RefreshIndicator(
              onRefresh: onRefresh,
              child: ListView.builder(
                itemCount: state.todos.length + (state.hasReachedMax ? 0 : 1),
                itemBuilder: (context, index) {
                  if (index >= state.todos.length) {
                    if(_isConnected){
                      BlocProvider.of<TodoBloc>(context).add(FetchTodos());
                      return Shimmer(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey.withOpacity(0.5),
                          ),
                          title: Container(height: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey.withOpacity(0.5)
                            ),),
                          subtitle: Container(height: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey.withOpacity(0.5)
                            ),),
                        ),
                      );
                    }else{
                     return Center(
                        child:  Lottie.asset(
                            repeat: true,
                            'assets/12701-no-internet-connection.json'),
                      );
                    }
                  } else {
                    final todo = state.todos[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(todo.id.toString()),
                      ),
                      title: Text(todo.title),
                      subtitle: Text('User ${todo.userId}'),
                    );
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }
}