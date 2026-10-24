
abstract class CoffeeItem {
  String prepare();
}

abstract class Coffee extends CoffeeItem {
  String name;
  double price;
  String size;

  int _stock;

  Coffee(this.name, this.price, this.size, this._stock);

  int get stock => _stock;

  void displayInfo() {
    print('Coffee Name: $name');
    print('Price: PHP ${price.toStringAsFixed(2)}');
    print('Size: $size');
    print('Available Stock: $_stock');
    print('Preparation: ${prepare()}');
  }

  void buyCoffee(int quantity) {
    if (quantity <= 0) {
      print('Invalid quantity. Please enter a positive number.');
    } else if (quantity > _stock) {
      print('Sorry, not enough stock for $name.');
    } else {
      _stock -= quantity;
      double total = price * quantity;

      print('Successfully purchased $quantity $name.');
      print('Total Price: PHP ${total.toStringAsFixed(2)}');
      print('Remaining Stock: $_stock');
    }
  }
}
class HotCoffee extends Coffee {
  HotCoffee(String name, double price, String size, int stock)
      : super(name, price, size, stock);

  @override
  String prepare() {
    return 'Brewing with hot water.';
  }
}

class IcedCoffee extends Coffee {
  IcedCoffee(String name, double price, String size, int stock)
      : super(name, price, size, stock);

  @override
  String prepare() {
    return 'Mixing with ice and cold milk.';
  }
}

mixin ReceiptMixin {
  void printReceipt(String customerName, double total) {
    print('\n---------- COFFEE SHOP RECEIPT ----------');
    print('Customer: $customerName');
    print('Total: PHP ${total.toStringAsFixed(2)}');
    print('Thank you for ordering!');
    print('-----------------------------------------');
  }
}

class ReceiptPrinter with ReceiptMixin {}

void main() {
  List<Coffee> coffeeMenu = [
    IcedCoffee('Iced Latte', 129.00, 'Medium', 10),
    HotCoffee('Caramel Macchiato', 159.00, 'Large', 8),
  ];

  print('-----------------------------------------');
  print('       COFFEE SHOP MENU');
  print('-----------------------------------------');

  for (Coffee coffee in coffeeMenu) {
    print('');
    coffee.displayInfo();
    print('-----------------------------------------');
  }

  print('\n------ CUSTOMER PURCHASE ------');

  Coffee coffee1 = coffeeMenu[0];
  coffee1.buyCoffee(2);

  print('\n------ UPDATED STOCK ------');
  for (Coffee coffee in coffeeMenu) {
    print('${coffee.name} remaining stock: ${coffee.stock}');
  }

  print('\n------ STOCK VALIDATION TEST ------');
  coffeeMenu[1].buyCoffee(20);

  ReceiptPrinter printer = ReceiptPrinter();
  printer.printReceipt('Student', 129.00 * 2);
}
