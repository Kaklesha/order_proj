import 'dart:convert';
import 'package:http/http.dart' as http;


class BackEnd {
  late String baseUrl;
  var client = http.Client();

  BackEnd({required this.baseUrl});

  void get() async {
    try {
      var response = await client.get(Uri.parse("$baseUrl/orders"));
      var userMap = jsonDecode(response.body);
      print(userMap);
    } catch (e) {
      print(e);
    }
  }

  void close() {
    client.close();
  }
}
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

