import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StreamApp extends StatelessWidget {
  const StreamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        home: const StreamHome());
  }
}

List<String> names = [
  'Alice',
  'Bob',
  'Charlie',
  'David',
  'Eva',
  'Fiona',
  'George',
  'Hannah',
  'Isaac',
  'Jasmine',
  'Kevin',
  'Laura',
  'Michael',
  'Nina',
  'Oliver',
  'Penny',
  'Quincy',
  'Rachel',
  'Sam',
  'Tina'
];

final tickerProvider = StreamProvider<int>(
    (ref) => Stream.periodic(const Duration(seconds: 1), (i) => i + 1));

final streamProvider = StreamProvider((ref) {
  return ref
      .watch(tickerProvider.stream)
      .map((count) => names.getRange(0, count));
});

class StreamHome extends ConsumerWidget {
  const StreamHome({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final nameProvider = ref.watch(streamProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Stream Provider App"),
        ),
        body: nameProvider.when(
            data: (name) {
              return ListView.builder(
                  itemCount: names.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(names[index]),
                    );
                  });
            },
            error: (_, __) => const Center(
                  child: Text("Error"),
                ),
            loading: () => const Center(child: CircularProgressIndicator())));
  }
}
