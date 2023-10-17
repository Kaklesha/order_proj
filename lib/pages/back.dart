import 'dart:convert';
import 'package:http/http.dart' as http;


class LineItem {
  final int ItemID;
  final int Quantity;
  final int Price;
  LineItem({required this.ItemID,required this.Quantity,required this.Price});
}
class Order {
  final int OrderID;
  final int CustomerID;
  final List<LineItem> LineItems;
  final String Image;
  final DateTime? CreatedAt;
  final DateTime? ShippedAt;
  final DateTime? CompletedAt;

  Order({required this.OrderID, required this.CustomerID, required this.LineItems, required this.Image, required this.CreatedAt, required this.ShippedAt, required this.CompletedAt});
}


class BackEnd {
  late String baseUrl;
  var client = http.Client();

  BackEnd({required this.baseUrl});

  Future<List<Order>> get() async {
    List<Order> orders = [];
    try {
      var response = await client.get(Uri.parse("$baseUrl/orders"));
     // print(response.body);
      var userMap = jsonDecode(response.body);

      for (var o in userMap["items"]) {

        List<LineItem> items = [];
        for (var i in o["line_items"]) {
          LineItem ln = LineItem(ItemID: i["item_id"], Quantity: i["quantity"], Price: i["price"]);
          items.add(ln);

        }
        Order order = Order(OrderID: o["order_id"],
            CustomerID: o["customer_id"],
            LineItems: items, Image: o["image"],
            CreatedAt: o["created_at"] ==  null ? null : DateTime.tryParse(o["created_at"]),
            ShippedAt: o["shipped_at"] ==  null ? null : DateTime.tryParse(o["shipped_at"]),
            CompletedAt: o["completed_at"] ==  null ? null : DateTime.tryParse(o["completed_at"]));
        orders.add(order);
      }
    } catch (e) {
      print("Error $e");
    } finally {
      return orders;
    }
  }

  Future<void> post(Order order) async {
    try {
      var request = await client.post(
        Uri.parse("$baseUrl/orders"),
        body: json.encode({
          "customer_id": order.CustomerID,
          "line_items": [
            {
              "item_id": order.LineItems[0].ItemID,
              "quantity": order.LineItems[0].ItemID,
              "price": order.LineItems[0].ItemID,
            }
          ]
        }),
        headers: {
          "Content-Type": "application/json",
        },
      );
    } catch (e) {
      print("Error $e");
    }
  }


  Future<void> deleteByID(int id) async {
    try {
       await client.delete(
        Uri.parse("$baseUrl/orders/$id"),
        // body: json.encode(id),
        // headers: {
        //   "Content-Type": "application/json",
        // },
      );
    } catch (e) {
      print("Error $e");
    }
  }


  void close() {
    client.close();
  }
}


// {order_id: 1, customer_id: 1, line_items:
// [{item_id: 1, quantity: 5, price: 1999}],
// created_at: 2023-10-15T11:12:42.2880429Z,
// shipped_at: null, completed_at: null,
// image: http://10.0.2.2:3000/assets/images/4.png}
