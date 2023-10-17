import 'package:flutter/material.dart';
import 'package:order_proj/pages/back.dart';
import 'package:order_proj/pages/insert.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BackEnd be = BackEnd(baseUrl: "http://localhost:3000");

  void setHome(){
    setState(() {

    });
  }

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
                  leading:
                      CircleAvatar(
                        backgroundImage: NetworkImage(items[index].Image),
                      ),
                  trailing:
                  SizedBox(
                    height: 30,
                    width: 40,
                    child: FloatingActionButton(
                      onPressed: () {
                        be.deleteByID(items[index].OrderID);
                        setHome();
                      },
                      tooltip: 'Refresh',
                      child: const Icon(Icons.delete, size: 16,),
                    ),
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
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => InsertPage(setHome: setHome),)
          );
        },
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
