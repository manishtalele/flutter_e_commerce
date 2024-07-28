import 'package:flutter_e_commerce/model/productmodel.dart';
import 'package:http/http.dart' as http;

class GetProductData {
  Future<ProductCard?> getData() async {
    var client = http.Client();

    var uri = Uri.parse("https://dummyjson.com/products");

    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return productCardFromJson(json);
    } else {
      return null;
    }
  }
}
