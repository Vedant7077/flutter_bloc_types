// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_types/features/counter/bloc/counter_bloc.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  CounterBloc counterBloc = CounterBloc();
  @override
  void initState() {
    counterBloc.add(CounterIncrementEvent());
    super.initState();
  }

  int val = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("Counter Page"),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              counterBloc.add(CounterIncrementEvent());
            }),
        body: BlocConsumer<CounterBloc, CounterState>(
          bloc:counterBloc,
          listenWhen: (previous, current) => current is CounterActionState,
          buildWhen: (previous, current) => current is !CounterActionState,
          listener: (context, state) {
            if(state is CounterShowSnacbarActionState){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Snackbar')));
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case CounterIncrementState:
              final successState = state as CounterIncrementState;
              return Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      successState.val.toString(),
                      style: TextStyle(fontSize: 60),
                    ),
                    const SizedBox(height: 20,),
                    ElevatedButton(onPressed: (){
                      counterBloc.add(CounterShowSnackBarEvent());
                    }, child: Text('snackbar')),
                  ],
                ),
              ),
            );

              default:
              return Center(child: Text('Not Found'),);
            }
          },
        )        );
  }
}
