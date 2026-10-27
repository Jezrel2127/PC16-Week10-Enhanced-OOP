
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

  Future<String> buyCoffeeAsync(int quantity) async {
    if (quantity <= 0) {
      return 'Invalid quantity. Please enter a positive number.';
    }

    if (quantity > _stock) {
      return 'Sorry, not enough stock for $name.';
    }

    await Future.delayed(Duration(seconds: 2));

    _stock -= quantity;
    double total = price * quantity;

    return 'Successfully purchased $quantity $name. '
        'Total: PHP ${total.toStringAsFixed(2)}. '
        'Remaining stock: $_stock.';
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

Future<void> main() async {
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

  print('\n------ ASYNC CUSTOMER PURCHASE ------');

  Coffee coffee1 = coffeeMenu[0];

  print('Submitting order for 2 ${coffee1.name}...');
  print('Please wait for the order confirmation.');

  Future.delayed(Duration(seconds: 1), () {
    print('The program is still running while the order is processed.');
  });


  String result = await coffee1.buyCoffeeAsync(2);

  print('\n$result');

  print('\n------ UPDATED STOCK ------');
  for (Coffee coffee in coffeeMenu) {
    print('${coffee.name} remaining stock: ${coffee.stock}');
  }

  print('\n------ STOCK VALIDATION TEST ------');
  coffeeMenu[1].buyCoffee(20);

  ReceiptPrinter printer = ReceiptPrinter();
  printer.printReceipt('Student', 129.00 * 2);
}
