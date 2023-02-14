import 'shopping_model.dart';
import 'main.dart';

class CRUDInterface {

  static void createElement(String name, double cost) {
    ShoppingModel purchase = ShoppingModel();
    purchase.name = name;
    purchase.cost = cost;
    purchase.createdDate = DateTime.now();
    purchaseBox.add(purchase);
  }
  static List<ShoppingModel> readAllElements() { return List<ShoppingModel>.from(purchaseBox.values); }

  static ShoppingModel? readElement(String key) { return purchaseBox.get(key); }

  static void updateElement(ShoppingModel element, String name, double cost) {
    element.name = name;
    element.cost = cost;
    element.save();
  }

  static void deleteElement(ShoppingModel element) { purchaseBox.delete(element.key); }
}