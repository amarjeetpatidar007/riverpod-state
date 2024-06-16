import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


final dateProvider = Provider<DateTime>((ref) => DateTime.now());

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        home: const HomePage());
  }
}

class Counter extends StateNotifier<int?> {
  Counter() : super(null);
  void increment() => state = state == null ? 1 : state + 1;
  int? get value => state;
}

final counterProvider =
    StateNotifierProvider<Counter, int?>((ref) => Counter());

extension OptionalInfixAddition<T extends num> on T? {
  T? operator +(T? other) {
    final shadow = this;
    if (shadow != null) {
      return shadow + (other ?? 0) as T;
    } else {
      return null;
    }
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final date = ref.watch(dateProvider);
    // final counter =
    return Scaffold(
        appBar: AppBar(
          title: const Text("Hooks Riverpod"),
        ),
        body: Center(
          child: Column(
            children: [
              Consumer(builder: (context, ref, child) {
                final count = ref.watch(counterProvider);
                final text = count == null ? "Press button" : count.toString();
                return Text(text);
              }),
              TextButton(
                  onPressed: ref.read(counterProvider.notifier).increment,
                  child: const Text("Increment Counter"))
            ],
          ),
        ));
  }
}

// class MyWidget extends ConsumerWidget {
//   const MyWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return const Placeholder();
//   }
// }
