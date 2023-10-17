import 'package:flutter/material.dart';
import 'package:order_proj/pages/back.dart';

void main() {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  BackEnd be = BackEnd(baseUrl: "http://localhost:3000");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:


      FutureBuilder<List<Order>>(
        future: be.get(),
        builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {

          if (snapshot.hasData) {
              List<Order>? items = snapshot.data;
            if (items != null) {
              return ListView.builder(itemCount:items.length, itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index].OrderID.toString()),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(items[index].Image),
                  ),
                );
              });
            } else {
              return Center(child: Text("Empty"),);
            }
          } else if (snapshot.hasError) {
            return Column(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                ),
              ],
            );
          } else {
            return Column(
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                ),
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {

          });
        },
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
