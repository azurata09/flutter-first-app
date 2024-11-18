import 'package:flutter/material.dart';
import 'package:foip_my_app/Idol.dart';
import 'package:foip_my_app/IdolCard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // fetchIdols();

    return MaterialApp(
      title: 'iM@S Idol Colors',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'iM@S Idol Colors'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Idol>> futureIdols;

  @override
  void initState() {
    super.initState();
    futureIdols = fetchIdols();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: FutureBuilder(
              future: futureIdols,
              builder: (ctx, snapshot) {
                if (snapshot.hasData) {
                  final List<Idol> data = snapshot.data!;
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (ctx, idx) {
                      var item = data[idx];
                      return IdolCard(
                        idolName: item.name,
                        idolColor: item.color,
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  debugPrint(snapshot.error.toString());
                  return const Text('エラー');
                }
                return const Text('不明');
              })),
    );
  }
}
