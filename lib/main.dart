import 'package:blocandprov/Bloc/blocObserver.dart';
import 'package:blocandprov/data/provider/user_provider.dart';
import 'package:blocandprov/data/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Bloc/user/user_bloc.dart';
import 'Bloc/user/user_event.dart';
import 'Bloc/user/user_state.dart';
import 'data/model/userModel.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: RepositoryProvider(
          create: ((context) => UserRepository(UserProvider())),
          child: BlocProvider(
            create: (context) => UserBloc(context.read<UserRepository>()),
            child: const MyHomePage(),
          ),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Repository Provider"),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(
              child: Center(child: CircularProgressIndicator()),
            );
          }

          if (state is UserErrorState) {
            return Center(
              child: Center(child: Text('Error${state.error}')),
            );
          }

          if (state is UserSuccessState) {
            List<Datum> data = state.user.data;

            return data.isEmpty
                ? const Center(child: Text("No Data Founf"))
                : ListView.builder(
                    itemCount: data.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        child: Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(data[index].avatar),
                            ),
                            title: Text(data[index].firstName),
                            subtitle: Text(data[index].email),
                            trailing: const Icon(Icons.more_vert),
                          ),
                        ),
                      );
                    }));
          }
          return const Text('b');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          context.read<UserBloc>().add(LoadUserEvent());
        }),
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}




// import 'dart:developer';

// import 'package:blocandprov/Bloc/counter/counter_bloc.dart';
// import 'package:blocandprov/Bloc/visibility/visibility_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'Bloc/counter/counter_event.dart';
// import 'Bloc/counter/counter_state.dart';
// import 'Bloc/visibility/visibility_evebt.dart';
// import 'Bloc/visibility/visibility_state.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: MultiBlocProvider(
//           providers: [
//             BlocProvider<CounterBloc>(
//               create: (context) => CounterBloc(),
//             ),
//             BlocProvider<VisibilityBloc>(
//               create: (context) => VisibilityBloc(),
//             ),
//           ],
//           child: const MyHomePage(title: 'Flutter Demo Home Page'),
//         )

//         // BlocProvider<CounterBloc>(
//         //   create: (context) => CounterBloc(),
//         //   child: const MyHomePage(title: 'Flutter Demo Home Page'),
//         // ),
//         );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             BlocBuilder<CounterBloc, CounterState>(
//               buildWhen: (previous, current) {
//                 if (previous.count == current.count) {
//                   return false;
//                 } else {
//                   return true;
//                 }
//               },
//               builder: ((context, state) {
//                 return Text(state.count.toString());
//               }),
//             ),
//             BlocBuilder<VisibilityBloc, VisibilityState>(
//                 builder: ((context, state) {
//               return Visibility(
//                   visible: state.show,
//                   child: Container(
//                     height: 100,
//                     width: 100,
//                     color: Colors.blue,
//                   ));
//             })),
//             BlocListener<CounterBloc, CounterState>(
//               listener: ((context, state) {
//                 if (state.count == 3) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Count is ${state.count}')));
//                 }
//               }),
//               child: const Text("Block listner"),
//             )
//           ],
//         ), 
//       ),

//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             onPressed: (() {
//               context.read<CounterBloc>().add(CounterIncreamentEvent());
//             }),
//             tooltip: 'Increment',
//             child: const Icon(Icons.add),
//           ),
//           const SizedBox(
//             width: 20,
//           ),
//           FloatingActionButton(
//             onPressed: (() {
//               context.read<CounterBloc>().add(CounterDecrementEvent());
//             }),
//             tooltip: 'Decrement',
//             child: const Icon(Icons.do_not_disturb_on),
//           ),
//           const SizedBox(
//             width: 20,
//           ),
//           FloatingActionButton(
//             onPressed: (() {
//               log('Show${context.read<VisibilityBloc>().state.show} ');
//               context.read<VisibilityBloc>().add(VisibilityTrue());
//             }),
//             tooltip: 'Show',
//             child: const Text('Show'),
//           ),
//           const SizedBox(
//             width: 20,
//           ),
//           FloatingActionButton(
//             onPressed: (() {
//               log('Hide${context.read<VisibilityBloc>().state.show} ');
//               context.read<VisibilityBloc>().add(VisibilityFalse());
//             }),
//             tooltip: 'Hide',
//             child: const Text('Hide'),
//           ),
//         ],
//       ),

//       // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
