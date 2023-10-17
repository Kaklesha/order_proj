import 'package:flutter/material.dart';
import 'package:order_proj/pages/back.dart';


class InsertPage extends StatefulWidget {
  const InsertPage({Key? key}) : super(key: key);

  @override
  State<InsertPage> createState() => _InsertPageState();
}

class _InsertPageState extends State<InsertPage> {

BackEnd be = BackEnd(baseUrl: "http://localhost:3000");

  int c_id = 0;
  int i_id = 0;
  int quant = 0;
  int price = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Страница ввода данных"),
        ),
        body: Container(
          child:  Column(
            children: [
              TextField(onChanged: (text){
                c_id=int.parse(text);
              },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Введите ID пользователя",
                    helperText: "CustomerID"
                ),),
              SizedBox(height: 16.0),
              TextField(onChanged: (text){
                i_id=int.parse(text);
              },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "ваааааааа",
                    helperText: "CustomerID"
                ),),
              SizedBox(height: 16.0),
              TextField(onChanged: (text){
                quant=int.parse(text);
              },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Введите ID пользователя",
                    helperText: "CustomerID"
                ),),
              SizedBox(height: 16.0),
              TextField(onChanged: (text){
                price=int.parse(text);
              },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Введите ID пользователя",
                  helperText: "CustomerID",

                ),),
              ElevatedButton(
                  onPressed: (){
                 Order o = Order(OrderID: 0, CustomerID: c_id, LineItems: [LineItem(ItemID: i_id, Quantity: quant, Price: price)], Image: '', CreatedAt: null, ShippedAt: null, CompletedAt: null);

                   // Order o= Order(OrderID: OrderID, CustomerID: CustomerID, LineItems: LineItems, Image: Image, CreatedAt: CreatedAt, ShippedAt: ShippedAt, CompletedAt: CompletedAt)
                  be.post(o);
                  },
                  child: Text("butt") )
            ],
          ),
        )

    );


  }
}